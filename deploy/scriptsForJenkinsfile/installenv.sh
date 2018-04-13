scp /var/lib/jenkins/.ssh/id_rsa root@80.211.244.222:/root/.ssh/
scp /var/lib/jenkins/.ssh/id_rsa.pub root@80.211.244.222:/root/.ssh/
ssh root@80.211.244.222 'apt-get -y update && apt-get -y install git docker docker-compose'
ssh root@80.211.244.222 'cd /root && git clone git@github.com:Fotoblysk/BazyDanychPtak.git'
