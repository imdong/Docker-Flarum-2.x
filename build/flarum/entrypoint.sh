#!/bin/sh

set -e

# 初始化安装 Flarum (首次运行时)
if [ -z "$(ls -A)" ]; then
    # 部署 Flarum 程序
    composer create-project flarum/flarum:${FLARUM_VERSION} .

    # 安装 Flarum 数据库
    echo -e "databaseConfiguration:\n  host: mysql\n  password: ${MYSQL_ROOT_PASSWORD}\n  prefix: flarum_" > /www/flarum-install-config.yaml
    php flarum install --file=/www/flarum-install-config.yaml

    # 初始化插件开发目录
    mkdir packages
    composer config repositories.0 path "packages/*"
fi

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- php-fpm "$@"
fi

exec "$@"
