#!/bin/bash

<< work
 this is the script to deploy a python notes application into a docker contianer
work


git_clone(){

echo "clonning git repo..."
if [ -d "django-notes-app" ]; then
echo "This directory already exist"

else
 git clone https://github.com/LondheShubham153/django-notes-app.git || {
echo "failed to clone the app"
return 1
}
fi
cd django-notes-app || return 1

}

install_requirements(){
echo "Installing and checking dependencies exit "

if command -v nginx >/dev/null 2>&1; then
echo "nginx already exist!"
else yum install -y nginx || { 
echo "failed to install nginx" 
return 1
}
fi

if command -v docker-compose >/dev/null 2>&1; then
echo "docker-compose already exist!"
else yum install -y docker-compose  || { 
echo "failed to install docker-compose!" 
return 1
}
fi

}

required_restart(){
echo "restarting required services!"
systemctl restart nginx
systemctl restart docker
}

deploy(){
echo "building and deploying djnago-app"
docker build -t notes-app . || {
echo "failed to build the app"
return 1
}
docker-compose up -d || {
echo "failed to deploy the app"
return 1
}

}

echo "****************Deployment Start********************"

if ! git_clone; then
cd django-notes-app || exit 1
fi

if ! install_requirements; then
exit 1
fi

if ! required_restart; then
echo " required services are failed to start!"
exit 1
fi
if ! deploy; then
echo "deployment failed , sending mail to admin..."
exit 1
fi

echo "****************Deployment done********************"
