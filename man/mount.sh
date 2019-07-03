#!/usr/bin/env bash

sudo mount -t cifs -o username=administrator,password=ygct@12345678 //10.31.58.215/d /eee/215d

sudo mount -t cifs //10.35.191.11/ddd /eee/11d -o username=oudream,password=oudream,nounix,sec=ntlmssp

sudo mount -t cifs //192.168.0.103/ddd /ddd -o username=oudream,password=oudream,nounix,sec=ntlmssp

sudo mount -t cifs //144.202.65.220/fff/ceph /eee/ceph -o username=root,password=Z.a-135246-a.Z,nounix,sec=ntlmssp


# mount
mount | column -t # �鿴�ҽӵķ���״̬
mount -t cifs -o username=Bob,password=123456 //192.168.0.102/Share /usr/local/bin/code
df -h # �������״̬
mount
umount /usr/local/bin/code


# mount�������ڼ����ļ�ϵͳ��ָ���ļ��ص㡣�����������ڹ���cdrom��ʹ���ǿ��Է���cdrom�е����ݣ���Ϊ�㽫���̲���cdrom�У�
#    Linux�������Զ����أ�����ʹ��Linux mount�������ֶ���ɹ��ء�

mount option params

# ѡ��
# -V����ʾ����汾��
# -l����ʾ�Ѽ��ص��ļ�ϵͳ�б�
# -h����ʾ������Ϣ���˳���
# -v���߳�ģʽ�����ָ��ִ�е���ϸ��Ϣ��
# -n������û��д���ļ���/etc/mtab���е��ļ�ϵͳ��
# -r�����ļ�ϵͳ����Ϊֻ��ģʽ��
# -a�������ļ���/etc/fstab���������������ļ�ϵͳ��

# ����
# �豸�ļ�����ָ��Ҫ���ص��ļ�ϵͳ��Ӧ���豸����
# ���ص㣺ָ�����ص�Ŀ¼��

#ʵ��
mount -t auto /dev/cdrom /mnt/cdrom
# mount: mount point /mnt/cdrom does not exist           /mnt/cdromĿ¼�����ڣ���Ҫ�ȴ�����

cd /mnt
#-bash: cd: /mnt: No such file or directory

# ����/mnt/cdromĿ¼
mkdir -p /mnt/cdrom
# ����cdrom
mount -t auto /dev/cdrom /mnt/cdrom
# mount: block device /dev/cdrom is write-protected, mounting read-only     ���سɹ�

# �鿴cdrom��������
ll /mnt/cdrom