#!/bin/bash
yum -y install httpd
systemctl enable httpd
systemctl start httpd
echo '<html><h1>Yo Man ça va?</h1></html>' > /var/www/html/index.html