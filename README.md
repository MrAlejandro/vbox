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

### cli [Original](https://gist.github.com/Im0rtality/9710254)

# In host:

1. Go to PHPStorm `Settings > Project settings > PHP > Servers`
2. Add server with following parameters:
    - Name: `vagrant` (same as `serverName=` in `debug` script)
    - Host, port: set vagrant box IP and port
    - Debugger: Xdebug
    - [v] Use path mappings
    - Map your project root in host to relative dir in guest
    - Hit OK
3. PHPStorm > Run > Start listen for PHP Debug connections
4. Put a breakpoint

# In guest:

1. Find where your Xdebug config is stored. Run `$ php -i | grep ini` and look for `*xdebug.ini` or `*custom.ini` - depends on configuration (mine was in `/etc/php5/cli/conf.d/zzzz_custom.ini`)
2. Add following `xdebug.remote_host = 11.22.33.1`, when box ip is `11.22.33.*`
3. Create file `/usr/bin/debug` with contents added below (file `debug` below)
4. Make it executable `$ sudo chmod 0777 /usr/bin/debug`
5. Run your script prefixed with `debug`:
    - `$ debug php index.php cache:clear`
6. Debugger window should open in IDE

# Script
```
#!/bin/sh
env PHP_IDE_CONFIG="serverName=vagrant" XDEBUG_CONFIG="idekey=PHPSTORM" $@

# for Symfony apps use following
# env PHP_IDE_CONFIG="serverName=vagrant" XDEBUG_CONFIG="idekey=PHPSTORM" SYMFONY_DEBUG="1" $@
```
