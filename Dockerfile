FROM ubuntu:jammy
WORKDIR /root/script
# 修改apt source
RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak
RUN touch /ect/apt/sources.list & echo 'deb http://mirrors.aliyun.com/ubuntu/ jammy main restricted universe multiverse' > /etc/apt/sources.list
# 更新apt
RUN apt update
# 安装软件：cron用于设置定时任务，mysql-client-core用于使用mysqldump工具进行数据库备份，tzdata是时区信息数据
RUN apt install cron -y
RUN apt install mysql-client-core-8.0 -y
RUN apt install tzdata -y
# 设置时区
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
# 拷贝脚本文件
COPY ./script /root/script/
CMD [ "./entrypoint.sh" ]