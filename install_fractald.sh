#!/bin/bash

# Обновление и установка необходимых пакетов
sudo apt-get update -y && sudo apt upgrade -y
sudo apt-get install make build-essential pkg-config libssl-dev unzip tar lz4 gcc git jq -y

# Копируем репозиторий
wget https://github.com/fractal-bitcoin/fractald-release/releases/download/v0.1.8/fractald-0.1.8-x86_64-linux-gnu.tar.gz

# Разархивируем
tar -zxvf fractald-0.1.8-x86_64-linux-gnu.tar.gz
cd fractald-0.1.8-x86_64-linux-gnu/
mkdir data

# Копируем конфигурационный файл
cp ./bitcoin.conf ./data

# Создаем сервисный файл
sudo tee /etc/systemd/system/fractald.service > /dev/null << EOF
[Unit]
Description=Fractal Node
After=network-online.target
[Service]
User=$USER
ExecStart=/root/fractald-0.1.8-x86_64-linux-gnu/bin/bitcoind -datadir=/root/fractald-0.1.8-x86_64-linux-gnu/data/ -maxtipage=504576000
Restart=always
RestartSec=5
LimitNOFILE=infinity
[Install]
WantedBy=multi-user.target
EOF

# Создаем кошелек
cd bin
./bitcoin-wallet -wallet=wallet -legacy create

# Извлекаем приватный ключ
./bitcoin-wallet -wallet=/root/.bitcoin/wallets/wallet/wallet.dat -dumpfile=/root/.bitcoin/wallets/wallet/MyPK.dat dump
PRIVATE_KEY=$(awk -F 'checksum,' '/checksum/ {print $2}' /root/.bitcoin/wallets/wallet/MyPK.dat)

# Перезапускаем сервисный файл
sudo systemctl daemon-reload
sudo systemctl enable fractald
sudo systemctl start fractald

# Вывод IP адреса и приватного ключа
IP_ADDRESS=$(curl -s ifconfig.me)
echo "IP Address: $IP_ADDRESS"
echo "Wallet Private Key: $PRIVATE_KEY"

# Запись приватного ключа в файл
echo "Wallet Private Key: $PRIVATE_KEY" > /root/fractald_wallet_private_key.txt

# Проверка логов
#sudo journalctl -u fractald -f --no-hostname -o cat
