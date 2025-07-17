###############################################################################
# there has been a cache problem on system update
# defaults read > ~/full_preferences.plist
# sudo rm ~/Library/Preferences/.GlobalPreferences.plist
# nil: multicolor
# -1: graphite
# 0: red
# 1: orange
# 2: yellow
# 3: green
# 4: blue
# 5: purple
# 6: pink

# `defaults read .GlobalPreferences`
###############################################################################
defaults write -g AppleAccentColor -int 4
# just follow the accent color
defaults delete -g AppleHighlightColor
# defaults write -g AppleHighlightColor -string "0.698039 0.843137 1.000000 Blue"


# cat << EOF > ~/Library/LaunchAgents/com.user.fixaccent.plist
# <?xml version="1.0" encoding="UTF-8"?>
# <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
# <plist version="1.0">
# <dict>
#     <key>Label</key>
#     <string>com.user.fixaccent</string>
#     <key>ProgramArguments</key>
#     <array>
#         <string>/usr/bin/defaults</string>
#         <string>write</string>
#         <string>-g</string>
#         <string>AppleAccentColor</string>
#         <string>-int</string>
#         <string>4</string>
#     </array>
#       <array>
#         <string>/usr/bin/defaults</string>
#         <string>delete</string>
#         <string>-g</string>
#         <string>AppleHighlightColor</string>
#     </array>
#     <key>RunAtLoad</key>
#     <true/>
# </dict>
# </plist>
# EOF
#
# launchctl load ~/Library/LaunchAgents/com.user.fixaccent.plist


###############################################################################
# Device                                                                     #
###############################################################################
# Used for local network service discovery,.local suffix is added for you
sudo scutil --set LocalHostName orangzz
# see in finder machine name, airdrop, screen sharing service device name,are resolved using Multicast DNS (Bonjour) by defaultr
sudo scutil --set ComputerName {name}.device
# resolve using dns server, The name provided to the DHCP server
sudo scutil --set HostName <new host name>


###############################################################################
# Service
# see https://developer.apple.com/documentation/servicemanagement
# start service on login meaning writing(or copying, or symlinking) a plist file to `~/Library/LaunchAgents` for single user  and `/Library/LaunchAgents` for all users.
# The plist, which stands for "property list", act as instructions to launchctl
# `launch Daemons` - managed by launchd, runs as root and run before any users have logged on to the system. plist file can be found at `/Library/LaunchDaemons`
# `Launch Agents` - run on behalf of the currently logged-in user. plist can be found at `/Library/LaunchDaemons`
# `System Daemon` - plist can be found at `/System/Library`, owned and installed by Apple
# `Login Items` - list of apps to launch after user logged in. continues running until the user logs out or manually quits.
###############################################################################





###############################################################################
# Wallpaper                                                                      #
###############################################################################


# Library/Application Support/Dock/desktoppicture.db
# MacOS Sonomoa uses a plist file instead
# plutil -p ~/Library/Application\ Support/com.apple.wallpaper/Store/Index.plist
# downloaded wallpapers are saved to `/Library/Application\Support/com.apple.idleassetsd`

###############################################################################
# Dock                                                                    #
###############################################################################





# view member of group
# dscacheutil -q group -a name <group_name>
# view groups user belong to
# id -Gn <username>


###############################################################################
# Finder                                                                      #
###############################################################################

# always on list view
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
# Show path bar
defaults write com.apple.finder ShowPathbar -bool true
# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true
# Show hidden files `cmd+shift+.`
defaults write com.apple.finder AppleShowAllFiles true
# Search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true
# default location for new window
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

killall Finder



###############################################################################
# Dock - backup and restore macos dock settings
# `defaults read com.apple.dock`
# `defaults read com.apple.dock persistent-apps`
# - Dock spacers
###############################################################################
# defaults delete com.apple.dock; killall Dock # reset the dock to default state
defaults write com.apple.dock persistent-apps -array # clear presistent app in dock

defaults read com.apple.dock orientation left
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock tilesize -int 54

defaults write com.apple.dock minimize-to-application -bool true
defaults write com.apple.dock mineffect -string "genie"

defaults write com.apple.dock launchanim -bool false



echo "✅ Dock apps configured"

# Restart Dock to apply changes
echo "🔄 Restarting Dock..."
killall Dock
