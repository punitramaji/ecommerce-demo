#!/bin/bash
installgit()
{
        sudo yum update -y
        sudo yum install git -y
        git --version
        if [ $? -ne 0 ];
        then
                echo "something is wrong with git"
                exit 0
        fi
}

installdocker()
{
        sudo yum install docker -y
        docker -v
        sudo service docker start
        if [ $? -ne 0 ];
        then
                echo "something is wrong with docker installation"
                exit 0
        fi
}

dockercompose()
{
        echo "installing docker-compose"
        sudo curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
        sudo chmod +x /usr/local/bin/docker-compose
        docker-compose --version
        if [ $? -ne 0 ];
        then
                echo "something is wrong with docker compose"
                exit 0
        fi
}

installmaven()
{
        sudo yum install maven -y
        mvn -version
        if [ $? -ne 0 ];
        then
                echo "something is wrong with maven"
                exit 0
        fi
}
#git install
git --version
if [ $? -ne 0 ];
then
        echo "Git is not installed"
        installgit
fi
#docker install
docker -v
if [ $? -ne 0 ];
then
        echo "Docker  is not installed"
        installdocker
else
        echo "Docker is already installed"
fi
#docker compose install
docker-compose --version
if [ $? -ne 0 ];
then
        echo "Docker compose is not installed"
        dockercompose
else
        echo "Docker compose is already installed"
fi
#install maven
mvn -version
if [ $? -ne 0 ];
then
        echo "Maven  is not installed"
        installmaven
else
        echo "Maven is already installed"
fi


#build docker image and run as a container
mvn clean install
nohup docker-compose up --build &
