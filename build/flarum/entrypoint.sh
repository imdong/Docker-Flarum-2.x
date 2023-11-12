#!/bin/sh

set -e

# 初始化 flarum/framework
flarum_framework() {
    # 没有传递仓库地址 就使用官方默认地址
    if [ -z "${FLARUM_FRAMEWORK_GIT}" ]; then
        FLARUM_FRAMEWORK_GIT="https://github.com/flarum/framework.git"
    fi

    # 检查是否指定了分支
    other_options=""
    if [ -z "${FLARUM_FRAMEWORK_BRANCH}" ]; then
        other_options="${other_options} --branch ${FLARUM_FRAMEWORK_BRANCH}"
    fi

    # 添加开发索引目录
    composer config repositories.1 path "framework/*/*"

    # clone 仓库
    git clone ${other_options} "${FLARUM_FRAMEWORK_GIT}" framework

    # 使用 dev 版本
    composer config minimum-stability "dev"
    composer require flarum/core "*@dev"

    # 切入目录执行安装
    cd framework
    yarn install
}

# 初始化安装 Flarum (首次运行时)
if [ -z "$(ls -A)" ]; then
    echo "$(pwd) directory is empty, Flarum Install..."

    # 部署 Flarum 程序 选择仓库来源
    if [ "${FLARUM_VERSION}" == "git" ]; then
        git clone https://github.com/flarum/flarum.git .
    else
        composer create-project flarum/flarum:${FLARUM_VERSION} .
    fi

    # 初始化插件开发目录
    mkdir packages
    composer config repositories.0 path "packages/*"

    # 检查是否初始化 flarum/framework
    if [ ! -z "${FLARUM_FRAMEWORK_INIT}" ]; then
        echo "Install Flarum Framework"
        flarum_framework
    fi

    # 安装 Flarum 数据库
    echo "Install Flarum To Database..."
    echo -e "databaseConfiguration:\n  host: mysql\n  password: ${MYSQL_ROOT_PASSWORD}\n  prefix: flarum_" >/www/flarum-install-config.yaml
    php /www/flarum install --file=/www/flarum-install-config.yaml
else
    echo "/www directory is not empty, skip Flarum Install..."
fi

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
    set -- php-fpm "$@"
fi

exec "$@"
