#!/bin/bash
yum update -y
yum install -y httpd.x86_64
systemctl start httpd.service
systemctl enable httpd.service
cat << 'EOF' > /var/www/html/index.html
<!DOCTYPE html>
<html>
<body>

<h1>Welcome to DevOps Demo, First Lab </h1>
<p>We are in Linux Essentials module.</p>

</body>
</html>
EOF