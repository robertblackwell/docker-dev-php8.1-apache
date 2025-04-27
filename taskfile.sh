function build {
    docker build \
    --no-cache \
    -t apache-php-image .
}

function up {
     run
}

function down {
    stop
}

function run {
    # build
    docker compose up
}

function stop {
    docker compose down  --remove-orphans
}

function start_standalone {
#function start {
    docker run -ti \
        -p 8080:80 \
        -v ./html:/var/www/html \
        --name apache-php-running \
        --rm \
        apache-php-image
}

function stop_standalone {
#function stop {
    docker kill apache-php-running
}

function exec {
    docker exec -it apache-php-running /bin/bash
}



function help {
    echo "$0 <task> <args>"
    echo "Tasks:"
    compgen -A function | cat -n
}

TIMEFORMAT="Task completed in %3lR"
time ${@:-help}
