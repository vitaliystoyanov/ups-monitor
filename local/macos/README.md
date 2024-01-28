https://gist.github.com/hdml/fcad80f6d483709f5e51133669e8b7ca

sudo cp ~/nut-upsd/local/macos/LaunchAgents/org.networkupstools.bcmxcp.plist /Library/LaunchDaemons/org.networkupstools.bcmxcp.plist
sudo cp ~/nut-upsd/local/macos/LaunchAgents/org.networkupstools.upsd.plist /Library/LaunchDaemons/org.networkupstools.upsd.plist
sudo cp ~/nut-upsd/local/macos/LaunchAgents/org.networkupstools.upsd_restarter.plist /Library/LaunchDaemons/org.networkupstools.upsd_restarter.plist

launchd runs Daemons (/Library/LaunchDaemons or /System/Library/LaunchDaemons) as root, and will run them regardless of whether users are logged in or not. Launch Agents (/Library/LaunchAgents/ or ~/Library/LaunchAgents/) are run when a user is logged in as that user. You can not use setuid to change the user running the script on daemons.

Because you will want to add it in /Library/LaunchDaemons you will want to make sure you load it into launchd with administrator privileges (eg. sudo launchctl load -w /Library/LaunchDaemons/com.apple.samplelaunchdscript.plist)

sudo launchctl load -w /Library/LaunchDaemons/org.networkupstools.bcmxcp.plist
sudo launchctl load -w /Library/LaunchDaemons/org.networkupstools.upsd.plist
sudo launchctl load -w /Library/LaunchDaemons/org.networkupstools.upsd_restarter.plist

To unload:
sudo launchctl unload -w /Library/LaunchDaemons/org.networkupstools.bcmxcp.plist
sudo launchctl unload -w /Library/LaunchDaemons/org.networkupstools.upsd.plist
sudo launchctl unload -w /Library/LaunchDaemons/org.networkupstools.upsd_restarter.plist
rm /Library/LaunchDaemons/org.networkupstools.bcmxcp.plist
rm /Library/LaunchDaemons/org.networkupstools.upsd.plist

Check:
sudo launchctl list | grep 'networkups'

Stop:
sudo launchctl stop org.networkupstools.upsd
