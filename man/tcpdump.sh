#!/usr/bin/env bash


       tcpdump [ -AbdDefhHIJKlLnNOpqStuUvxX# ] [ -B buffer_size ]
               [ -c count ]
               [ -C file_size ] [ -G rotate_seconds ] [ -F file ]
               [ -i interface ] [ -j tstamp_type ] [ -m module ] [ -M secret ]
               [ --number ] [ -Q in|out|inout ]
               [ -r file ] [ -V file ] [ -s snaplen ] [ -T type ] [ -w file ]
               [ -W filecount ]
               [ -E spi@ipaddr algo:secret,...  ]
               [ -y datalinktype ] [ -z postrotate-command ] [ -Z user ]
               [ --time-stamp-precision=tstamp_precision ]
               [ --immediate-mode ] [ --version ]
               [ expression ]


# tcpdump Ĭ��ֻ���ȡǰ 96 �ֽڵ����ݣ�Ҫ���ȡ���еı������ݣ�����ʹ�� -s number�� number
#    ������Ҫ��ȡ�ı����ֽ���������� 0 �Ļ�����ʾ��ȡ����ȫ�����ݡ�
# 
# -n ��ʾ��Ҫ����������ֱ����ʾ ip��
# -nn ��Ҫ���������Ͷ˿�
# -X ͬʱ�� hex �� ascii ��ʾ���ĵ����ݡ�
# -XX ͬ -X����ͬʱ��ʾ��̫��ͷ����
# -S ��ʾ���Ե����кţ�sequence number������������Ա�š�
# -i any �������е�����
# -v, -vv, -vvv����ʾ�������ϸ��Ϣ
# -c number: ��ȡ number �����ģ�Ȼ�����
# -A�� ֻʹ�� ascii ��ӡ���ĵ�ȫ�����ݣ���Ҫ�� -X һ��ʹ�á���ȡ http �����ʱ�������
sudo tcpdump -nSA port 80��


1. tcpdump -nS
�������ж˿ڣ�ֱ����ʾ ip ��ַ��

2. tcpdump -nnvvS
��ʾ����ϸ�����ݱ��ģ����� tos, ttl, checksum �ȡ�

3. tcpdump -nnvvXS
��ʾ���ݱ���ȫ��������Ϣ���� hex �� ascii ���жԱ������

# ������Ҳ���Լ򵥵ط�Ϊ���ࣺtype, dir �� proto��
# Type �������ֱ��ĵ����ͣ���Ҫ�� host��������, net�����磩 �� port���˿ڣ� ��ɡ�src �� dst Ҳ�����������˱��ĵ�Դ��ַ��Ŀ�ĵ�ַ��

# host: ����ĳ�����������ݱ���
tcpdump host 1.2.3.4
# src, dst: ����Դ��ַ��Ŀ�ĵ�ַ
tcpdump src 2.3.4.5
tcpdump dst 3.4.5.6
# net: ����ĳ�����ε����ݣ�CIDR ģʽ
tcpdump net 1.2.3.0/24
# proto: ����ĳ��Э������ݣ�֧�� tcp, udp �� icmp��ʹ�õ�ʱ�����ʡ�� proto �ؼ��֡�
tcpdump icmp
# port: ����ͨ��ĳ���˿ڵ����ݱ�
tcpdump port 3389
# src/dst, port, protocol: �������
tcpdump src port 1025 and tcp
tcpdump udp and src port 53

# port ��Χ
tcpdump portrange 21-23
# ���ݱ���С����λ���ֽ�
tcpdump less 32
tcpdump greater 128
tcpdump > 32
tcpdump <= 128

# ������ļ�
# -w ѡ�����������ݱ���������ļ������������������ǰ����� 80 �˿ڵ����ݵ��뵽�ļ�
sudo tcpdump -w capture_file.pcap port 80
# -r ���Զ�ȡ�ļ�������ݱ��ģ���ʾ����Ļ�ϡ�
tcpdump -nXr capture_file.pcap host web30
# NOTE�����浽�ļ������ݲ�����Ļ�Ͽ������ļ���Ϣ�����ǰ����˶�����Ϣ�Ĺ̶���ʽ pcap����Ҫ�����������鿴��
# ʹ�� vim ���� cat �����������롣

# ���˵�����ǿ��֮���������������������ǣ����������ǵ��߼����ǳ��õ� ��/AND/&& �� ��/OR/|| �� ��/not/!��
# Դ��ַ�� 10.5.2.3��Ŀ�Ķ˿��� 3389 �����ݱ�
tcpdump -nnvS src 10.5.2.3 and dst port 3389
# �� 192.168 ���ε� 10 ���� 172.16 ���ε����ݱ�
tcpdump -nvX src net 192.168.0.0/16 and dat net 10.0.0.0/8 or 172.16.0.0/16
# �� Mars ���� Pluto ���������ݱ�������Ŀ�Ķ˿ڲ��� 22
tcpdump -vv src mars or pluto and not dat port 22

# ���ڱȽϸ��ӵĹ��������ʽ��Ϊ���߼�������������ʹ�����š�����Ĭ������£�tcpdump �� () ����������ַ������Ա���ʹ�õ����� ' ���������壺
tcpdump -nvv -c 20 'src 10.0.2.4 and (dat port 3389 or 22)'

# ���⣬������������ݻ��� tcp Э����������ֹ��̣���һ������ SYN ���ģ��������ͨ�� Flags [S] �����������ǳ����� TCP ���ĵ� Flags:
# [S]�� SYN����ʼ���ӣ�
# [.]: û�� Flag
# [P]: PSH���������ݣ�
# [F]: FIN ���������ӣ�
# [R]: RST���������ӣ�
# ���ڶ������ݵ� [S.] ��ʾ SYN-ACK������ SYN ���ĵ�Ӧ���ġ�

# ��ӡ���н�����뿪sundown�����ݰ�.
tcpdump host sundown

# Ҳ����ָ��ip,����ػ�����210.27.48.1 �������յ��ĺͷ��������е����ݰ�
tcpdump host 210.27.48.1 

# ��ӡhelios �� hot ������ ace ֮��ͨ�ŵ����ݰ�
tcpdump host helios and \( hot or ace \)

# �ػ�����210.27.48.1 ������210.27.48.2 ��210.27.48.3��ͨ��
tcpdump host 210.27.48.1 and \ (210.27.48.2 or 210.27.48.3 \) 

# ��ӡace���κ���������֮��ͨ�ŵ�IP ���ݰ�, ����������helios֮������ݰ�.
tcpdump ip host ace and not helios

# �����Ҫ��ȡ����210.27.48.1���˺�����210.27.48.2֮����������ͨ�ŵ�ip����ʹ�����
tcpdump ip host 210.27.48.1 and ! 210.27.48.2

# �ػ�����hostname���͵���������
tcpdump -i eth0 src host hostname

# ���������͵�����hostname�����ݰ�
tcpdump -i eth0 dst host hostname


# ��ӡTCP�Ự�еĵĿ�ʼ�ͽ������ݰ�, �������ݰ���Դ��Ŀ�Ĳ��Ǳ��������ϵ�����.(nt: localnet, ʵ��ʹ��ʱҪ�����滻�ɱ������������))
tcpdump 'tcp[tcpflags] & (tcp-syn|tcp-fin) != 0 and not src and dst net localnet'

# ��ӡ����Դ��Ŀ�Ķ˿���80, �����Э��ΪIPv4, ���Һ�������,������SYN,FIN�Լ�ACK-only�Ȳ������ݵ����ݰ�.(ipv6�İ汾�ı��ʽ������ϰ)
tcpdump 'tcp port 80 and (((ip[2:2] - ((ip[0]&0xf)<<2)) - ((tcp[12]&0xf0)>>2)) != 0)'
# (nt: �����Ϊ, ip[2:2]��ʾ����ip���ݰ��ĳ���, (ip[0]&0xf)<<2)��ʾip���ݰ���ͷ�ĳ���(ip[0]&0xf������е�IHL��, ������ĵ�λΪ32bit, Ҫ����

# ���ֽ�����Ҫ����4,��������2.��(tcp[12]&0xf0)>>4 ��ʾtcpͷ�ĳ���, ����ĵ�λҲ��32bit,������ɱ�����Ϊ ((tcp[12]&0xf0) >> 4)��<<����,��
# �� ((tcp[12]&0xf0)>>2).��((ip[2:2] - ((ip[0]&0xf)<<2)) - ((tcp[12]&0xf0)>>2)) != 0����ʾ: ����ip���ݰ��ĳ��ȼ�ȥipͷ�ĳ���,�ټ�ȥ
# tcpͷ�ĳ��Ȳ�Ϊ0, �����ζ��, ip���ݰ���ȷʵ��������.����ipv6�汾ֻ�迼��ipv6ͷ�е�'Payload Length' �� 'tcpͷ�ĳ���'�Ĳ�ֵ, �������б�﷽ʽ'ip[]'�軻��'ip6[]'.)

# ��ӡ���ȳ���576�ֽ�, �������ص�ַ��snup��IP���ݰ�
tcpdump 'gateway snup and ip[2:2] > 576'

# ��ӡ����IP��㲥��ಥ�����ݰ��� ������������̫����Ĺ㲥��ಥ���ݱ�
tcpdump 'ether[0] & 1 = 0 and ip[16] >= 224'
# ��ӡ��'echo request'����'echo reply'���������ICMP���ݰ�( ����,��Ҫ��ӡ���з�ping ������������ݰ�ʱ���õ��˱��ʽ .
# (nt: 'echo reuqest' �� 'echo reply' ���������͵�ICMP���ݰ�ͨ����ping�������))
tcpdump 'icmp[icmptype] != icmp-echo and icmp[icmptype] != icmp-echoreply'
