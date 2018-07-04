# autonomous installation of hosting dependencies, apps and config

# boom! hosting

# not sure exactly why Tomcat has to be installed before apache2 - but this is the only way to make hosting work.
/DietPi/dietpi/dietpi-software install 125

# apache2
apt-get install apache2 -y ;
sudo systemctl stop apache2.service ;

sleep 2

# put files in right places

rm -r /etc/apache2/sites-enabled/000-default.conf
rm -r /etc/apache2/sites-available/000-default.conf
cp /var/WaveOS/modeless/features/hosting/000-default.conf /etc/apache2/sites-enabled/
# /var/WaveOS/modeless/features/hosting/000-default.conf /etc/apache2/sites-available/

rm -r /etc/apache2/apache2.conf
cp /var/WaveOS/modeless/features/hosting/apache2.conf /etc/apache2/

rm -r /usr/lib/cgi-bin
mkdir /usr/lib/cgi-bin
cp /var/WaveOS/modeless/features/modes/* /usr/lib/cgi-bin/
chown 755 /usr/lib/cgi-bin
chmod 755 /usr/lib/cgi-bin
cd /usr/lib/cgi-bin
chmod 755 uid.pl
chown 755 uid.pl
cd
# sleep 2

sudo systemctl start apache2.service ;

# Then we need CGI & Perl running, so the buttons on the mode-select menu will run mode-activation script
cd /etc/apache2/mods-enabled
ln -sT ../mods-enabled/cgi.load cgi.load
cd

a2enmod cgid
a2enconf serve-cgi-bin

#  create symbolic links
ln -s /etc/apache2/mods-available/cgid.load /etc/apache2/mods-enabled/
ln -s /etc/apache2/mods-available/cgid.conf /etc/apache2/mods-enabled/

# restart - always important
systemctl restart apache2
service apache2 restart

# this is required for the update process
sudo apt-get install subversion -y
