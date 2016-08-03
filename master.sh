yum install -y tar wget vim
wget http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
yum install -y epel-release

sudo yum groupinstall -y "Development Tools"
sudo yum install -y apache-maven python-devel java-1.8.0-openjdk-devel zlib-devel libcurl-devel openssl-devel cyrus-sasl-devel cyrus-sasl-md5 apr-devel subversion-devel apr-util-devel

wget http://nodejs.org/dist/v0.10.30/node-v0.10.30-linux-x64.tar.gz
sudo tar --strip-components 1 -xzvf node-v* -C /usr/local
rm node-v0.10.30-linux-x64.tar.gz 

rpm -Uvh http://archive.cloudera.com/cdh4/one-click-install/redhat/6/x86_64/cloudera-cdh-4-0.x86_64.rpm
yum -y install zookeeper zookeeper-server
sudo -u zookeeper zookeeper-server-initialize --myid=1
sudo service zookeeper-server start

rpm -Uvh http://repos.mesosphere.com/el/7/noarch/RPMS/mesosphere-el-repo-7-1.noarch.rpm
yum -y install mesos-0.28.2 marathon chronos

service mesos-master start
service mesos-slave start
service marathon start
service chronos start


wget https://github.com/mesosphere/mesos-dns/releases/download/v0.5.2/mesos-dns-v0.5.2-linux-amd64
mv mesos-dns-v0.5.2-linux-amd64 /usr/local/bin/mesos-dns
chmod +x /usr/local/bin/mesos-dns

mkdir /etc/mesos-dns
cp ./config.json /etc/mesos-dns

echo "Do not forget to run mesos-dns via marathon:"
echo "mesos-dns -config=/etc/mesos-dns/config.json"


yum install nginx 
copy mesos.conf /etc/nginx/conf.d
service nginx start

service firewalld start
firewall-cmd --zone=public --add-port=80/tcp --permanent
firewall-cmd --add-interface=eth0

firewall-cmd --zone=public --add-port=8881/tcp --permanent
firewall-cmd --zone=public --add-port=8882/tcp --permanent
firewall-cmd --zone=public --add-port=8883/tcp --permanent

firewall-cmd --reload
firewall-cmd --permanent --zone=public --add-rich-rule="rule family="ipv4" source address="138.68.30.252" port protocol="tcp" port="5050" accept"
