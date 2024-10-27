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
    build
    docker compose up
}

function stop {
    docker compose down
}

function start-standalone {
    docker run -ti \
        -p 8080:80 \
        -v ./html:/var/www/html \
        --name apache-php-running \
        --rm \
        apache-php-image
}

function stop-standalone {
    docker kill apache-php-running
}

function exec {
    docker exec -it apache-php-server /bin/bash
}



function help {
    echo "$0 <task> <args>"
    echo "Tasks:"
    compgen -A function | cat -n
}

TIMEFORMAT="Task completed in %3lR"
time ${@:-help}