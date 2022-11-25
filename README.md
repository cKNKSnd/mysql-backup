# 数据库备份服务

备份使用的脚本文件放在[scirpt文件夹里](./script/)

备份出来的数据使用Volume挂在到F盘的备份文件夹中，具体的路径[详见](./docker-compose.yml)

## How to use

### 步骤一

修改 [docker-compose.yml](./docker-compose.yml) 文件中的

```yaml
volumes:
      - ./script:/root/script   #不要修改
      # 修改备份出的数据库数据所在数据卷在本机挂载的路径
      - /path/to/store/backup/data:/data/mysqlbak 
```

根据MySQL数据库数据备份模板文件 [mysqlbak_sample.sh](./script/mysqlbak_sample.sh) 结合自己数据库的实际配置进行修改，修改`dbserver, dbport`等参数


然后再修改 [backup.sh](./script/backup.sh) 文件，将上面写好的数据库备份文件运行脚本写入，例如

```bash
#!/bin/bash
echo 'Start backup data...'
/root/script/mysqlbak_sample.sh
echo 'end backing data..'
```

> PS: `crontab里面设置运行的脚本文件，包括脚本文件中运行的脚本文件，都需要使用全路径`

### 步骤二

Linux系统下运行 `./run.sh`, Windows系统下运行 `.\run.bat`

## 使用

### 查看日志

1. 在本机terminal输入 `docker logs database-backup-mysql-backup-1` 查看日志
2. 打开 [entrypoint.log](./script/entrypoint.log) 查看，日志内容同上
3. 打开数据库备份在本机的挂载路径，找到 `mysqlback.log` 文件，查看单个数据库备份脚本的日志

### 查看cron定时任务是否正在运行

进入容器，输入

```bash
service cron status
```

### 查看已经设置的定时任务

进入容器，输入

```bash
crontab -l
```