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
usermod -s /usr/bin/mc u1 && echo "[INFO] user 'u1' default shell changed to /usr/bin/mc"
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
read

# 14
groupadd test13  # needs for access control
usermod -a -G test13 u1
usermod -a -G test13 u2
usermod -a -G test13 user  # for testing
chown -R u1:test13 /home/test13  # make u1 owner
chmod -R 640 /home/test13
chmod 550 /home/test13
echo "[INFO] /home/test13 access info:" && ls -ld /home/test13 && grep 'test13' /etc/group | awk -F: '{ print "where group " $1 " has users: " $4 }'
read

# 15
mkdir /home/test14 && echo "[INFO] dir /home/test14 was created"
chown u1:u1 /home/test14  # make u1 owner
chmod -R 755 /home/test14  # u1 -- read&write, others -- read all and write if you're owner
chmod +t /home/test14  # cause of Sticky bit set true
echo "[INFO] /home/test14 access info:" && ls -ld /home/test14
read

# 16
cp /bin/nano /home/test14/ && echo "[INFO] nano bin copied to /home/test14"
chown u1:u1 /home/test14/nano  # make u1 owner as in 15
sudo chmod a+s /home/test14/nano  # apply SUID & SGID for running nano as u1
ls -l /home/test14
read

# 17
mkdir /home/test15 && echo "[INFO] dir /home/test15 was created"
echo "secret" > /home/test15/secret_file && echo "[INFO] secret file created successfully"
chmod 411 /home/test15
chmod 444 /home/test15/secret_file
echo "[INFO] trying ls /home/test15 as user 'u2':" && runuser -l u2 -c 'ls /home/test15'
echo "[INFO] trying read /home/test15/secret_file as user 'u2':" && runuser -l u2 -c 'cat /home/test15/secret_file'
read

