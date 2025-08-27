mkdir ~/.config/npm
npm list -g --depth=0

# npm config get prefix
#`npm config ls --depth=0`
# npm config get prefix
# $N_PREFIX/lib/node_modules - installed packages
# $N_PREFIX/bin - installed executables

# config file
# Per-project config file: `$PROJECT_DIR/.npmrc`
# Per-user config file: `$HOME/.npmrc`
# Global config file: `$(npm config get prefix)/etc/npmrc`
# Built-in npm config file: `$(npm config get prefix)/lib/node_modules/npm/.npmrc`



# environment variables with `npm_config_` prefix

# flag on the command line `--save-dev` `--save`

# process.env.npm_package_config_


# npm config set
