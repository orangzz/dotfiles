function _generateChangelog(prevVersion, version) {}

function _pushCommit(version) {
  log(`Pushing commit to changelog/v${version}`)
  run(`git checkout -b changelog/v${version}`)
  run(`git add CHANGELOG.md`)
  run(`git commit -m "changelog: Add changelog for v${version}`)
  run(`git push origin changelog/v${version}`)
}

async function _createPR(version, token) {
  log(`Creating changelog pr`)
  const url = 'https://api.github.com/repos/orangzz/dotfiles/pulls'
  const body = `
## Summary
Add Changelog for ${version}
  `
  const response = await fetch(url, {
    method: 'POST',
    headers: {
      Accept: 'Accept: application/vnd.github+json',
      'X-GitHub-Api-Version': '2022-11-28',
      Authorization: `Bearer ${token}`,
    },
    body: JSON.stringify({
      title: `changelog: Add changelog for v${version}`,
      head: `changelog/v${version}`,
      base: 'main',
      body: body,
    }),
  })
  const data = await response.json()
  if (response.status !== 201) {
    throw new Error(`
      Failed to create PR
      received status code ${response.status}
      ${data.message}\n${JSON.stringify(data.errors)}`)
  }
  return data.html_url
}

async function generateChangelog(version, token) {
  if (version.startsWith('v')) {
    version = version.substring(1)
  }

  const previousVersion = await _computePreviousVersionFrom(version)
  if (previousVersion) {
    log(`Previous version is ${previousVersion}`)
    _generateChangelog(previousVersion, version, token)
    _pushCommit(version)
    const prURL = await _createPR(version, token)
    log(`Created PR: ${prURL}`)
  }
}

module.exports = {
  generateChangelog,
}
