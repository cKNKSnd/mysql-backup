#!/bin/sh

set -e

# 执行自定义的内容
# 启动 cron 定时服务
service cron start

# 设置定时备份服务
rm -f backup.cron
touch backup.cron
echo "10 10 * * * /root/script/backup.sh >> /root/script/entrypoint.log 2>&1" > backup.cron
# 以下是备份功能测试
# echo "* * * * * echo 'Hello world' >> /root/script/entrypoint.log 2>&1" >> backup.cron
crontab /root/script/backup.cron

# 打印日志
rm -f entrypoint.log
touch entrypoint.log
echo ""
date >> ./entrypoint.log
echo "设置定时任务" >> ./entrypoint.log
crontab -l >> ./entrypoint.log
echo "=================================" >> ./entrypoint.log

# 输出日志到docker log
tail -f /root/script/entrypoint.log