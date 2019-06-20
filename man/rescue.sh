#!/usr/bin/env bash

# reboot to rescue base on Finnix

# Finnix Finnix��һ������Debian����ȫ�����Ŀ�����Linux��ԮLiveCD�������ڰ�װ���޸�Ӳ�����������������ؽ�������¼��
#    �������ϵͳ�ȷǳ����á�
# Finnix����Linux�ں�3.0��x86��Ĭ������°������ٸ�ϵͳ����Ա�������ȫ��С��400 MB��ѹ����160MBС�Ϳ�����ISOӳ��

# By default, your disks are not mounted when your Linode boots into Rescue Mode. However,
#    you can manually mount a disk under Rescue Mode to perform system recovery and maintenance
#    tasks. Run the mount command, replacing /dev/sda with the location of the disk you want to
#    mount:

mount -o barrier=0 /dev/sda
# Disks that contain a single filesystem will have mount points under /media in
#    the rescue environment��s /etc/fstab file. To view the directories on the disk,
#    enter the following command:

ls /media/sda

# Then to create the chroot, you need to mount the temporary filesystems:
cd /media/sda
mount -t proc proc proc/
mount -t sysfs sys sys/
mount -o bind /dev dev/
mount -t devpts pts dev/pts/

# Chroot to your disk:
chroot /media/sda /bin/bash


# �޸��ļ�ϵͳ
# ��Finnix���޸��ļ�ϵͳ�ǳ������ˡ���������������Finnix���������������
# ���������޸����ĸ��ļ�ϵͳ�����ݡ�yes����־���Զ��޸��ļ�ϵͳ�������һ�����롣
fsck -y /dev/vda1


# To exit the chroot and get back to Finnix type ��exit�� :
exit