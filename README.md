
clone the repository:

git clone https://github.com/noderguru/fractald-node-install.git

go to the directory with the project:

cd fractald-node-install

Make the script executable
:
chmod +x install_fractald.sh

run the script:

./install_fractald.sh

or

bash install_fractald.sh

view logs:
sudo journalctl -u fractald -f --no-hostname -o cat
