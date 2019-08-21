#!/bin/bash
year=`date +%Y`
month=`date +%m`
day=`date +%d`
logs_backup_path="/var/log/nginx/$year$month"               #日志存储路径

logs_path="/var/log/nginx/"                                                             #要切割的日志路径
logs_access1="d_nginx_access"                                                           #要切割的日志
logs_access2="v_nginx_access"                                                           #要切割的日志
logs_access3="vpn_nginx_access"                                                           #要切割的日志
logs_access4="zd_nginx_access"                                                           #要切割的日志

logs_error1="d_nginx_error"
logs_error2="v_nginx_error"
logs_error3="vpn_nginx_error"
logs_error4="zd_nginx_error"
pid_path="/usr/local/nginx/logs/nginx.pid"                                                 #nginx的pid

[ -d $logs_backup_path ]||mkdir -p $logs_backup_path
rq=`date +%Y%m%d`
for ((i=1; i<=4; i++))
do
eval logs_access='$'{"logs_access$i"}
eval logs_error='$'{"logs_error$i"}
mv ${logs_path}${logs_access}.log ${logs_backup_path}/${logs_access}_${rq}.log
mv ${logs_path}${logs_error}.log ${logs_backup_path}/${logs_error}_${rq}.log
done
kill -USR1 $(cat /usr/local/nginx/logs/nginx.pid)
