FROM mysql:8.0
WORKDIR /root/script
# 重新生成MySQL的公钥
RUN gpg --keyserver keyserver.ubuntu.com --recv-keys 467B942D3A79BD29
# 导入公钥，加入到apt的信任密钥
RUN gpg --export --armor 467B942D3A79BD29 | apt-key add -
# 修改apt source
RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak
RUN touch /ect/apt/sources.list & echo 'deb http://mirrors.aliyun.com/debian/ buster main non-free contrib' > /etc/apt/sources.list
# 更新apt
RUN apt update
RUN apt install cron -y
# 设置时区
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
# 拷贝脚本文件
COPY ./script /root/script/
CMD [ "./entrypoint.sh" ]