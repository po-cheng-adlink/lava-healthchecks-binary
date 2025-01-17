FROM debian:bullseye-backports

RUN apt -q update
RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install \
	lighttpd \
	vsftpd

ARG extra_packages=""
RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install ${extra_packages}

ARG http_port=80
ENV PORT_HTTP=${http_port}

ARG ftp_port=21
ENV PORT_FTP=${ftp_port}

ARG root_path="/wwwroot"
ENV ROOT=$root_path
RUN mkdir -p ${root_path}

COPY scripts/entrypoint.sh /root/entrypoint.sh

ENTRYPOINT ["/root/entrypoint.sh"]
