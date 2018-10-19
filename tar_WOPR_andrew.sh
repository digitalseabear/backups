#!/bin/bash
# ----------------------------------------------------------------------
# andrew's handy Tar snaphot backup utility
# ----------------------------------------------------------------------
# This script backs up andrew's home folder on WOPR to the mounted BackupDatabase on the NAStronaut
# ----------------------------------------------------------------------

SOURCEDIR=/home/andrew/
DESTDIR=/mnt/FreeNAS-Shares/BackupDatabase/TarBackups/WOPR-andrew-ARCHIVES
BACKUPDIR=/home/andrew/BackupLogs/backup.log
BACKUPHOST=NASTRONAUT

sudo mount -a
echo "Tar backup of andrew to $BACKUPHOST" >> $BACKUPDIR
echo "Tar backup sent to $BACKUPHOST on:" >> $BACKUPDIR
date >> $BACKUPDIR
echo "Making a Tar backup of /home/andrew..." | tee -a $BACKUPDIR

sudo tar -cvpzf $DESTDIR/Archive_$(date +%Y%m%d).tar.gz --exclude='/home/andrew/.steam' $SOURCEDIR

# send result notification via email

if [ $? -eq 0 ]  
then
    echo "Tar backup completed successfully on $(date) for $(hostname)" | mail -s "WOPR Tar Successful" theseabearlounge@gmail.com
    echo "Tar backup completed successfully on $(date) for $(hostname)" | tee -a $BACKUPDIR
else
    echo "Tar backup FAILED on $(date) for $(hostname)" | mail -s "WOPR Tar Failed" theseabearlounge@gmail.com
    echo "Tar backup FAILED on $(date) for $(hostname)" | tee -a $BACKUPDIR
fi

exit

# End of Script #
