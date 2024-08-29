
###clone the repository:

git clone https://github.com/noderguru/fractald-node-install.git

###go to the directory with the project:

cd fractald-node-install

###Make the script executable:

chmod +x install_fractald.sh

###run the script:

./install_fractald.sh

###or

bash install_fractald.sh

__at the end of the installation you will see your server IP and private key (Don't forget to save it)__
also the private key will be saved in this directory and file::: /root/fractald_wallet_private_key.txt


###view logs:

sudo journalctl -u fractald -f --no-hostname -o cat

###delete node:

sudo systemctl stop fractald

rm /etc/systemd/system/fractald.service

rm -rf fractald-0.1.7-x86_64-linux-gnu/

rm -rf .bitcoin
