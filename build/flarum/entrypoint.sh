#!/bin/sh

set -e

# 初始化安装 Flarum (首次运行时)
if [ -z "$(ls -A)" ]; then
    composer create-project flarum/flarum:${FLARUM_VERSION} .
    mkdir packages
    composer config repositories.0 path "packages/*"
fi

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- php-fpm "$@"
fi

exec "$@"
