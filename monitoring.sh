#!/bin/bash

#architecture
arch=$(uname -a)

#cpu
cpuphys=$(lscpu | grep "CPU(s):" | awk '{print $2}')
cpuvirt=$(nproc)

#memory
mused=$(free --mega | grep "Mem" | awk '{print $3}')
mfree=$(free --mega | grep "Mem" | awk '{print $2}')
memcent=$(free --mega | grep "Mem" | awk '{printf("%.2f"), $3/$2*100}')

#disk
dtotal=$(df -m | grep '/dev' | grep -v '/boot' | awk '{utotal += $2} END {printf("%.1f"), utotal/1024}')
dused=$(df -m | grep '/dev' | grep -v '/boot' | awk '{used += $3} END {print used}')
dcent=$(df -m | grep '/dev' | grep -v '/boot' | awk '{total += $2} {used += $3} END {printf("%.2f"), used/total*100}')

#cpu2
cpuload=$(mpstat 1 1 | grep 'Média' | awk '{printf "%.1f", 100-$12}')

#last_boot
lboot=$(who -b | awk '{print $4 " " $5}')

#lvm_status
lvm=$(if [ $(lvdisplay | grep "Status" | wc -l) -gt 0 ]; then echo active; else echo disabled; fi)

#conections
cstatus=$(ss -t state established | wc -l)
ulogged=$(users | tr ' ' '\n' | wc -l)
ip=$(hostname -I)
mac=$(ip link | grep "/ether" | awk '{print $2}')

#sudo_commands
sucommands=$(journalctl | grep "sudo" | grep "COMMAND" | wc -l)

wall "	-> Architecture:		$arch
	-> CPU(s):			$cpuphys
	-> vCPU(s):			$cpuvirt
	-> Memory Usage:		$mused/${mfree}MB (${memcent}%)
	-> Disk Usage:			$dused/${dtotal}Gb (${dcent}%)
	-> CPU load:			${cpuload}%
	-> Last boot:			$lboot
	-> LVM status:			$lvm
	-> Connections TCP:		$cstatus ESTABLISHED
	-> Users Logged:		$ulogged
	-> Network:			IP: $ip MAC: ($mac)
	-> Sudo CMD:			$sucommands"
