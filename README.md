# lava-healthchecks-binary

Collection of healthchecks for LAVA labs.

This is the kernel/dtb/rootfs repository which must be used along with https://github.com/montjoie/lava-healthchecks.

## hosting

If you want to host locally all healthchecks, a docker is provided:

* Modify healthchecks with:
```
sed -i "s,https://github.com/montjoie/lava-healthchecks-binary/blob/master,http://$(ip route | awk '/^default/ { print $3 }'):8080," health-checks/*
```
* Run docker build . -t lava-healthchecks-binary-www
* Run docker run -p 8080:80 lava-healthchecks-binary-www
