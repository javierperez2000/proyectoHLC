mkdir -p /var/vmail/
groupadd -g 5000 vmail
useradd -g vmail -u 5000 -d /var/vmail vmail
chmod 770 /var/vmail
chown -R vmail:vmail /var/vmail
chgrp postfix /etc/postfix/mysql-*.cf
chmod u=rw,g=r,o= /etc/postfix/mysql-*.cf
echo correo > /etc/mailname