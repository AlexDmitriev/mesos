git pull 
docker build -t competitors .
docker save competitors | gzip > competitors.tar.gz
# remove docker from registry to save space
docker rmi -f $(docker images -q op)
scp image to remote host


# REMOT HOST - MEOS MASTER AND SLAVE
# remove previous version
docker rmi -f $(docker images -q)

# load new version
docker load < competitors.tar.gz

# command example for marathon and chronos 
docker run --net=host competitors php /var/www/bin/console app:get_prices dicks -p10 -vvv
