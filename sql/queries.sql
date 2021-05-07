    1  09/02/21 12:22:39 mc
    2  09/02/21 12:22:39 es/cloud_init-0.7.9-py3.6.egg/cloudinit/config/
    3  09/02/21 12:22:39 cloud-init -v
    4  09/02/21 12:22:39 sudo rm -rf /etc/cloud/; sudo rm -rf /var/lib/cloud/
    5  09/02/21 12:22:39 wget https://launchpad.net/cloud-init/trunk/0.7.6/+download/cloud-init-0.7.6.tar.gz
    6  09/02/21 12:22:39 mkdir /usr/src/cloud-init
    7  09/02/21 12:22:39 cd /usr/src/cloud-init
    8  09/02/21 12:22:39 wget https://launchpad.net/cloud-init/trunk/0.7.6/+download/cloud-init-0.7.6.tar.gz
    9  09/02/21 12:22:39 tar -zxvf cloud-init-* -C /usr/src/cloud-init/ --strip 1
   10  09/02/21 12:22:39 python3 setup.py build
   11  09/02/21 12:22:39 python3 setup.py install --init-system systemd
   12  09/02/21 12:22:39 mkdir /root/foxcloud
   13  09/02/21 12:22:39 rm -rf /root/foxcloud/
   14  09/02/21 12:22:39 mkdir /root/foxcloud
   15  09/02/21 12:22:39 rsync -avh root@os-nl2-c1.foxcloud.net:/root/_alexis/foxcloud_cloud-init.zip /root/foxcloud/
   16  09/02/21 12:22:39 unzip /root/foxcloud/*
   17  09/02/21 12:22:39 rm -f /usr/src/cloud-init/cloudinit/config/cc_set_passwords.py
   18  09/02/21 12:22:39 mv /root/foxcloud/foxcloud_cloud-init/cc_set_passwords.py_1 /usr/src/cloud-init/cloudinit/config/cc_set_passwords.py
   19  09/02/21 12:22:39 rm -f /usr/src/cloud-init/build/lib/cloudinit/config/cc_set_passwords.py
   20  09/02/21 12:22:39 mv /root/foxcloud/foxcloud_cloud-init/cc_set_passwords.py_2 /usr/src/cloud-init/build/lib/cloudinit/config/cc_set_passwords.py
   21  09/02/21 12:22:39 mv /root/foxcloud/foxcloud_cloud-init/cc_set_passwords.py_3 /usr/lib/python3/dist-packages/cloudinit/config/cc_set_passwords.py
   22  09/02/21 12:22:39 rm -rf /etc/cloud
   23  09/02/21 12:22:39 mv /root/foxcloud/foxcloud_cloud-init/cloud /etc/
   24  09/02/21 12:22:39 mv -f /root/foxcloud/foxcloud_cloud-init/cloud/* /lib/systemd/system/
   25  09/02/21 12:22:39 mv -f /root/foxcloud/foxcloud_cloud-init/system/ /lib/systemd/system/
   26  09/02/21 12:22:39 mv /usr/bin/cloud-init /usr/bin/cloud-init.bak
   27  09/02/21 12:22:39 ln -s /usr/local/bin/cloud-init /usr/bin/cloud-init
   28  09/02/21 12:22:39 systemctl enable cloud-init-local.service
   29  09/02/21 12:22:39 systemctl start cloud-init-local.service
   30  09/02/21 12:22:39 systemctl enable cloud-init.service
   31  09/02/21 12:22:39 systemctl start cloud-init.service
   32  09/02/21 12:22:39 systemctl enable cloud-config.service
   33  09/02/21 12:22:39 systemctl start cloud-config.service
   34  09/02/21 12:22:39 systemctl enable cloud-final.service
   35  09/02/21 12:22:39 systemctl start cloud-final.service
   36  09/02/21 12:22:39 swapoff -a
   37  09/02/21 12:22:39 sudo rm /swap.img
   38  09/02/21 12:22:39 truncate -s 0 /root/.bash_history
   39  09/02/21 12:22:39 truncate -s 0 /var/log/*
   40  09/02/21 12:22:39 truncate -s 0 /var/log/*/*
   41  09/02/21 12:22:39 rm -rf /var/lib/cloud
   42  09/02/21 12:22:39 rm -rf /root/foxcloud_cloud-init
   43  09/02/21 12:22:39 rm -rf /root/foxcloud_cloud-init.zip
   44  09/02/21 12:22:39 reboot
   45  09/02/21 12:22:39 df -h
   46  09/02/21 12:22:39 rm -rf /var/lib/cloud
   47  09/02/21 12:22:39 rm -rf /root/foxcloud_cloud-init
   48  09/02/21 12:22:39 rm -rf /root/foxcloud_cloud-init.zip
   49  09/02/21 12:22:39 shutdown -h now