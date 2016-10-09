Vagrant.configure(2) do |config|
  config.ssh.shell = "sh"

  config.vm.synced_folder "./conf", "/home/vagrant/.abuild"
  config.vm.synced_folder "./packages", "/home/vagrant/packages"

  %w(alpine32 alpine64).each do |box_name|
    config.vm.define box_name do |app|
      app.vm.provider "lxc" do |lxc, conf|
        conf.vm.box = "ysbaddaden/#{box_name}"
        lxc.container_name = "crystal-abuild-#{box_name}"
      end
    end
  end

  config.vm.provision "shell", inline: <<-SHELL
    if ! $(grep -q /home/vagrant/packages /etc/apk/repositories); then
      echo "file:///home/vagrant/packages/testing" >> /etc/apk/repositories
    fi
    ln -sf /home/vagrant/.abuild/*.pub /etc/apk/keys/

    sed -i 's/v3.3/v3.4/' /etc/apk/repositories
    apk update
    apk upgrade

    apk add alpine-sdk clang llvm-static llvm-dev
    apk add crystal yaml-dev

    addgroup vagrant abuild
    setup-apkcache /var/cache/apk

    # spec deps:
    #apk add libxml2-dev openssl-dev readline-dev gmp-dev
  SHELL
end
