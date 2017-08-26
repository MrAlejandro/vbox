Forked from https://bitbucket.org/torunar/pepyakabox

# vbox #

Vagrant box for amateur PHP development.

Pepyakas included.

## What's under the hood?

### nginx

Somewhat "universal" config can be found in `/etc/nginx/sites-available/template`.

### MySQL 5.6

Default user: `root`.

Default password: `r0Ot`.

### PHP

Both FPM and CLI.

Available versions:

* 5.6
* 7.1

Available modules:

* mysql
* curl
* gd
* xml
* mbstring
* zip
* sqlite3
* mcrypt
* intl
* soap
* imagick
* xdebug

### git

`__git_ps1` and git autocomplete included.

### E-mail catcher

Catches all e-mails sent with `mail()` PHP function and stores them under `/srv/sendmail/log`.

### BlackFire Agent

Not configured, though.

## How do I shot the web?

1. Install VirtualBox and Vagrant

2. Clone the repo:

	```
	$ git clone git@bitbucket.org:torunar/pepyakabox.git pepyakabox
	```

3. Provision the enviroment:

	```
	$ cd pepyakabox
	```
	```
	$ vagrant up
	```

4. Configure nginx hosts using provided template config (or write your own).

5. All done.

## Using PHPStrom + Vagrant + Xdebug

### In a browser
1. The the xdebug config ```/etc/php/7.1/mods-available/xdebug.ini``` should contain the following lines 
```
zend_extension=xdebug.so
xdebug.remote_enable=1
xdebug.remote_host=10.4.4.1
xdebug.remote_connect_back=true
xdebug.idekey=PHPSTORM
xdebug.overload_var_dump=off
```
2. Configure server in the PHPStrom ```Preferences -> languages & Frameworks -> PHP -> Servers```, with the ```use path mapping``` option enabled. [This](https://www.theodo.fr/blog/2016/08/configure-xdebug-phpstorm-vagrant/) may help.
3. Add debug configuration in ```Run -> Edit Configurations```
4. Install and configure xdebug helper extension for web browser

### cli

