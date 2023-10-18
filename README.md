# Docker Flarum

使用 Docker 一键启动 Flarum 运行环境，支持 Flarum 扩展包开发

## 使用说明

如果需要进入容器，则执行 `docker compose exec app sh`

开发插件可直接进入插件目录 `docker compose exec --work /www/packages app sh` 

## 安装 Flarum

数据库地址请填写 `mysql`
