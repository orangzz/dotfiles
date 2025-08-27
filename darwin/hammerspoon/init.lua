-- defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/.config/hammerspoon/init.lua"
hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall.user_syncinstall = true
spoon.SpoonInstall:andUse("AClock")
spoon.SpoonInstall:andUse("ReloadConfiguration")
hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

require("commands")
require("apps")
require("windows")

return {
  init = module_init
}
