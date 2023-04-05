<<<<<<< HEAD
#!/usr/bin/env bash
# Setup a web servers for the deployment of web_static.
apt update -y
apt install -y nginx
mkdir -p /data/web_static/releases/test/
mkdir -p /data/web_static/shared/
echo "<!DOCTYPE html>
<html>
  <head>
  </head>
  <body>
    <p>Nginx server test</p>
  </body>
</html>" | tee /data/web_static/releases/test/index.html
ln -sf /data/web_static/releases/test/ /data/web_static/current
chown -R ubuntu:ubuntu /data
sudo sed -i '39 i\ \tlocation /hbnb_static {\n\t\tian /data/web_static/current;\n\t}\n' /etc/nginx/sites-enabled/default
sudo service nginx restart
=======
#!/usr/bin/python3
""" Function that compress a folder """
from datetime import datetime
from fabric.api import local
import os


def do_pack():
    try:
        if not os.path.exists("versions"):
            local('mkdir versions')
        t = datetime.now()
        f = "%Y%m%d%H%M%S"
        archive_path = 'versions/web_static_{}.tgz'.format(t.strftime(f))
        local('tar -cvzf {} web_static'.format(archive_path))
        return archive_path
    except:
        return None
>>>>>>> 9964e2e4593d82ac4324f2ead1a726498d045fa6
