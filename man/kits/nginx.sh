#!/usr/bin/env bash


### nginx
nginx -c "/ddd/web/nginx/conf-hello-svg/nginx.conf"
nginx -t -c "/ddd/web/nginx/conf-hello-svg/nginx.conf" # 只测试配置文件

