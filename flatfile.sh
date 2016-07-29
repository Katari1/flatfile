#!/bin/bash
date=$(date +%Y-%m-%d --date="1 days ago")

echo "Generating Flatfile for $date"

mysql -uroot -pXXXXXXXX fds -e "select c.tid, c.start_utc,  p.cid as customer, c.pid_name as customer_name, ph.cid as agent, c.other_pid_name as agent_name, c.ref_id, sum(af.duration_sec) / 2 as duration from calls c join audio_files af using (tid) join phones p using (pid) join phones ph on (ph.pid=c.other_pid) where date(c.start_utc) = '$date' group by tid" >> /home/fdsadmin/flatfile/call_records_$date.txt

if [ -e "/home/fdsadmin/flatfile/call_records_$date.txt" ]; then echo "Flatfile for $date exists.....moving on......."
echo "Fixing Permissions for Transfer:"
chmod 777 /home/fdsadmin/flatfile/call_records_$date.txt

echo "Transferring file to AMS"
scp /home/fdsadmin/flatfile/call_records_$date.txt 162.100.84.85:/var/lib/chroot/home/restricted

else echo "Flatfile for $date doesn't exist.....Aborting"
fi 

