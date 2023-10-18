# Docker Flarum

使用 Docker 一键启动 Flarum 运行环境，支持 Flarum 扩展包开发

## 使用说明

首次启动，只需要 `docker compose up -d` 即可，会自动配置环境，自动安装 Flarum，并配置好开发环境。

Falrum 会安装到 www 目录下，插件开发目录在 `/www/packages`

如果需要进入容器，则执行 `docker compose exec app sh`

开发插件可直接进入插件目录 `docker compose exec --workdir /www/packages app sh`

构建 js 只需要  `docker compose exec --workdir /www/packages/flarum-ext-hello-world/js app npm run dev`

## 安装 Flarum

默认提供数据库管理地址为 `http://127.0.0.1/adminer.php`

数据库地址请填写 `mysql`
