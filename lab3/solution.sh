#!/bin/bash

# 1
awk -F: '{ print "user " $1 " has id " $3 }' /etc/passwd > work3.log && echo "[INFO] list of users was written into work3.log"
echo "[INFO] work3.log data:" && cat work3.log
read


# 2
chage -l root | head -n 1 >> work3.log && echo "[INFO] date of last 'root' user password changing appended into work3.log"
echo "[INFO] work3.log tail data:" && cat work3.log | tail -n 5
read


# 3
awk 'BEGIN { ORS=","; FS=":" } { print $1 }' /etc/group | rev | cut -c 2- | rev >> work3.log && echo "[INFO] group names were appended into work3.log"
echo "[INFO] work3.log tail data:" && cat work3.log | tail -n 5
read


# 4
echo "Be careful!" > /etc/skel/readme.txt && echo "[INFO] readme.txt now creates in user's home dir by default"
echo "[INFO] /etc/skel info:" && ls -la /etc/skel
echo "[INFO] /etc/skel/readme.txt data:" && cat /etc/skel/readme.txt
read

# 5
useradd -m -p $(openssl passwd 12345678) u1 && echo "[INFO] user 'u1' with password '12345678' was created with home dir"
echo "[INFO] /home/u1 info:" && ls /home/u1
read

# 6
groupadd g1 && echo "[INFO] group 'g1' was created"
echo "[INFO] /etc/group tail data:" && cat /etc/group | tail -n 5
read

# 7
usermod -a -G g1 u1 && echo "[INFO] user 'u1' added into group 'g1'"
echo "[INFO] user 'u1' list of groups:" && groups u1
read

# 8
id u1 >> work3.log
echo "[INFO] info of user 'u1' UID and list of groups were appended into work3.log:" && cat work3.log | tail -n 5
read

# 9
usermod -a -G g1 user && echo "[INFO] user 'user' added into group 'g1'"
echo "[INFO] user 'user' groups info:" && groups user
read

# 10
grep 'g1' /etc/group | awk -F: '{ print "group " $1 " users: " $4 }' >> work3.log
echo "[INFO] group 'g1' info was appended into work3.log:" && cat work3.log | tail -n 5
read

# 11
usermod -s /usr/bim/mc u1 && echo "[INFO] user 'u1' default shell changed to /usr/bin/mc"
read

# 12
useradd -p $(openssl passwd 87654321) u2 && echo "[INFO] user 'u2' with password '87654321' was created"
echo "[INFO] user 'u2' info:" && id u2
read

# 13
mkdir /home/test13 && echo "[INFO] dir /home/test13 was created"
cp work3.log /home/test13/work3-1.log && echo "[INFO] file /home/test13/work3-1.log created"
cp work3.log /home/test13/work3-2.log && echo "[INFO] file /home/test13/work3-2.log created"
echo "[INFO] /home/test13 info:" && ls -la /home/test13

# 14

