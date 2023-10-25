ARG PHP_VERSION
FROM php:${PHP_VERSION}-fpm-alpine

# 换源加速apk安装
ARG ALPINE_REPOSITORIES
RUN if [ "${ALPINE_REPOSITORIES}" != "" ]; then \
    sed -i "s/dl-cdn.alpinelinux.org/${ALPINE_REPOSITORIES}/g" /etc/apk/repositories; \
    fi

# 安装基础环境包
ARG TZ
ARG APK_ADD_PACKS
RUN apk update \
    && apk --no-cache add tzdata nodejs npm git ${APK_ADD_PACKS} \
    && cp "/usr/share/zoneinfo/$TZ" /etc/localtime \
    && echo "$TZ" > /etc/timezone

# 安装 Composer
COPY --from=composer /usr/bin/composer /usr/bin/composer
ENV COMPOSER_HOME="/usr/local/composer" PATH="/usr/local/composer/vendor/bin:${PATH}"

# 安装 PHP 扩展 与 npm 包
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/bin/
ARG PHP_EXTENSIONS
ARG NPM_INSTALL_GLOBAL_PACKS
RUN export MC="-j$(nproc)" \
    && install-php-extensions ${PHP_EXTENSIONS} \
    && npm install -g ${NPM_INSTALL_GLOBAL_PACKS} \
    && mkdir -p /var/www/html/adminer

# 安装 Adminer 管理器
COPY --from=adminer /var/www/html/ /var/www/html/adminer

# 启动脚本
COPY ./*.sh /
ENTRYPOINT ["/entrypoint.sh"]

# 运行目录
WORKDIR /www

CMD ["php-fpm"]
