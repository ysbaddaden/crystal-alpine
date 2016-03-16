all:
	vagrant up --provision
	vagrant ssh alpine64 -c "cd /vagrant/testing/crystal && abuild -r"
	vagrant ssh alpine64 -c "cd /vagrant/testing/shards && abuild -r"
	vagrant ssh alpine32 -c "cd /vagrant/testing/crystal && abuild -r"
	vagrant ssh alpine32 -c "cd /vagrant/testing/shards && abuild -r"
	vagrant destroy
