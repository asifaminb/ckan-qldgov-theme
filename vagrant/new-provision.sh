echo "switching the OS language"
sudo locale-gen
export LC_ALL="en_US.UTF-8"
sudo locale-gen en_US.UTF-8

echo "updating the package manager"
sudo apt-get update
sudo apt-get install -y nginx apache2 libapache2-mod-wsgi libpq5 redis-server git-core

echo "downloading the CKAN package"
wget http://packaging.ckan.org/python-ckan_2.7-trusty_amd64.deb
sudo dpkg -i python-ckan_2.7-trusty_amd64.deb
service apache2 reload

echo "install postgresql and jetty"
sudo apt-get install -y postgresql

echo "create a CKAN database in postgresql"
sudo -u postgres createuser -S -D -R ckan_default
sudo -u postgres psql -c "ALTER USER ckan_default with password 'pass'"
sudo -u postgres createdb -O ckan_default ckan_default -E utf-8

echo "initialize CKAN database"
sudo cp /vagrant/vagrant/package_production.ini /etc/ckan/default/production.ini
sudo ckan db init

echo "copying jetty configuration"
sudo apt-get install -y solr-jetty
sudo cp /vagrant/vagrant/jetty /etc/default/jetty
wget https://launchpad.net/~vshn/+archive/ubuntu/solr/+files/solr-jetty-jsp-fix_1.0.2_all.deb
sudo dpkg -i solr-jetty-jsp-fix_1.0.2_all.deb
sudo service jetty restart
sudo service jetty start


sudo mv /etc/solr/conf/schema.xml /etc/solr/conf/schema.xml.bak
sudo ln -s /usr/lib/ckan/default/src/ckan/ckan/config/solr/schema.xml /etc/solr/conf/schema.xml
sudo service jetty restart

sudo ckan db init
sudo service apache2 restart
sudo service nginx restart
