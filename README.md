# Whiteacorn apache2 installation

All the vhosts now work.

https://www.pascallandau.com/blog/phpstorm-docker-xdebug-3-php-8-1-in-2022/
Good reference for docker commands
[https://www.digitalocean.com/community/tutorials/how-to-remove-docker-images-containers-and-volumes](https://www.digitalocean.com/community/tutorials/how-to-remove-docker-images-containers-and-volumes)

[https://medium.com/@komalminhas.96/a-step-by-step-guide-to-build-and-push-your-own-docker-images-to-dockerhub-709963d4a8bc](https://medium.com/@komalminhas.96/a-step-by-step-guide-to-build-and-push-your-own-docker-images-to-dockerhub-709963d4a8bc)

I am getting sick of struggling to configure `apache2` on my osx machines using the `home brew` version of that package.

So I decided to make a docker container that would allow easy deployment of a suitable apache2 on any machine.

The goal is to have `apache2` + `vhosts` + `php8.1` + `php error reporting` and `xdebug` 

So far I have all of this except the `vhosts` - that will be fine for the moment.

This enviornment uses `docker compose` to launch a php/apache server and an mysql server. The `./taskfile` contains a list of commands for running common task.

## Running the environment

There is something wrong in the `docker composer up` does not produce the container I expect.

However `docker run ....` as coded in `taskfile.sh start-standalone` does - so for the moment
only use `taskfile.sh` with these arguments.

| command | function |
| ------- | ---------|
| ./taskfile.sh start-standalone| starts a contain using the docker run command |
| ./taskfile.sh stop-standalone | stops the container with the docker kill command |
| ./taskfile.sh build | builds the image directly from the docker file |
| ./taskfile.sh up | do not use |
| ./taskfile.sh down | do not use |
| ./taskfile.sh run | do not use |
| ./taskfile.sh stop | do not use |


The output from the `build` operation is named `apache-php-image` which is an input into the `start-standalone` command.

The output from the `start-standalone` command is named `apache-php-running` which is an input to the `stop-sandalone` command.

**Starting**

The following will launch 2 docker containers one with php/apache and another with mysql

```sh
/taskfile start
```

**Stopping** 

The following with stop both containers

```sh
./taskfile stop
```

## The PHP & Apache docker image

The php/apache container has some small customizations and hence
needs to be built when changes are made.

Below are the commands for building and running the php/apache docker image

**Build**

```sh
./taskfile build
```

**Run**

```sh
./taskfile start-standalone
```


**To kill the container** 

```sh
./taskfile stop-standalone
```

**SSH into running container**

Look into the script to see how to change the command to ssh into 
either the php/apache server or the mysql server.

```sh
./taskfile exec
```

### Xdebug setup in the apache docker image

The instructions to install xdebug (__NOTE__ version 3) in the docker image are in the Dockerfile.

Beware many of the online tutorials are for xdebug 2. Here are a couple of references that I used.

[a good reference 1](https://matthewsetter.com/setup-step-debugging-php-xdebug3-docker/)

[a bit more detail](https://www.pascallandau.com/blog/phpstorm-docker-xdebug-3-php-8-1-in-2022/)
However xdebug must be configured. How is this done ?


(another)[https://gist.github.com/megahirt/e80086d1d029a7406e9eaec1fb1dcc9e]
In this project directory is a folder __php__ which was copied from the running docker server before the config process started with the command

```sh
sudo docker cp wa-php-server:/usr/local/etc/php ./
```

The the file `./php/conf.d/docker-php-ext-xdebug.ini` was modified to have the following content:

```conf
[xdebug]
zend_extension=xdebug
xdebug.mode=develop,debug
xdebug.client_host="host.docker.internal"
xdebug.start_with_request=yes
xdebug.log=/tmp/xdebug_remote.log
```
This is in file `./php/conf.d/docket-php-ext-xdebug.ini`

The __vscode__ launch file to match this, and provide for local host pht debugging is in file `./launch.json` in this 
project root.