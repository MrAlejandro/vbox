#!/usr/bin/env bash
export DEBIAN_FRONTEND=noninteractive

sudo add-apt-repository ppa:ondrej/php

debconf-set-selections <<< 'mysql-server mysql-server/root_password password r0Ot'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password r0Ot'

wget -O - https://packagecloud.io/gpg.key | sudo apt-key add -
echo "deb http://packages.blackfire.io/debian any main" | sudo tee /etc/apt/sources.list.d/blackfire.list

sudo apt-get update
sudo apt-get upgrade --yes

sudo apt-get install --yes \
    unzip \
    nginx \
    mysql-server-5.6 \
    git

for ver in '7.1' '5.6'; do
    sudo apt-get install --yes \
        php$ver-cli php$ver-mysql php$ver-fpm php$ver-curl php$ver-gd php$ver-xml php$ver-mbstring php$ver-zip php$ver-sqlite3 php$ver-mcrypt php$ver-intl php$ver-soap php$ver-imagick \
        php-xdebug \
        blackfire-agent

    sudo sed -i".bak" 's/;sendmail_path =.*/sendmail_path=\/srv\/sendmail\/sendmail/g' /etc/php/$ver/fpm/php.ini
    sudo sed -i".bak" 's/post_max_size =.*/post_max_size = 1G/g'                       /etc/php/$ver/fpm/php.ini
    sudo sed -i".bak" 's/upload_max_filesize =.*/upload_max_filesize = 1G/g'           /etc/php/$ver/fpm/php.ini
    
    sudo cp /srv/etc/php/mods-available/xdebug.ini /etc/php/$ver/mods-available/xdebug.ini
    sudo service php$ver-fpm restart
done

sudo rm -rf /etc/nginx/sites-enabled/*
cd /etc/nginx/sites-available/
for i in *
do
    if [[ "${i}" != "template" ]]; then
        sudo ln -s /etc/nginx/sites-available/$i /etc/nginx/sites-enabled/$i
    fi
done
sudo service nginx restart

sudo sed -i".bak" 's/bind-address.*/bind-address=0.0.0.0/g' /etc/mysql/my.cnf
sudo service mysql restart

cp /srv/.profile /home/vagrant/.profile
cp /srv/.vimrc /home/vagrant/.vimrc
