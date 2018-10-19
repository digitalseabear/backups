#!/bin/bash
# ----------------------------------------------------------------------
# andrew's handy rotating-filesystem-snapshot utility
# ----------------------------------------------------------------------
# This script backs up andrew's home folder on WOPR to the mounted BackupDatabase on the NAStronaut
# ----------------------------------------------------------------------

SOURCEDIR=/home/andrew/
DESTDIR=/mnt/FreeNAS-Shares/BackupDatabase/IncrementalBackups/WOPR-KUBUNTU-andrew-SYNC/ 
BACKUPDIR=/home/andrew/BackupLogs/backup.log
EXCLUDE=/home/andrew/Documents/Scripts/rsync-exclude.txt
BACKUPHOST=NASTRONAUT

sudo mount -a
echo "Backup of andrew to $BACKUPHOST 
Backup sent to $BACKUPHOST on $(date)" >> $BACKUPDIR
echo "Backing up /home/andrew..." | tee -a $BACKUPDIR

sudo rsync -rltvP --no-perms --delete --exclude-from=$EXCLUDE $SOURCEDIR $DESTDIR 

# send result notification via email

if [ $? -eq 0 ]  
then
    echo "Rsync backup completed successfully on $(date) for $(hostname)" | mail -s "WOPR Rsync Successful" theseabearlounge@gmail.com
    echo "Rsync backup completed successfully on $(date) for $(hostname)" | tee -a $BACKUPDIR
else
    echo "Rsync backup FAILED on $(date) for $(hostname)" | mail -s "WOPR Rsync Failed" theseabearlounge@gmail.com
    echo "Rsync backup FAILED on $(date) for $(hostname)" | tee -a $BACKUPDIR
fi

exit

# End of Script #
