#!/usr/bin/env bash


## ����̵��߳���Ϣ
# ͨ��/procα�ļ�ϵͳ��
cat /proc/{pid}/status

# ����Threads������ľ����߳�����
# ���ߣ�ͨ��
ls /proc/{pid}/task | wc -l

# top��������-H�����ӡ�������߳��б�
top -H
top -H -p {pid}

# ps �������H���ܴ�ӡĳ�����̵������߳�
ps hH p {pid} | wc -l

# ʹ��ps�������鿴���̵�ʱ�򣬽���״̬�ֱ��Ӧ�ĺ������£�
# D    �����ж�˯�� (ͨ������IO����) �յ��źŲ����ѺͲ�������, ���̱���ȴ�ֱ�����жϷ���
# R   �������л�����У������ж����Ŷ��У�
# S   ���ж�˯�� (������, ����, �ڵȴ�ĳ���������γɻ���ܵ��ź�)
# T   ��ֹͣ�� �����յ�SIGSTOP, SIGSTP, SIGTIN, SIGTOU�źź�ֹͣ����
# W   ���ڻ�ҳ(2.6.�ں�֮ǰ��Ч)
# X   ������ (δ����)
# Z   ��ʬ����  ��������ֹ, ����������������, ֱ�������̵���wait4()ϵͳ���ú��ͷ�BSD����
# <   �����ȼ�(not nice to other users)
# N   �����ȼ�(nice to other users)
# L   ҳ���������ڴ棨ʵʱ�Ͷ��Ƶ�IO��
# s   һ����Ϣͷ
# l   ���̣߳�ʹ�� CLONE_THREAD����NPTL��pthreads��������
# +   ��ǰ̨������

# ʹ��pstree����
# ��ӡ���н��̼����߳�
pstree -p
# ��ӡĳ�����̵��߳���
pstree -p {pid} | wc -l

# �޸�ĳ���˻��Ŀ�������߳������
cat /etc/security/limits.d/20-nproc.conf

# Default limit for number of user's processes to prevent
# accidental fork bombs.
# See rhbz #432903 for reasoning.
*          soft    nproc     1024      # ���˴��޸ĳ�unlimited����������ֵ
root       soft    nproc     unlimited

# ����ﵽ��ϵͳ��������ֵ���ٴ����߳�ʱ�ᱨ����ʱ������½ssh�����ܵǲ���ȥ����~
-bash: fork: retry: û���ӽ���
-bash: fork: retry: ��Դ��ʱ������
