# Assignment_Soukhya

Prerequsites:

Linux Platform : Ubuntu 18.04

Programming Language : Python 2.7.12

Application server: GuniCorn

Web server: Nginx

Database: PostgreSQL

Steps involved in the project are:-

1.Install the Packages from the Ubuntu Repositories

sudo apt update

sudo apt install python-pip python-dev libpq-dev postgresql postgresql-contrib nginx curl

2.Creating the PostgreSQL Database and User

sudo -u postgres psql

CREATE DATABASE myproject;

CREATE USER myprojectuser WITH PASSWORD 'password';

ALTER ROLE myprojectuser SET client_encoding TO 'utf8';

ALTER ROLE myprojectuser SET default_transaction_isolation TO 'read committed';

ALTER ROLE myprojectuser SET timezone TO 'UTC';

GRANT ALL PRIVILEGES ON DATABASE myproject TO myprojectuser;

\q

3.Creating a Python Virtual Environment for your Project

sudo -H pip install virtualenv

mkdir ~/myprojectdir

cd ~/myprojectdir

4.Within the project directory, create a Python virtual environment by typing:

virtualenv myprojectenv

5.activate the virtual environment by typing:

source myprojectenv/bin/activate

6.Creating and Configuring a Django Project

7.Testing Gunicorn's Ability to Serve the Project

test Gunicorn to make sure that it can serve the application

We can do this by entering our project directory and using gunicorn to load the project's WSGI module:

cd ~/myprojectdir

gunicorn --bind 0.0.0.0:8000 myproject.wsgi

8.Creating systemd Socket and Service Files for Gunicorn

Start by creating and opening a systemd socket file for Gunicorn with sudo privileges

sudo nano /etc/systemd/system/gunicorn.socket

[Unit]
Description=gunicorn daemon
Requires=gunicorn.socket
After=network.target
[Service]
User=ss
Group=www-data
WorkingDirectory=/home/ss/myprojectdir
ExecStart=/home/ss/myprojectdir/myprojectenv/bin/gunicorn \
          --access-logfile - \
          --workers 3 \
          --bind unix:/run/gunicorn.sock \
          myproject.wsgi:application
[Install]
WantedBy=multi-user.target

We can now start and enable the Gunicorn socket. This will create the socket file at /run/gunicorn.sock now and at boot. When a connection is made to that socket, systemd will automatically start the gunicorn.service to handle it.

sudo systemctl start gunicorn.socket

sudo systemctl enable gunicorn.socket

9.Checking for the Gunicorn Socket File

Check the status of the process to find out whether it was able to start:

sudo systemctl status gunicorn.socket

10.Testing Socket Activation

sudo systemctl status gunicorn

To test the socket activation mechanism, we can send a connection to the socket through curl by typing:

curl --unix-socket /run/gunicorn.sock localhost

You can verify that the Gunicorn service is running by typing:

sudo systemctl status gunicorn

sudo systemctl daemon-reload

sudo systemctl restart gunicorn

11.Configure Nginx to Proxy Pass to Gunicorn

sudo nano /etc/nginx/sites-available/myproject

server {
    listen 80;
    server_name 192.168.88.130;

    location = /favicon.ico { access_log off; log_not_found off; }
    location /static/ {
        root /home/ss/myprojectdir;
    }

    location / {
        include proxy_params;
        proxy_pass http://unix:/run/gunicorn.sock;
    }
}

Save and close the file when you are finished. Now, we can enable the file by linking it to the sites-enabled directory:

sudo ln -s /etc/nginx/sites-available/myproject /etc/nginx/sites-enabled

12.Test your Nginx configuration for syntax errors by typing:

sudo nginx -t

13.restart Nginx

sudo systemctl restart nginx

Steps to run the Application are:-

1.activate the virtual environment

source myprojectenv/bin/activate

2.Change the directory to myprojectdir

3.run the application 

~/myprojectdir/manage.py runserver 0.0.0.0:8000

4.In web browser, open 127.0.0.1:8000/superapp



