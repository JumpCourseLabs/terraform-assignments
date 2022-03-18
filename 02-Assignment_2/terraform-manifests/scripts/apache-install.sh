#! /bin/bash

sudo yum update -y
sudo yum install -y httpd
sudo service httpd start
sudo systemctl enable httpd
echo "<h1>JUMP Terraform Lab Assignement 2</h1><h2>Everything is running</h2><p>Instance Scripted by Michael Phelps</p>" > /var/www/html/index.html
