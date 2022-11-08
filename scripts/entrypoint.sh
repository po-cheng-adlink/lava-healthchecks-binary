#!/bin/bash -e

echo '
server.document-root = "'${ROOT}'"
server.port = '${PORT_HTTP}'
dir-listing.activate = "enable"
server.dir-listing = "enable"
' > /etc/lighttpd.conf

echo "
listen=YES
local_enable=NO
anonymous_enable=YES
no_anon_password=YES
anon_upload_enable=YES
anon_mkdir_write_enable=YES
anon_other_write_enable=YES
anon_world_readable_only=NO
anon_upload_enable=YES
file_open_mode=0777
write_enable=YES
anon_root=${ROOT}
listen_port=${PORT_FTP}
ssl_enable=NO
" > /etc/vsftpd.conf

mkdir -p /var/run/vsftpd
mkdir -p /var/run/vsftpd/empty

chown root:nogroup -R ${ROOT}
chmod -R a+rw ${ROOT}/
chmod a-w ${ROOT}

if [ -d ${ROOT}/lava-healthchecks-binary -a -z "$(ls -A ${ROOT}/lava-healthchecks-binary)" ]; then
	echo "Cloning BayLibre lava-healthchecks-binary..."
	git clone https://github.com/BayLibre/lava-healthchecks-binary.git ${ROOT}/lava-healthchecks-binary
fi

echo "Hosting lighttpd on port ${PORT_HTTP} and vsftpd on ${PORT_FTP}..."
lighttpd -f /etc/lighttpd.conf &
vsftpd /etc/vsftpd.conf

sleep infinity
