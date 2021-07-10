#!/bin/bash 
### Adjusting resolv.conf
sudo echo "### Adding Google DNS ###" > /etc/resolv.conf
sudo echo "nameserver 8.8.8.8" >> /etc/resolv.conf
### End DNs Adjusts ###

### Docker Install ###
yum update -y
sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine
sudo yum install -y yum-utils -y
sudo yum install net-tools -y
sudo yum install mariadb.x86_64 -y
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce docker-ce-cli containerd.io -y
### End Docker Install ###

### Docker Service Configuration ###
sudo systemctl enable docker
sudo systemctl start docker
### FIM ###

### Subindo Containers ###
#sudo docker run -d -p 3000:3000 -v "/vagrant/docker/grafana:/var/lib/grafana" --restart always grafana/grafana
sudo docker run -d -p 3000:3000 --name=grafana --restart always grafana/grafana
sudo docker run --name mariadb01 -p 3306:3306 --restart always -e MYSQL_ROOT_PASSWORD='teste123' -d mariadb --log-bin --binlog-format=MIXED
sudo docker run -p 8080:8080 --name=jenkins-master --restart always jenkins/jenkins #after starting cotainer for the frst time, execute the command to get pass: docker exec jenkins-master cat /var/jenkins_home/secrets/initialAdminPassword


#build_name, build_number, solicitante, staus_build, number_status_build
#Criando a database
#create database jenkins;
#use jenkins;
#CREATE TABLE pipelines(build_name varchar(50) NOT NULL, build_number varchar(6) not null, solicitante varchar(50) not null, number_status_build varchar(3) not null, data datetime);

