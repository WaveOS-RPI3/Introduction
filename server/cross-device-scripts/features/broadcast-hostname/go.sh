# will install Avahi-Daemon: to connect to the unit without needing ip addresses

/DietPi/dietpi/dietpi-software install 152 

# tried this - didn't seem to work
apt-get install insserv
insserv avahi-daemon
/etc/init.d/avahi-daemon restart

# tried this - didn't seem to work

mv /var/WaveOS/server/cross-device-scripts/features/broadcast-hostname/dnsmasq.txt /etc/default/
mv /etc/default/dnsmasq.txt /etc/default/dnsmasq




