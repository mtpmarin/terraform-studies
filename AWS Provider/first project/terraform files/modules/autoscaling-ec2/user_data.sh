#!/bin/bash

set -e

yum update -y

yum install -y httpd git

systemctl enable httpd

sed -i 's/^#LoadModule rewrite_module/LoadModule rewrite_module/' /etc/httpd/conf.modules.d/00-base.conf
sed -i 's/^#LoadModule headers_module/LoadModule headers_module/' /etc/httpd/conf.modules.d/00-base.conf

echo "ServerName localhost" >> /etc/httpd/conf/httpd.conf

cat << 'EOF' > /etc/httpd/conf.d/spa.conf
DocumentRoot "/var/www/html"

<Directory "/var/www/html">
    AllowOverride All
    Require all granted
</Directory>

DirectoryIndex index.html
EOF

cat << 'EOF' > /etc/httpd/conf.d/headers.conf
<IfModule mod_headers.c>
    Header always set X-Content-Type-Options "nosniff"
    Header always set X-Frame-Options "SAMEORIGIN"
    Header always set X-XSS-Protection "1; mode=block"
</IfModule>
EOF

cat << 'EOF' > /etc/httpd/conf.d/spa-rewrite.conf
<IfModule mod_rewrite.c>
    RewriteEngine On
    RewriteBase /
    RewriteCond %{REQUEST_FILENAME} !-f
    RewriteCond %{REQUEST_FILENAME} !-d
    RewriteRule ^ index.html [L]
</IfModule>
EOF

rm -rf /var/www/html/*

git clone https://github.com/seu-usuario/sua-spa-exemplo.git /var/www/html

chown -R apache:apache /var/www/html
chmod -R 755 /var/www/html

systemctl start httpd
systemctl restart httpd