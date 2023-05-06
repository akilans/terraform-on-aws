#!/bin/bash
sudo echo "hello" > /tmp/hello.txt
sudo yum update -y
sudo yum install -y httpd
sudo systemctl enable httpd
sudo service httpd start
sudo HOSTNAME=`hostname`
sudo echo "<h1>${HOSTNAME}</h1>" > /var/www/html/index.html
sudo echo '<h2>Welcome to Terraform</h2>' >> /var/www/html/index.html