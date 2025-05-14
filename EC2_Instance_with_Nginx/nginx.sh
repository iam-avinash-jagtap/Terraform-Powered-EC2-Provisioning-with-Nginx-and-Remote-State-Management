#!/bin/bash

# Update and install Nginx
sudo yum update -y
sudo yum install nginx -y

# Start and enable Nginx
sudo systemctl start nginx
sudo systemctl enable nginx

# Overwrite the correct index.html with your custom message
echo "<h1> Welcome to nginx _ By Tech_aj Using Terraform </h1>" | sudo tee /usr/share/nginx/html/index.html
