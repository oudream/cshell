#!/usr/bin/env bash

# �鿴�������½�ɹ���IP��ַ������
grep "Accepted password for root" /var/log/auth.log | awk '{print $11}' | sort | uniq -c | sort -nr | more

# �鿴�������½ʧ�ܵ�IP��ַ������
grep "Failed password for root" /var/log/auth.log | awk '{print $11}' | sort | uniq -c | sort -nr | more

# ����Ĭ�϶˿�
sed -i.bak "s/Port .*/Port 9122/g" /etc/ssh/sshd_config

