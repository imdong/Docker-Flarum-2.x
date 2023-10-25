#!/bin/sh

set -e

echo "Start /init-other.sh"

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

    # 切入目录执行安装
    cd framework
    yarn install
}

# 检查是否初始化 flarum/framework
if [ ! -z "${FLARUM_FRAMEWORK_INIT}" ]; then
    echo "Install Flarum Framework"
    flarum_framework
fi
