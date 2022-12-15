# task 1
```
> dnf group list

Last metadata expiration check: 0:00:57 ago on Thu 15 Dec 2022 10:07:02 PM MSK.
Available Environment Groups:
   Server with GUI
   Minimal Install
   Workstation
   KDE Plasma Workspaces
   Virtualization Host
   Custom Operating System
Installed Environment Groups:
   Server
Installed Groups:
   Headless Management
   System Tools
Available Groups:
   Container Management
   .NET Core Development
   RPM Development Tools
   Development Tools
   Graphical Administration Tools
   Legacy UNIX Compatibility
   Network Servers
   Scientific Support
   Security Tools
   Smart Card Support
   Fedora Packager
   Xfce
   
> dnf group install "Developments Tools"
```

# task 2
```
> mkdir /mnt/lab4
> mount -t cifs //192.168.56.1/Users/11/lab4 -o vers=3.1.1
> mkdir /home/user/bastet && cd /home/user/bastet && cp /mnt/lab4/bastet-0.43.tgz .
> tar -xf bastet-0.43.tgz
> ls bastet-0.43
...
> cd bastet-0.43
> make
Failure :(
> sudo yum install gcc-c++
> make
Failure :(
> sudo yum install boost-devel
> make
Failure :(
> sudo yum install ncurses-devel
> make
Success :)
> ./bastet
Append into 'Makefile':

install:
        install -m 755 ./bastet /usr/bin

> make install
install -m 755 ./bastet /usr/bin
> ls /usr/bin/bastet
/usr/bin/bastet
> runuser -l user -c '/home/user/bastet/bastet-0.43/bastet'
Success :) 
```

# task 3

```
> dnf info installed > task3.log  # provides easily-human-readed info about all installed packages,
# like: Name, Version, Release, Architecture, Size, Source, Repository, From repo, Summary, URL, License, Description
> cat task3.log | head -n 5
Installed Packages
Name         : ModemManager
Version      : 1.10.8
Release      : 2.el8
Architecture : x86_64

> dnf list installed > task3.log
> cat task3.log | head -n 5
Installed Packages
ModemManager.x86_64                         1.10.8-2.el8                       @anaconda  
ModemManager-glib.x86_64                    1.10.8-2.el8                       @anaconda  
NetworkManager.x86_64                       1:1.22.8-4.el8                     @anaconda  
NetworkManager-adsl.x86_64                  1:1.22.8-4.el8                     @anaconda
```

# task 4
```
> dnf deplist gcc > task4_1.log
> wc -l
95 task4_1.log

> dnf deplist --whatrequires libgcc > task4_2.log
> wc -l 
176061 task4_2.log
```

# task 5

```
> cd ~ && mkdir localrepo && cd localrepo && cp /mnt/lab4/checkinstall-1.6.2-3.el6.1.x86_64.rpm .
> createrepo .
Directory walk started
Directory walk done - 1 packages
Temporary output repo path: ./.repodata/
Preparing sqlite DBs
Pool started (with 5 workers)
Pool finished

> ls repodata/
05be1451dcc3a3455b606112f007eb593dc2e8ecdec8a2276b15be63bf0c8e9a-filelists.xml.gz
0914507f9e0d77d4979ff6ba268761c4d22a289910c958cc09521b929bbc33a4-primary.xml.gz
4bbbf5dc5f58572d41181c9e20faf8fc230d5d74a8bb51f7b6464405af764592-primary.sqlite.bz2
a34539c2143744bc47b6b457f3b96a0e66fbdbb4c6809068e67869a34048f77b-other.xml.gz
cd1b66f6df3741906321d832e6a5c28dafa0dcbcfad92606b0d74b2f37edba5d-other.sqlite.bz2
d7d9f72882c8df1c18497330c5e58ac8fc895ad3be27a7bd48395086b8b0c25a-filelists.sqlite.bz2
repomd.xml
> nano /etc/yum.repos.d/localrepo.repo
[localrepo]
name=localrepo
mirrorlist=file:///home/root/localrepo/
enabled=1
gpgcheck=0
> ls /etc/yum.repos.d/
CentOS-AppStream.repo
CentOS-Base.repo
CentOS-centosplus.repo
CentOS-CR.repo
CentOS-Debuginfo.repo
CentOS-Devel.repo
CentOS-Extras.repo
CentOS-fasttrack.repo
CentOS-HA.repo
CentOS-Media.repo
CentOS-PowerTools.repo
CentOS-Sources.repo
CentOS-Vault.repo
epel-modular.repo
epel-playground.repo
epel.repo
epel-testing-modular.repo
epel-testing.repo
localrepo.repo
```
