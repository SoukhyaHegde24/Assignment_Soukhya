#!/bin/bash
chmod +x script1.sh
sudo apt update
sudo apt install python-pip python-dev libpq-dev postgresql postgresql-contrib nginx curl
sudo -H pip install virtualenv
cd myprojectdir
sudo pip install virtualenv
virtualenv myprojectenv
sudo source myprojectenv/bin/activate
sudo pip install django gunicorn psycopg2-binary
##python manage.py runserver
#gunicorn --bind 0.0.0.0:8000 myproject.wsgi
sudo cat new1.txt >>sudo /etc/systemd/system/gunicorn.socket
sudo cat new2.txt >> sudo /etc/systemd/system/gunicorn.service
sudo systemctl start gunicorn.socket
sudo systemctl enable gunicorn.socket
file /run/gunicorn.sock
curl --unix-socket /run/gunicorn.sock localhost
sudo systemctl daemon-reload
sudo systemctl restart gunicorn
#sudo cat new3.txt >> sudo /etc/nginx/sites-available/myproject 
#sudo ln -s /etc/nginx/sites-available/myproject /etc/nginx/sites-enabled
#sudo rm -r /etc/nginx/sites-available/myproject /etc/nginx/sites-enabled 
sudo nginx -t
sudo systemctl restart nginx
sudo systemctl start postgresql
sudo systemctl enable postgresql
sudo nginx -t && sudo systemctl restart nginx
python manage.py runserver
#sudo systemctl status gunicorn.socket


