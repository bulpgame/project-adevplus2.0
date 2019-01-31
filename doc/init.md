Sample init scripts and service configuration for adevplus20d
==========================================================

Sample scripts and configuration files for systemd, Upstart and OpenRC
can be found in the contrib/init folder.

    contrib/init/adevplus20d.service:    systemd service unit configuration
    contrib/init/adevplus20d.openrc:     OpenRC compatible SysV style init script
    contrib/init/adevplus20d.openrcconf: OpenRC conf.d file
    contrib/init/adevplus20d.conf:       Upstart service configuration file
    contrib/init/adevplus20d.init:       CentOS compatible SysV style init script

1. Service User
---------------------------------

All three Linux startup configurations assume the existence of a "adevplus20core" user
and group.  They must be created before attempting to use these scripts.
The OS X configuration assumes adevplus20d will be set up for the current user.

2. Configuration
---------------------------------

At a bare minimum, adevplus20d requires that the rpcpassword setting be set
when running as a daemon.  If the configuration file does not exist or this
setting is not set, adevplus20d will shutdown promptly after startup.

This password does not have to be remembered or typed as it is mostly used
as a fixed token that adevplus20d and client programs read from the configuration
file, however it is recommended that a strong and secure password be used
as this password is security critical to securing the wallet should the
wallet be enabled.

If adevplus20d is run with the "-server" flag (set by default), and no rpcpassword is set,
it will use a special cookie file for authentication. The cookie is generated with random
content when the daemon starts, and deleted when it exits. Read access to this file
controls who can access it through RPC.

By default the cookie is stored in the data directory, but it's location can be overridden
with the option '-rpccookiefile'.

This allows for running adevplus20d without having to do any manual configuration.

`conf`, `pid`, and `wallet` accept relative paths which are interpreted as
relative to the data directory. `wallet` *only* supports relative paths.

For an example configuration file that describes the configuration settings,
see `contrib/debian/examples/adevplus20.conf`.

3. Paths
---------------------------------

3a) Linux

All three configurations assume several paths that might need to be adjusted.

Binary:              `/usr/bin/adevplus20d`  
Configuration file:  `/etc/adevplus20core/adevplus20.conf`  
Data directory:      `/var/lib/adevplus20d`  
PID file:            `/var/run/adevplus20d/adevplus20d.pid` (OpenRC and Upstart) or `/var/lib/adevplus20d/adevplus20d.pid` (systemd)  
Lock file:           `/var/lock/subsys/adevplus20d` (CentOS)  

The configuration file, PID directory (if applicable) and data directory
should all be owned by the adevplus20core user and group.  It is advised for security
reasons to make the configuration file and data directory only readable by the
adevplus20core user and group.  Access to adevplus20-cli and other adevplus20d rpc clients
can then be controlled by group membership.

3b) Mac OS X

Binary:              `/usr/local/bin/adevplus20d`  
Configuration file:  `~/Library/Application Support/Adevplus20Core/adevplus20.conf`  
Data directory:      `~/Library/Application Support/Adevplus20Core`
Lock file:           `~/Library/Application Support/Adevplus20Core/.lock`

4. Installing Service Configuration
-----------------------------------

4a) systemd

Installing this .service file consists of just copying it to
/usr/lib/systemd/system directory, followed by the command
`systemctl daemon-reload` in order to update running systemd configuration.

To test, run `systemctl start adevplus20d` and to enable for system startup run
`systemctl enable adevplus20d`

4b) OpenRC

Rename adevplus20d.openrc to adevplus20d and drop it in /etc/init.d.  Double
check ownership and permissions and make it executable.  Test it with
`/etc/init.d/adevplus20d start` and configure it to run on startup with
`rc-update add adevplus20d`

4c) Upstart (for Debian/Ubuntu based distributions)

Drop adevplus20d.conf in /etc/init.  Test by running `service adevplus20d start`
it will automatically start on reboot.

NOTE: This script is incompatible with CentOS 5 and Amazon Linux 2014 as they
use old versions of Upstart and do not supply the start-stop-daemon utility.

4d) CentOS

Copy adevplus20d.init to /etc/init.d/adevplus20d. Test by running `service adevplus20d start`.

Using this script, you can adjust the path and flags to the adevplus20d program by
setting the ADV2D and FLAGS environment variables in the file
/etc/sysconfig/adevplus20d. You can also use the DAEMONOPTS environment variable here.

4e) Mac OS X

Copy org.adevplus20.adevplus20d.plist into ~/Library/LaunchAgents. Load the launch agent by
running `launchctl load ~/Library/LaunchAgents/org.adevplus20.adevplus20d.plist`.

This Launch Agent will cause adevplus20d to start whenever the user logs in.

NOTE: This approach is intended for those wanting to run adevplus20d as the current user.
You will need to modify org.adevplus20.adevplus20d.plist if you intend to use it as a
Launch Daemon with a dedicated adevplus20core user.

5. Auto-respawn
-----------------------------------

Auto respawning is currently only configured for Upstart and systemd.
Reasonable defaults have been chosen but YMMV.
