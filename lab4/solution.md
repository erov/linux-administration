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