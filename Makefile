all:
	vagrant up --provision
	vagrant ssh crystal-alpine64 -c "cd /vagrant/testing/crystal && abuild -r"
	vagrant ssh crystal-alpine64 -c "cd /vagrant/testing/crystal && abuild -r"
	vagrant ssh crystal-alpine32 -c "cd /vagrant/testing/shards && abuild -r"
	vagrant ssh crystal-alpine32 -c "cd /vagrant/testing/shards && abuild -r"
	vagrant halt
