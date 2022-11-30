#!/bin/bash

# 1
if [ -d "/home/user/test" ]; then
	echo -e "dir '/home/user/test' already exists. Do you want to override it? [Y/n]"
	while read -r ans;
	do
		if [ $ans = "Y" ]; then
			echo -e "ok! trying to override /home/user/test\n" && rm -rf /home/user/test && mkdir /home/user/test && break
		else
			if [ $ans = "n" ]; then
				exit 1
			else
				echo -e "[Y/n]\n"
			fi
		fi
	done
else
	mkdir /home/user/test
fi
read


#2
touch /home/user/test/list
ls -la /etc > /home/user/test/list

head /home/user/test/list -n 10
read


#3
find /etc -type d | wc -l >> /home/user/test/list
echo $(( $(ls -a /etc | wc -l) - $(ls /etc | wc -l) )) >> /home/user/test/list
tail /home/user/test/list -n 10
read


#4
mkdir /home/user/test/links && echo "[INFO] dir 'links' created successfully"
read


#5
ln /home/user/test/list /home/user/test/links/list_hlink && echo "[INFO] hlink on 'list' created successfully"
read


#6
ln -s /home/user/test/list /home/user/test/links/list_slink && echo "[INFO] slink on 'list' created successfully"
read


#7
ls -l /home/user/test/links | grep list_hlink
ls -l /home/user/test | grep list
ls -l /home/user/test/links | grep list_slink
# list_hlink and list has same amount of hlink cause they are connected via ln
# list_slink is just whole name of list, it does not increase hlink counter
read


#8
wc -l /home/user/test/list >> /home/user/test/links/list_hlink && echo "[INFO] number of lines in 'list' was written into 'list_hlink'"
cat /home/user/test/links/list_hlink | tail -n 5
read


#9
if [[ -z $(diff /home/user/test/list /home/user/test/links/list_hlink) ]]; then
	echo "Yes, files are equal"
else
	echo "No, files have diff"
fi

# Files are equal cause both of them is actuatually the same i-node.
read


#10
mv /home/user/test/list /home/user/test/list1 && echo "[INFO] 'list' renamed into 'list1'"
read


#11
diff /home/user/test/links/list_hlink /home/user/test/links/list_slink
ls -la /home/user/test/links && ls -la /home/user/test
#if [[ -z $(diff /home/user/test/links/list_hlink /home/user/test/links/list_slink) ]]; then
#	echo "Yes, files are equal"
#else
#	echo "No, files have diff"
#fi

# Files are not equal cause file list_slink no more exists
read


#12
ln /home/user/test/links /home/user/links_hlink && echo "[INFO] hlink on 'links' created successfully"
# It's not allowed :)
read


#13
touch /home/user/list_conf && echo "[INFO] 'list_info' created successfully"
find /etc -name "*.conf" > /home/user/list_conf && echo "[INFO] all /etc/*.conf files saved into 'list_conf'"
cat /home/user/list_conf | head -n 5
read


#14
touch /home/user/list_d && echo "[INFO] 'list_d' created successfully"
find /etc -name "*.d" -type d > /home/user/list_d && echo "[INFO] all subdir /etc/*.d saved into 'list_d'"
cat /home/user/list_d | head -n 5
read


#15
touch /home/user/list_conf_d && echo "[INFO] 'list_conf_d' created successfully"
cat /home/user/list_conf > /home/user/list_conf_d && echo "[INFO] 'list_conf' data copied into 'list_conf_d'"
cat /home/user/list_d >> /home/user/list_conf_d && echo "[INFO] 'list_d' data copied into 'list_conf_d'"
cat /home/user/list_conf_d | head -n 5
cat /home/user/list_conf_d | tail -n 5
read


#16
mkdir /home/user/test/.sub && echo "[INFO] hidden file .sub created"
ls -l /home/user/test
ls -la /home/user/test
read


#17
cp /home/user/list_conf_d /home/user/test/.sub && echo "[INFO] list_conf_d copied into .sub"
ls -la /home/user/test/.sub
read


#18
cp --backup=t /home/user/list_conf_d /home/user/test/.sub && echo "[INFO] list_conf_d copied into .sub in backup mode"
read


#19
ls -laR /home/user/test
read


#20
touch /home/user/man.txt && echo "[INFO] man.txt created"
man man > /home/user/man.txt
cat /home/user/man.txt | head -n 5
read


#21
split -b 1k /home/user/man.txt man_part_ && echo "[INFO] man.txt splitted into ."
ls .
read


#22
mkdir /home/user/test/man.dir && echo "[INFO] man.dir created"
read


#23
mv man_part_* /home/user/test/man.dir/ && echo "[INFO] splitted man moved into man.dir"
ls .
ls /home/user/test/man.dir
read


#24
touch /home/user/test/man.dir/man.txt && echo "[INFO] man.txt created"
cat /home/user/test/man.dir/man_part_* > /home/user/test/man.dir/man.txt && echo "[INFO] man_part_* joined"
read


#25
if [[ -z $(diff /home/user/man.txt /home/user/test/man.dir/man.txt) ]]; then
	echo "Yes, man files are the same"
else
	echo "No, man files are differ"
fi
# Files are the same cause we just took stream of bytes one by one and
# save it in this order into file
read


#26
echo -e "first\nsecond\nthird\n$(cat /home/user/man.txt)\naba\nabacaba" > /home/user/man.txt && echo "[INFO] trash dumpeed into man.txt"
cat /home/user/man.txt | head -n 5
cat /home/user/man.txt | tail -n 5
read


#27
touch manDiff && echo "[INFO] manDiff file created"
diff /home/user/test/man.dir/man.txt /home/user/man.txt > manDiff && echo "[INFO] man diff was taken:"
cat manDiff
read


#28
mv manDiff /home/user/test/man.dir/ && echo "[INFO] manDiff move into man.dir"
read


#29
touch /home/user/test/man.dir/man_new.txt && patch /home/user/test/man.dir/man.txt -i /home/user/test/man.dir/manDiff -o /home/user/test/man.dir/man_new.txt && rm -f /home/user/test/man.dir/man.txt | mv /home/user/test/man.dir/man_new.txt /home/user/test/man.dir/man.txt && echo "[INFO] patch aplpied"
read


#30
if [[ -z $(diff /home/user/man.txt /home/user/test/man.dir/man.txt) ]]; then
	echo "Yes, man files are the same"
else
	echo "No, man files are differ"
fi
# Files are the same cause we use syntaxis 'diff old new' and then simply apply diff to old file.
read

