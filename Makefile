all: crystal shards

crystal:
	vagrant ssh alpine64 -c "cd /vagrant/testing/crystal && abuild -r"
	vagrant ssh alpine32 -c "cd /vagrant/testing/crystal && abuild -r"

shards:
	vagrant ssh alpine64 -c "cd /vagrant/testing/shards && abuild -r"
	vagrant ssh alpine32 -c "cd /vagrant/testing/shards && abuild -r"

checksum:
	vagrant ssh alpine64 -c "cd /vagrant/testing/crystal && abuild checksum"
	vagrant ssh alpine64 -c "cd /vagrant/testing/shards && abuild checksum"

up:
	vagrant up
	vagrant provision

halt:
	vagrant ssh alpine64 -c "sudo halt"
	vagrant ssh alpine32 -c "sudo halt"
