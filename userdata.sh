#!/bin/bash
yum update -y
yum install -y httpd.x86_64
systemctl start httpd.service
systemctl enable httpd.service
cat << 'EOF' > ./index.html
<!DOCTYPE html>
<html>
<body>

<h1>Welcome to DevOps Training</h1>
<p>This is Demo.</p>

<a href="https://www.w3schools.com">The best place to learn HTML is w3schools</a>

</body>
</html>
EOF
