#!/bin/bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
. ~/.nvm/nvm.sh
nvm install node

# node -e "console.log('Running Node.js ' + process.version)"
cd /var/www/html/
# if [ ! -f /var/www/html/lab-app.tgz ]; then
# cd /var/www/html
wget https://github.com/AzharHusain/realtimechatapp
tar xvfz realtimechatapp.tgz
# fi
curl https://github.com/AzharHusain/realtimechatapp -o realtimechatapp