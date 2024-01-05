#!/bin/bash
	#-----------ARCH---------#
arch=$(uname -a)
	#----------- : ) --------#


	#-----------cpu----------#
Cpu=$(lscpu | grep "CPU(s)" |awk 'NR==1 {print$2}')
	#----------- :) ----------#
	#-----------Memor---------#
ised=$(free -m | awk 'NR==2{print$3}')
itotal=$(free -m | awk 'NR==2{print$2}')
amount=$(echo "scale=2; $ised/$itotal * 100"| bc)
	#------------ :) ---------#

	#-----------Disk----------#
disk=$(df -m | awk 'NR==4{print$3}')
used=$(df -h | awk 'NR==4{print$4}')
total=$(df -h | awk 'NR==4{print$2}')
persnt=$(echo "scale=2; $used/$total * 100" | bc)
	#----------- :) -----------#

	#-----------Load-----------#
load=$(mpstat | awk 'NR==4{print$4}')
	#----------- :)------------#

	#------------Lboot---------#
lbot=$(who -b | awk '{print$3}')
bot=$(who -b | awk '{print$4}')
	#------------- :) ---------#

	#------------LVMGR---------#
lvm=$(sudo pvs | awk 'NR==2' | grep 'LVMGroup' | wc -l)
number="yes";
if ["$lvm" -lt 1]; then
	number="NO"
else
	number="yes"
fi
	#-------------- :) ---------#

	#-------------TCP-----------#
tp=$(sudo netstat -tna | awk 'NR==6' |grep "ESTABLISHED" | wc -l)
pt=$(sudo netstat -tna | awk 'NR==6' | grep "ESTABLISHED" | awk '{print$6}')
	#------------- :) ----------#

	#--------------User log-----#
log=$(who | awk 'NR==1' | wc -l)
	#-------------- :) ---------#

	#--------------Netw---------#
Con=$(sudo hostname -I)
mac=$(ip link | awk 'NR==4{print$2}')
	#-------------:)------------#

	#------------Sudo-----------#
Counts=$(sudo wc -l /var/log/sudo | awk '{print$1}')
	#------------ :)------------#

wall "
      #Architecture: $arch
      #CPU physical : $Cpu
      #Memory Usage: $ised/${itotal}MB ($amount%)
      #Disk Usage: $disk/ ${used}B (${persnt%%.*}%)
      #CPU load: $load%
      #Last boot: $lbot $bot
      #LVM use:$number
      #Connections TCP :$tp $pt
      #User log : $log
      #Network: IP $Con ($mac)
      #Sudo : $Counts cmd"