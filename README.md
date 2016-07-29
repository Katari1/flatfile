We had a customer that needed a daily report of call information that they could retrieve as needed.  I set up a secure sftp server on one of our appliances and this script pulls the call informatoin for them and transfers it to the sFTP server.

From there I created a cron that would do this at 12:04 every morning for the previous day.  The crontab looked like this.

00 04 * * * fdsadmin /home/fdsadmin/flatfile/flatfile.sh 2>&1 >> /tmp/flatfile.log
