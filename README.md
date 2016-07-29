We had a customer that needed a daily report of call information that they could retrieve as needed.  I set up a sftp server on one of our appliances and this script pulls the call information stored on the primary database appliance  and transfers it to the sFTP server.  In order to scp the file without prompting for a password I set up key based authentication for the user "fdsadmin" that is executing the script.  Once executed, the client can pull the daily information anyway he sees fit.

In order to deploy the script I created a cron that would execute at 12:04 every morning for the previous day.  The crontab looked like this.

00 04 * * * fdsadmin /home/fdsadmin/flatfile/flatfile.sh 2>&1 >> /tmp/flatfile.log
