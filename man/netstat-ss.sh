#!/usr/bin/env bash

netstat -s | grep "packets received"  # ���һЩ����ͳ��.
netstat -s | grep "packets delivered"

sudo netstat -anp | grep 3306
netstat -lntp # �鿴���м����˿�
netstat -antp # �鿴�����Ѿ�����������
netstat -s # �鿴����ͳ����Ϣ
pstack 7013
# ͨ��pid�鿴ռ�ö˿�
netstat -nap | grep ����pid
# ����ͨ��nginx���̲鿴��Ӧ�Ķ˿ں�
ps -ef | grep nginx
netstat -nap | grep nginx-pid
# �����鿴8081�Ŷ˿ڶ�Ӧ�Ľ�����
netstat -nap | grep 8081

# -l, --listening ��ʾ����״̬���׽��� --tcp ����ʾ TCP�׽��֣�sockets��
# -n --numeric ��������������
ss -ltn
# ��ʾTCP����
ss -t -a
# �鿴����ʹ�õ�socket
ss -pl