Vagrant.configure(2) do |config|
  config.ssh.shell = "sh"

  config.vm.synced_folder "./conf", "/home/vagrant/.abuild"
  config.vm.synced_folder "./packages/testing/", "/home/vagrant/packages/testing"

  %w(alpine32 alpine64).each do |box_name|
    config.vm.define box_name do |app|
      app.vm.provider "lxc" do |lxc, conf|
        conf.vm.box = "ysbaddaden/#{box_name}"
        lxc.container_name = "crystal-abuild-#{box_name}"
      end
    end
  end

  config.vm.provision "shell", inline: <<-SHELL
    echo "http://dl-cdn.alpinelinux.org/alpine/v3.6/main" > /etc/apk/repositories
    echo "http://dl-cdn.alpinelinux.org/alpine/v3.6/community" >> /etc/apk/repositories
    echo "file:///home/vagrant/packages/testing" >> /etc/apk/repositories
    ln -sf /home/vagrant/.abuild/*.pub /etc/apk/keys/

    apk update
    apk upgrade
    apk add alpine-sdk crystal

    addgroup vagrant abuild
    setup-apkcache /var/cache/apk

    # spec deps:
    #apk add libxml2-dev openssl-dev readline-dev gmp-dev yaml-dev
  SHELL
end
