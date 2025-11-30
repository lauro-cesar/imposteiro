#!/bin/bash
python3 bump_version.py

cd ..
godot45 --export-release HTML5 --headless
rsync -azv builds/web/ ../docs/


#docker stop english_key_game
#docker rm english_key_game
#docker build . -t registry.hostcert.com.br/deploy/english-key-web:latest --push
#docker create --name english_key_game --restart always -p 10.8.0.3:7072:80 registry.hostcert.com.br/deploy/english-key-web:latest
#docker start english_key_game
