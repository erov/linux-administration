#!/bin/bash

echo -e "\n[INFO] cleaner.sh started..."

# 1
rm work3.log && echo "[INFO] file work3.log was removed"

# 4
rm /etc/skel/readme.txt && echo "[INFO] file /etc/skel/readme.txt was removed"

# 5
userdel u1 && echo "[INFO] user 'u1' was removed"
rm -rf /home/u1 && echo "[INFO] user's 'u1' home dir was removed"
rm -f /var/spool/mail/u1 && echo "[INFO] user's 'u1' mailbox was removed"

# 6
groupdel g1 && echo "[INFO] group 'g1' was removed"

# 12
userdel u2 && echo "[INFO] user 'u2' was removed"
rm -f /var/spool/mail/u2 && echo "[INFO] user's 'u2' mailbox was removed"

# 13
rm -rf /home/test13 && echo "[INFO] dir /home/test13 was removed recursivly"


read


