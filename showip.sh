#!/bin/bash
year=`date +%Y`
month=`date +%m`
day=`date +%d`
logs_backup_path="/var/log/nginx/$year$month"
rq=`date -d "1 days ago" +%Y%m%d`
read -p $'请输入查看类型: \x0a \033[31m1. 所有IP及次数\033[0m \x0a \033[32m2.仅ip列表\033[0m \x0a \033[33m3.不同ip数\033[0m \x0a \033[35m4.扒开爬虫外的ip列表\033[0m \x0a' flag
read -p $'请输入日志前缀:' head
echo $flag
if [ "$flag" -eq '1' ];
then
 awk '{print $1}' $logs_backup_path/"$head"_nginx_access_${rq}.log |sort -n |uniq -c |sort -rn
elif [ "$flag" -eq '2' ];
then
 awk '{print $1}' $logs_backup_path/"$head"_nginx_access_${rq}.log |sort -n |uniq -c |sort -rn|awk '{print $2}'
elif [ "$flag" -eq '3' ];then
 awk '{print $1}' $logs_backup_path/${head}_nginx_access_${rq}.log |sort -n|uniq -c |wc -l
elif [ "$flag" -eq '4' ];then
 awk '{print $1}' $logs_backup_path/"$head"_nginx_access_${rq}.log |sort -n|uniq -c|sort -rn|awk '{print $2}'|grep -v '116.255'|grep -v '108.162'|grep -v '111.206'|grep -v '162.158'|grep -v '172.6'|grep -v '173.245'|grep -v "106.11"|grep -v "120.133"|grep -v "123.125"|grep -v "66.249"|grep -v "157.55.39"|grep -v "220.181"|grep -v "36.110"|grep -v "40.77"|grep -v "42.120"|grep -v "42.156"|grep -v "42.236"|grep -v "54.36"|grep -v "52.53"
else
 exit
fi
