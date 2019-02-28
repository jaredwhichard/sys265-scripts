#SECURE-SSH.SH
#AUTHOR jaredwhichard
#CREDIT sys265 lab
#Creates a new ssh user called $1
#Adds a public key to that user called $1
#Adds a public key to that users authorized keys file
#Removes roots ability to ssh in

#Accept first  variable to be used as the username
user=$1

#Add user and make a .ssh file in the user's home directory
sudo useradd $user
sudo mkdir /home/$user/.ssh

#Copy the public key to the new named user
sudo cp ~/sys265-scripts/linux/public-keys/sys265.pub /home/$user/.ssh/authorized_keys

#Allow user read write and execute
sudo chmod 700 /home/sys265/.ssh

#Allow user read and write
sudo chmod 600 /home/$user/.ssh/authorized_keys

#Assigning the user as the owner of the file and directory recursively
sudo chown -R $user:$user /home/$user/.ssh

#Allow all to access sshd config 
sudo chmod 777 /etc/ssh/sshd_config

#Change the Permit root login to no globally
sudo sed "s/PermitRootLogin yes/PermitRootLogin no/g" /etc/ssh/sshd_config

#Revert to user access only
sudo chmod 700 /etc/ssh/sshd_config

#Resart sshd to save changes
sudo systemctl restart sshd

sudo echo "Complete"
