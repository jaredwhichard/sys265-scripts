#SECURE-SSH.SH
#AUTHOR jaredwhichard
#CREDIT sys265 lab
#Creates a new ssh user called $1
#Adds a public key to that user called $1
#Adds a public key to that users authorized keys file
#Removes roots ability to ssh in

echo "testing 321"
#Accept a variable to be used as the username
read ‘Enter a username:’ user

#Add user and make a .ssh file in the user's home directory
useradd $user
mkdir /home/$user/.ssh

#Copy the public key to the new named user
cp linux/public-keys/sys265.pub /home/$user/.ssh/authorized_keys

#Allow user read write and execute
chmod 700 /home/sys265/.ssh

#Allow user read and write
chmod 600 /home/$user/.ssh/authorized_keys

#Assigning the user as the owner of the file and directory recursively
chown -R $user:$user /home/$user/.ssh

#Change the Permit root login to no globally
sed 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
echo "Complete"
