#!/bin/bash
#数据库IP
dbserver='localhost'
#数据库端口
dbport='3306'
#数据库用户名
dbuser='root'
#数据密码
dbpasswd='root'
#数据库,如有多个库用空格分开
dbname='db_sample'
#备份时间
backtime=`date +%Y%m%d`
#备份输出日志路径
logpath='/data/mysqlbak/medicine'
#备份路数据库径
datapath='/data/mysqlbak/medicine'

echo "################## ${backtime} #############################" 
echo "开始备份" 
#日志记录头部
echo "" >> ${logpath}/mysqlback.log
echo "-------------------------------------------------" >> ${logpath}/mysqlback.log
echo "备份时间为${backtime},备份数据库表 ${dbname} 开始" >> ${logpath}/mysqlback.log

echo ""
echo "-------------------------------------------------" 
echo "备份时间为${backtime},备份数据库表 ${dbname} 开始"
#正式备份数据库
for table in $dbname; do
source=`mysqldump -h ${dbserver} -P ${dbport} -u ${dbuser} -p${dbpasswd} ${table} > ${logpath}/${table}-${backtime}.sql` 2>> ${logpath}/mysqlback.log;
# source=`mysqldump --all-databases -u ${dbuser} -p${dbpasswd} > ${logpath}/${backtime}.sql` 2>> ${logpath}/mysqlback.log;
#备份成功以下操作
if [ "$?" == 0 ];then
cd ${datapath}
#为节约硬盘空间，将数据库压缩
# tar zcf ${table}-${backtime}.tar.gz ${table}-${backtime}.sql > /dev/null
#sendmail
#uuencode ${table}-${backtime}.tar.gz langfang_${table}-${backtime}.tar.gz | mail -s LangFang_${backtime}_DB_Backup 1134394251@qq.com
#uuencode ${table}-${backtime}.tar.gz langfang_${table}-${backtime}.tar.gz | mail -s LangFang_${backtime}_DB_Backup ldfq@163.com
#uuencode ${table}-${backtime}.tar.gz langfang_${table}-${backtime}.tar.gz | mail -s LangFang_${backtime}_DB_Backup liudefu@dfusion.cn
# mail -s LangFang_${backtime}_DB_Backup ldf@dfusion.cn 1134394251@qq.com ldfq@163.com -A ${table}${backtime}.tar.gz < content.txt
#删除原始文件，只留压缩后文件
# rm -f ${datapath}/${table}-${backtime}.sql
#删除七天前备份，也就是只保存7天内的备份
find $datapath -name "*.tar.gz" -type f -mtime +7 -exec rm -rf {} \; > /dev/null 2>&1
echo "数据库表 ${table} 备份成功!!" >> ${logpath}/mysqlback.log
echo "数据库表 ${table} 备份成功!!"
else
#备份失败则进行以下操作
echo "数据库表 ${table} 备份失败!!" >> ${logpath}/mysqlback.log
echo "数据库表 ${table} 备份失败!!"
fi
done
echo "完成备份"
echo "################## ${backtime} #############################"
