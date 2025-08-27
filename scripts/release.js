import { createRequire } from 'node:module';
import semver from 'semver';
import prompts from 'prompts';
import c from 'picocolors';
import { execa } from 'execa';
import { readFileSync, writeFileSync } from 'node:fs';
import { resolve } from 'node:path';
import { fileURLToPath } from 'node:url';

const { inc: _inc, valid } = semver;

const { version: currentVersion } = createRequire(import.meta.url)('../package.json');

const versionIncrements = ['patch', 'minor', 'major'];

const tags = ['latest', 'next'];

const dir = fileURLToPath(new URL('.', import.meta.url));
const inc = (i) => _inc(currentVersion, i);
const run = (bin, args, opts = {}) => execa(bin, args, { stdio: 'inherit', ...opts });
const step = (msg) => console.log(c.cyan(msg));

async function main() {
  let targetVersion;

  const versions = versionIncrements.map((i) => `${i} (${inc(i)})`).concat(['custom']);

  const { release } = await prompts({
    type: 'select',
    name: 'release',
    message: 'Select release type',
    choices: versions,
  });
  if (release === 3) {
    targetVersion = await prompts({
      type: 'text',
      name: 'version',
      message: 'Input custom version',
      initial: currentVersion,
    }).version;
  } else {
    targetVersion = versions[release].match(/\((.*)\)/)[1];
  }

  if (!valid(targetVersion)) {
    throw new Error(`Invalid target version: ${targetVersion}`);
  }

  const { tag } = await prompts({
    type: 'select',
    name: 'tag',
    message: 'Select tag type',
    choices: tags,
  });

  const { yes: tagOk } = await prompts({
    type: 'confirm',
    name: 'yes',
    message: `Releasing v${targetVersion} on ${tags[tag]}. Confirm`,
  });
  if (!tagOk) {
    return;
  }

  step('\n Bumping the package version ...');
  bumpVersion(targetVersion);

  step('\n Building the package...');
  await run('pnpm', ['build']);

  step('\nLogging recent commit...');
  const firstRelease = await isFirstRelease();
  const previousRef = await getPreviousReference();
  if (firstRelease) {
    // For first release, show all commits
    await run('git', ['log', '--pretty=format:%s', '--no-merges']);
  } else {
    // For subsequent releases, show commits since last tag
    await run('git', ['log', '--pretty=format:%s', `${previousRef}..HEAD`, '--no-merges']);
  }

  step('\n Generating the changelog...');
  const changelogPath = resolve(dir, '..', 'docs/CHANGELOG.md');
  if (firstRelease) {
    // For first release, use the --first-release flag
    await run('pnpm', [
      'conventional-changelog',
      '--preset',
      'angular',
      '--infile',
      'docs/CHANGELOG.md',
      '--outfile',
      'docs/CHANGELOG.md',
      '--first-release',
    ]);
  } else {
    // For subsequent releases, append new release to existing changelog
    await run('pnpm', [
      'conventional-changelog',
      '--preset',
      'angular',
      '--infile',
      'docs/CHANGELOG.md',
      '--outfile',
      'docs/CHANGELOG.md',
      '--append',
    ]);
  }

  await run('pnpm', ['prettier', '--write', 'docs/CHANGELOG.md']);

  const { yes: changelogOk } = await prompts({
    type: 'confirm',
    name: 'yes',
    message: 'Changelog generated. Does it look good?',
  });
  if (!changelogOk) {
    return;
  }
  const { stdout } = await run('git', ['diff'], { stdio: 'pipe' });
  if (stdout) {
    step('\nCommitting changes and tag version...');
    await run('git', ['add', 'docs/CHANGELOG.md', 'package.json']);
    await run('git', ['commit', '-m', `release: v${targetVersion}`]);
    await run('git', ['tag', `v${targetVersion}`]);
  } else {
    console.log('No changes to commit');
    return;
  }

  // step('\nPublishing the package...');
  // await run('pnpm', ['publish', '--tag', tags[tag], '--ignore-scripts', '--no-git-check']);

  step('\nPushing to GitHub...');
  await run('git', ['push', 'origin', `refs/tags/v${targetVersion}`]);
  const { stdout: currentBranch } = await run('git', ['branch', '--show-current'], {
    stdio: 'pipe',
  });
  await run('git', ['push', '--set-upstream', 'origin', currentBranch.trim()]);
}

function bumpVersion(version) {
  const pkgPath = resolve(dir, '..', 'package.json');
  const pkg = JSON.parse(readFileSync(pkgPath), 'utf-8');

  pkg.version = version;
  writeFileSync(pkgPath, JSON.stringify(pkg, null, 2) + '\n');
}

async function isFirstRelease() {
  const { stdout } = await run('git', ['tag', '-l'], { stdio: 'pipe' });
  return !stdout.trim();
}
async function getPreviousReference() {
  try {
    const { stdout } = await run('git', ['describe', '--tags', '--abbrev=0'], { stdio: 'pipe' });
    return stdout.trim();
  } catch {
    // If no tags exist, get the first commit
    const { stdout } = await run('git', ['rev-list', '--max-parents=0', 'HEAD'], {
      stdio: 'pipe',
    });
    return stdout.trim();
  }
}

main().catch((err) => console.error(err));

// onAbuseLimit
// onRateLimit
