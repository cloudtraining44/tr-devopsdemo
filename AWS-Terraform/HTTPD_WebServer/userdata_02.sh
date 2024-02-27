#!/bin/bash
apt update -y
apt install apache2 -y
systemctl start apache2

systemctl start httpd.service
systemctl enable httpd.service
cat << 'EOF' > /var/www/html/index.html
<!DOCTYPE html>
<html>
<body>

<h1> Welcome to Web 02 Server </h1>

</body>
</html>
EOF