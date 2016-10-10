all: crystal shards

crystal:
	vagrant ssh alpine64 -c "cd /vagrant/testing/crystal && abuild -r"
	vagrant ssh alpine32 -c "cd /vagrant/testing/crystal && abuild -r"

shards:
	vagrant ssh alpine64 -c "cd /vagrant/testing/shards && abuild"
	vagrant ssh alpine32 -c "cd /vagrant/testing/shards && abuild"

checksum:
	vagrant ssh alpine64 -c "cd /vagrant/testing/crystal && abuild checksum"
	vagrant ssh alpine64 -c "cd /vagrant/testing/shards && abuild checksum"

up:
	vagrant up --provision

halt:
	vagrant ssh alpine64 -c "sudo halt"
	vagrant ssh alpine32 -c "sudo halt"
