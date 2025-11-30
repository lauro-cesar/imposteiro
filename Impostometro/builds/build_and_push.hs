#!/bin/bash

python3 bump_version.py
rsync -azv web/assets/ deploy@10.8.0.11:/home/deploy/gamerstash_api/gamerstash_src/static/assets/

cd ..
godot4 --export-release HTML5 --headless
cd builds
docker stop english_key_game
docker rm english_key_game
docker build . -t registry.hostcert.com.br/deploy/english-key-web:latest --push
docker create --name english_key_game --restart always -p 10.8.0.3:7072:80 registry.hostcert.com.br/deploy/english-key-web:latest
docker start english_key_game
