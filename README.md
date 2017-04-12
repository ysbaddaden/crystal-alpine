# Crystal on Alpine Linux (APKBUILD)

See http://public.portalier.com/alpine for an APK repository.

## Requirements

- Linux host;
- [Linux Containers](https://linuxcontainers.org/) (LXC);
- [Vagrant](https://vagrantup.com);
- [vagrant-lxc](https://github.com/fgrehm/vagrant-lxc) plugin;

You also need a crystal binary (only the binary is required). You may build a
musl-libc aware statically linked compiler on the linux host, mirror the
packages repository (in the `packages` folder) or add the packages repository to
`/etc/apk/repositories`.

By default the provisioner uses the `packages` folder as a repository, because
this is where packages are built and thus available.

## Usage

You may run `make` once you have packages be built for all architectures. You
may also use vagrant manually. For example:

```sh
vagrant up --provision
vagrant ssh alpine64 -c "cd /vagrant/testing/crystal; abuild -r"
vagrant ssh alpine32 -c "cd /vagrant/testing/shards; abuild -r"
vagrant destroy
```

### Bootstrap

If you're bootstraping a compiler, you'll have to build then install the `gc`
package before trying to compile Crystal:

```sh
vagrant ssh alpine64 -c "cd /vagrant/testing/gc; abuild -r"
vagrant ssh alpine64 -c "sudo apk update ; sudo apk add --upgrade gc gc-dev"
```

### New Release

When a new version of Crystal and/or Shards is released, edit the version
numbers in the respective APKBUILD, then compute the checksums. For example:

```sh
vagrant ssh alpine64 -c "cd /vagrant/testing/crystal; apk checksum"
vagrant ssh alpine32 -c "cd /vagrant/testing/shards; apk checksum"
```

## Specs

In order to run the Crystal spec suite the following packages are required:

```sh
apk add libxml2-dev openssl-dev readline-dev gmp-dev yaml-dev
```

Please note that encoding specs use the GB2312 encoding that isn't supported by
musl-libc and are thus failing.
