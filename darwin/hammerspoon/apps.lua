-- quick open
local super = {"ctrl", "alt" }

  if app and name == 'Safari' then
    hs.osascript.applescriptFromFile('applescripts/openApp.applescript')
  end

function open_app(appName, bundleID)
  app = hs.appfinder.appFromName(appName)
  if app then
    if app:isFrontmost() then
      return
    else
      app:activate()
      app:unhide()
    end
  else
    hs.application.launchOrFocusByBundleID(bundleID)
  end
end

-- Apps
-- osascript -e 'id of app "Finder"'

hs.hotkey.bind(super, "c", open_app("Visual Studio Code", "com.microsoft.VSCode"))
hs.hotkey.bind(super, "s", open_app("Safari", "com.apple.Safari"))
hs.hotkey.bind(super, "p", open_app("System Settings", "com.apple.systempreferences"))
hs.hotkey.bind(super, "g", open_app("Ghostty", "com.mitchellh.ghostty"))
hs.hotkey.bind(super, "f", open_app("Finder", "com.apple.finder"))
-- show shortcut
hs.hotkey.bind(super, "/", open_app("Finder", "com.apple.finder"))
-- mission control
-- google calendar
-- google mail
