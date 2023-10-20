# Docker Flarum

使用 Docker 一键启动 Flarum 运行环境，支持 Flarum 扩展包开发

## 使用说明

首次启动，先复制 `sample.env` 文件到 `.env` 并适当修改该目录内容(默认内容可以正常使用)
然后 `docker compose up -d` 启动即可，会自动配置环境，首次启动会自动安装 Flarum，并配置好开发环境。

Falrum 会安装到同级 `./www` 目录下，插件开发目录在 `./www/packages`，当前目录下的 `./www` 会映射到容器内的 `/www` 目录下

如果需要进入开发容器，则执行 `docker compose exec app sh`

开发插件可直接进入插件目录 `docker compose exec --workdir /www/packages app sh`

构建 js 只需要  `docker compose exec --workdir /www/packages/flarum-ext-hello-world/js app npm run dev`，注意，请将 `flarum-ext-hello-world` 改成你插件的目录名

启动成功后，访问 [http://flarum.localhost](http://flarum.localhost)` 即可进入论坛首页，

默认管理员账号: `admin`
默认管理员密码: `password`

## 数据库管理

默认提供数据库管理地址为 [http://flarum.localhost/adminer.php](http://flarum.localhost/adminer.php)

数据库地址请填写 `mysql`

默认数据库 root 密码为 `123456`，首次启动容器前可修改 `.env` 配置文件，启动后修改无效。
