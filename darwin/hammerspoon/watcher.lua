

function appWatcher(appName, eventType)
  if (appName == 'Ghostty' or appName == 'kitty') then
  end
  if (eventType == hs.application.watcher.deactivated) then
    if (appName == 'Ghostty' or appName == 'kitty') then
      hs.osascript.applescriptFromFile('applescripts/ghostty.applescript')
    end
end


appWatcher = hs.application.watcher.new(appWatcher)
appWatcher:start()
