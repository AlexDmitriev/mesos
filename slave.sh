rpm -Uvh http://repos.mesosphere.com/el/7/noarch/RPMS/mesosphere-el-repo-7-1.noarch.rpm
yum -y install device-mapper-event-libs mesos-0.28.2 docker
/sbin/chkconfig docker on
service docker start

echo "docker,mesos" > /etc/mesos-slave/containerizers 

echo "Do not forget to update /etc/mesos/zk with master`s IP and run command:"
echo "service mesos-slave start"