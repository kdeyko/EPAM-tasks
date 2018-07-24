#!/bin/bash -v
sudo apt-get update -y
sudo apt-get install -y nginx > /tmp/nginx.log
#sudo sed -i 's/listen 80/listen 8080/' /etc/nginx/sites-available/default

echo '
<html>
<head>
<title>Awesome EC2 Web Page</title>
</head>
<body>
<h1>Hey there!
</br>
Welcome to Nginx on EC2 instance</h1>
</br>
<img src="/s3/cat.jpg">
</body>
</html>
' | sudo tee /var/www/html/index.html

echo '
server {
        listen 8080;
        access_log /var/log/nginx/aws-access.log;
        error_log /var/log/nginx/aws-error.log;

        index index.html index.htm index.nginx-debian.html;

        root /var/www/html;

        location /s3/ {
                resolver 8.8.8.8;
                proxy_set_header       Host kdeyko-aws-bucket.s3.amazonaws.com;
                proxy_pass http://kdeyko-aws-bucket.s3.amazonaws.com/;
        }
}
' | sudo tee /etc/nginx/sites-available/default

sudo service nginx start
sleep 3
sudo service nginx restart