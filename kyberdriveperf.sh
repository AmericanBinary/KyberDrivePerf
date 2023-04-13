#!/bin/bash

# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

echo -e '
██████╗  █████╗ ███████╗███████╗██╗     ██╗███╗   ██╗███████╗   
██╔══██╗██╔══██╗██╔════╝██╔════╝██║     ██║████╗  ██║██╔════╝   
██████╔╝███████║███████╗█████╗  ██║     ██║██╔██╗ ██║█████╗     
██╔══██╗██╔══██║╚════██║██╔══╝  ██║     ██║██║╚██╗██║██╔══╝     
██████╔╝██║  ██║███████║███████╗███████╗██║██║ ╚████║███████╗   
╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝╚═╝╚═╝  ╚═══╝╚══════╝   
                                                                
██╗  ██╗██╗    ██╗     ██████╗ ███╗   ██╗██╗  ██╗   ██╗         
██║  ██║██║    ██║    ██╔═══██╗████╗  ██║██║  ╚██╗ ██╔╝         
███████║██║ █╗ ██║    ██║   ██║██╔██╗ ██║██║   ╚████╔╝          
██╔══██║██║███╗██║    ██║   ██║██║╚██╗██║██║    ╚██╔╝           
██║  ██║╚███╔███╔╝    ╚██████╔╝██║ ╚████║███████╗██║            
╚═╝  ╚═╝ ╚══╝╚══╝      ╚═════╝ ╚═╝  ╚═══╝╚══════╝╚═╝            
                                                                
 ██╗███╗   ██╗ ██████╗     ███████╗██╗   ██╗███████╗███████╗██╗ 
██╔╝████╗  ██║██╔═══██╗    ██╔════╝██║   ██║██╔════╝██╔════╝╚██╗
██║ ██╔██╗ ██║██║   ██║    █████╗  ██║   ██║███████╗█████╗   ██║
██║ ██║╚██╗██║██║   ██║    ██╔══╝  ██║   ██║╚════██║██╔══╝   ██║
╚██╗██║ ╚████║╚██████╔╝    ██║     ╚██████╔╝███████║███████╗██╔╝
 ╚═╝╚═╝  ╚═══╝ ╚═════╝     ╚═╝      ╚═════╝ ╚══════╝╚══════╝╚═╝ '
sleep 5
echo -e '\033[32mBASELINE NO ENCRYPTION - NO FUSE (USERSPACE FILESYSTEM)'
echo -e ${Color_Off}
sleep 1
neofetch
sleep 10
echo -e '\033[32m[Baseline - No encryption - no fuse] Sequential writes with 1Mb block size. Imitates write backup activity or large file copies.'

fio --name=baseline-seq-writes-1mb --directory=/root/demo/baseline --size=16Gb --rw=write --bs=1M --direct=1 --numjobs=8 --ioengine=libaio --iodepth=8 --group_reporting --runtime=60 --startdelay=60
sleep 5
clear
echo -e '\033[32m[[Baseline - No encryption - no fuse] Sequential reads with 1Mb block size. Imitates read backup activity or large file copies.'

fio --name=fiotest --directory=/root/demo/baseline --size=16Gb --rw=read --bs=1M --direct=1 --numjobs=8 --ioengine=libaio --iodepth=8 --group_reporting --runtime=60 --startdelay=60
sleep 5
clear
echo -e '\033[32m[[Baseline - No encryption - no fuse] Random writes with 64Kb block size. Medium block size workload for writes.'
fio --name=fiotest --directory=/root/demo/baseline  --size=16Gb --rw=randwrite --bs=64k --direct=1 --numjobs=8 --ioengine=libaio --iodepth=16 --group_reporting --runtime=60 --startdelay=60
sleep 5
rm -fR /root/demo/baseline
mkdir /root/demo/baseline
clear
echo -e '\033[32m[[Baseline - No encryption - no fuse] Random reads with 64Kb block size. Medium block size workload for reads.'

fio --name=fiotest --directory=/root/demo/baseline --size=16Gb --rw=randread --bs=64k --direct=1 --numjobs=8 --ioengine=libaio --iodepth=16 --group_reporting --runtime=60 --startdelay=60
sleep 5
echo -e '\033[32m[[Baseline - No encryption - no fuse] Random writes with 8Kb block size. Common database workload simulation for writes.'

fio --name=fiotest --directory=/root/demo/baseline  --size=16Gb --rw=randwrite --bs=8k --direct=1 --numjobs=8 --ioengine=libaio --iodepth=32 --group_reporting --runtime=60 --startdelay=60
sleep 5
clear
echo -e '\033[32m[[Baseline - No encryption - no fuse] Random reads with 8Kb block size. Common database workload simulation for reads.'

fio --name=fiotest --directory=/root/demo/baseline  --size=16Gb --rw=randread --bs=8k --direct=1 --numjobs=8 --ioengine=libaio --iodepth=32 --group_reporting --runtime=60 --startdelay=60
sleep 5
clear
clear
echo -e '
██╗   ██╗███████╗███████╗██████╗ ███████╗██████╗  █████╗  ██████╗███████╗
██║   ██║██╔════╝██╔════╝██╔══██╗██╔════╝██╔══██╗██╔══██╗██╔════╝██╔════╝
██║   ██║███████╗█████╗  ██████╔╝███████╗██████╔╝███████║██║     █████╗  
██║   ██║╚════██║██╔══╝  ██╔══██╗╚════██║██╔═══╝ ██╔══██║██║     ██╔══╝  
╚██████╔╝███████║███████╗██║  ██║███████║██║     ██║  ██║╚██████╗███████╗
 ╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝  ╚═╝ ╚═════╝╚══════╝
                                                                         
███████╗███████╗     ██╗███████╗██╗   ██╗███████╗███████╗██╗             
██╔════╝██╔════╝    ██╔╝██╔════╝██║   ██║██╔════╝██╔════╝╚██╗            
█████╗  ███████╗    ██║ █████╗  ██║   ██║███████╗█████╗   ██║            
██╔══╝  ╚════██║    ██║ ██╔══╝  ██║   ██║╚════██║██╔══╝   ██║            
██║     ███████║    ╚██╗██║     ╚██████╔╝███████║███████╗██╔╝            
╚═╝     ╚══════╝     ╚═╝╚═╝      ╚═════╝ ╚══════╝╚══════╝╚═╝             
                                                                         
██╗   ██╗███████╗██╗███╗   ██╗ ██████╗      █████╗ ███████╗███████╗      
██║   ██║██╔════╝██║████╗  ██║██╔════╝     ██╔══██╗██╔════╝██╔════╝      
██║   ██║███████╗██║██╔██╗ ██║██║  ███╗    ███████║█████╗  ███████╗      
██║   ██║╚════██║██║██║╚██╗██║██║   ██║    ██╔══██║██╔══╝  ╚════██║      
╚██████╔╝███████║██║██║ ╚████║╚██████╔╝    ██║  ██║███████╗███████║   
'
echo -e '\033[32mBASELINE NO ENCRYPTION - NO FUSE (USERSPACE FILESYSTEM)'
echo -e ${Color_Off}
sleep 1
neofetch
sleep 10
echo -e '\033[32m[FUSE (Userspace Filesystem with AES)] Sequential writes with 1Mb block size. Imitates write backup activity or large file copies.'

fio --name=baseline-seq-writes-1mb --directory=/root/demo/aesplain --size=16Gb --rw=write --bs=1M --direct=1 --numjobs=8 --ioengine=libaio --iodepth=8 --group_reporting --runtime=60 --startdelay=60
sleep 5
clear
echo -e '\033[32m[[FUSE (Userspace Filesystem with AES)]  Sequential reads with 1Mb block size. Imitates read backup activity or large file copies.'

fio --name=fiotest --directory=/root/demo/aesplain --size=16Gb --rw=read --bs=1M --direct=1 --numjobs=8 --ioengine=libaio --iodepth=8 --group_reporting --runtime=60 --startdelay=60
sleep 5
clear
echo -e '\033[32m[[FUSE (Userspace Filesystem with AES)]  Random writes with 64Kb block size. Medium block size workload for writes.'
fio --name=fiotest --directory=/root/demo/aesplain  --size=16Gb --rw=randwrite --bs=64k --direct=1 --numjobs=8 --ioengine=libaio --iodepth=16 --group_reporting --runtime=60 --startdelay=60
sleep 5
rm -fR /root/demo/aesplain
mkdir /root/demo/aesplain
clear
echo -e '\033[32m[[FUSE (Userspace Filesystem with AES)]  Random reads with 64Kb block size. Medium block size workload for reads.'

fio --name=fiotest --directory=/root/demo/aesplain --size=16Gb --rw=randread --bs=64k --direct=1 --numjobs=8 --ioengine=libaio --iodepth=16 --group_reporting --runtime=60 --startdelay=60
sleep 5
echo -e '\033[32m[[FUSE (Userspace Filesystem with AES)] Random writes with 8Kb block size. Common database workload simulation for writes.'

fio --name=fiotest --directory=/root/demo/aesplain  --size=16Gb --rw=randwrite --bs=8k --direct=1 --numjobs=8 --ioengine=libaio --iodepth=32 --group_reporting --runtime=60 --startdelay=60
sleep 5
clear
echo -e '\033[32m[[FUSE (Userspace Filesystem with AES)]  Random reads with 8Kb block size. Common database workload simulation for reads.'

fio --name=fiotest --directory=/root/demo/aesplain  --size=16Gb --rw=randread --bs=8k --direct=1 --numjobs=8 --ioengine=libaio --iodepth=32 --group_reporting --runtime=60 --startdelay=60
sleep 5

clear
echo -e '
██╗   ██╗███████╗███████╗██████╗ ███████╗██████╗  █████╗  ██████╗███████╗         
██║   ██║██╔════╝██╔════╝██╔══██╗██╔════╝██╔══██╗██╔══██╗██╔════╝██╔════╝         
██║   ██║███████╗█████╗  ██████╔╝███████╗██████╔╝███████║██║     █████╗           
██║   ██║╚════██║██╔══╝  ██╔══██╗╚════██║██╔═══╝ ██╔══██║██║     ██╔══╝           
╚██████╔╝███████║███████╗██║  ██║███████║██║     ██║  ██║╚██████╗███████╗         
 ╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝  ╚═╝ ╚═════╝╚══════╝         
                                                                                  
███████╗███████╗     ██╗███████╗██╗   ██╗███████╗███████╗██╗                      
██╔════╝██╔════╝    ██╔╝██╔════╝██║   ██║██╔════╝██╔════╝╚██╗                     
█████╗  ███████╗    ██║ █████╗  ██║   ██║███████╗█████╗   ██║                     
██╔══╝  ╚════██║    ██║ ██╔══╝  ██║   ██║╚════██║██╔══╝   ██║                     
██║     ███████║    ╚██╗██║     ╚██████╔╝███████║███████╗██╔╝                     
╚═╝     ╚══════╝     ╚═╝╚═╝      ╚═════╝ ╚══════╝╚══════╝╚═╝                      
                                                                                  
██╗  ██╗██╗   ██╗██████╗ ███████╗██████╗        ██╗        █████╗ ███████╗███████╗
██║ ██╔╝╚██╗ ██╔╝██╔══██╗██╔════╝██╔══██╗       ██║       ██╔══██╗██╔════╝██╔════╝
█████╔╝  ╚████╔╝ ██████╔╝█████╗  ██████╔╝    ████████╗    ███████║█████╗  ███████╗
██╔═██╗   ╚██╔╝  ██╔══██╗██╔══╝  ██╔══██╗    ██╔═██╔═╝    ██╔══██║██╔══╝  ╚════██║
██║  ██╗   ██║   ██████╔╝███████╗██║  ██║    ██████║      ██║  ██║███████╗███████║
'

echo -e '\033[32m[FUSE (Userspace Filesystem with Kyber + AES)] Sequential writes with 1Mb block size. Imitates write backup activity or large file copies.'

fio --name=baseline-seq-writes-1mb --directory=/root/demo/kyberaesplain --size=16Gb --rw=write --bs=1M --direct=1 --numjobs=8 --ioengine=libaio --iodepth=8 --group_reporting --runtime=60 --startdelay=60
sleep 5
clear
echo -e '\033[32m[[FUSE (Userspace Filesystem with Kyber + AES)]  Sequential reads with 1Mb block size. Imitates read backup activity or large file copies.'

fio --name=fiotest --directory=/root/demo/kyberaesplain --size=16Gb --rw=read --bs=1M --direct=1 --numjobs=8 --ioengine=libaio --iodepth=8 --group_reporting --runtime=60 --startdelay=60
sleep 5
clear
echo -e '\033[32m[[FUSE (Userspace Filesystem with Kyber + AES)]  Random writes with 64Kb block size. Medium block size workload for writes.'
fio --name=fiotest --directory=/root/demo/kyberaesplain  --size=16Gb --rw=randwrite --bs=64k --direct=1 --numjobs=8 --ioengine=libaio --iodepth=16 --group_reporting --runtime=60 --startdelay=60
sleep 5
rm -fR /root/demo/kyberaesplain
mkdir /root/demo/kyberaesplain
clear
echo -e '\033[32m[[FUSE (Userspace Filesystem with Kyber + AES)]  Random reads with 64Kb block size. Medium block size workload for reads.'

fio --name=fiotest --directory=/root/demo/kyberaesplain --size=16Gb --rw=randread --bs=64k --direct=1 --numjobs=8 --ioengine=libaio --iodepth=16 --group_reporting --runtime=60 --startdelay=60
sleep 5
echo -e '\033[32m[[FUSE (Userspace Filesystem with Kyber + AES)] Random writes with 8Kb block size. Common database workload simulation for writes.'

fio --name=fiotest --directory=/root/demo/kyberaesplain  --size=16Gb --rw=randwrite --bs=8k --direct=1 --numjobs=8 --ioengine=libaio --iodepth=32 --group_reporting --runtime=60 --startdelay=60
sleep 5
clear
echo -e '\033[32m[[FUSE (Userspace Filesystem with Kyber + AES)]  Random reads with 8Kb block size. Common database workload simulation for reads.'

fio --name=fiotest --directory=/root/demo/kyberaesplain  --size=16Gb --rw=randread --bs=8k --direct=1 --numjobs=8 --ioengine=libaio --iodepth=32 --group_reporting --runtime=60 --startdelay=60
sleep 5
clear
echo -e'
███████╗██╗  ██╗███████╗ ██████╗██╗   ██╗████████╗██╗██╗   ██╗███████╗  
██╔════╝╚██╗██╔╝██╔════╝██╔════╝██║   ██║╚══██╔══╝██║██║   ██║██╔════╝  
█████╗   ╚███╔╝ █████╗  ██║     ██║   ██║   ██║   ██║██║   ██║█████╗    
██╔══╝   ██╔██╗ ██╔══╝  ██║     ██║   ██║   ██║   ██║╚██╗ ██╔╝██╔══╝    
███████╗██╔╝ ██╗███████╗╚██████╗╚██████╔╝   ██║   ██║ ╚████╔╝ ███████╗  
╚══════╝╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚═════╝    ╚═╝   ╚═╝  ╚═══╝  ╚══════╝  
                                                                        
        ███████╗██╗   ██╗███╗   ███╗███╗   ███╗ █████╗ ██████╗ ██╗   ██╗
        ██╔════╝██║   ██║████╗ ████║████╗ ████║██╔══██╗██╔══██╗╚██╗ ██╔╝
        ███████╗██║   ██║██╔████╔██║██╔████╔██║███████║██████╔╝ ╚████╔╝ 
        ╚════██║██║   ██║██║╚██╔╝██║██║╚██╔╝██║██╔══██║██╔══██╗  ╚██╔╝  
        ███████║╚██████╔╝██║ ╚═╝ ██║██║ ╚═╝ ██║██║  ██║██║  ██║   ██║   
        ╚══════╝ ╚═════╝ ╚═╝     ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝'   
                                                                        
sleep 5
clear
clear