export YOUR_BUCKET_NAME=backup0811-bucket

gcloud storage buckets create gs://$YOUR_BUCKET_NAME-minecraft-backup

#make it permanent env variable irrespective of the ssh session
echo YOUR_BUCKET_NAME=$YOUR_BUCKET_NAME >> ~/.profile

#into ssh of minecraft-server
cd /home/minecraft
sudo vim /home/minecraft/backup.sh
# in vim paste this-backup script
  #!/bin/bash
  screen -r mcs -X stuff '/save-all\n/save-off\n'
  /usr/bin/gcloud storage cp -R ${BASH_SOURCE%/*}/world gs://${YOUR_BUCKET_NAME}-minecraft-backup/$(date "+%Y%m%d-%H%M%S")-world
  screen -r mcs -X stuff '/save-on\n'
sudo chmod 755 /home/minecraft/backup.sh
. /home/minecraft/backup.sh
#now schedule backup as cronjob
sudo crontab -e
#choose editor vim by typing no. 2 
#at the bottom of the file add the cron job
0 */4 * * * /home/minecraft/backup.sh
