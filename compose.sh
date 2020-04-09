#!/bin/bash

# ./compose.sh "up -d" dev

# Descrição
# - $0 = ./compose.sh
# - $1 = "up -d"
# - $2 = dev

echo "Running docker-compose $1..."

DIR=./front

if [[ "$(ls -A ${DIR})" ]]; then

    FILE=./front/Dockerfile

    if [[ ! -f "$FILE" ]]; then
        yes | cp ./docker/node/Dockerfile ./front/
    fi

    case "$2" in
        dev|"")
            yes | cp .env-dev .env
            yes | cp ./docker/nginx/back/default-dev.conf ./docker/nginx/back/default.conf

            rm -f acme.json

            sudo docker-compose $1 --remove-orphans
        ;;
        prod)
            yes | cp .env-prod .env
            yes | cp ./docker/nginx/back/default-prod.conf ./docker/nginx/back/default.conf

            touch acme.json
            sudo chmod 600 acme.json

            sudo docker-compose -f docker-compose.yml -f docker-compose.prod.yml $1 --remove-orphans
    esac

else
    echo "A pasta 'front' está vazia, antes de continuar, crie primeiro o projeto."
fi
