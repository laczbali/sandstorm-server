FROM ubuntu:22.04

# create user for steam
RUN adduser \
	--home /home/steamuser \
	--disabled-password \
	--shell /bin/bash \
	--gecos "user for running steam" \
	--quiet \
	steamuser

# install dependencies
RUN apt-get update
RUN apt-get install -y curl lib32gcc-s1

# download SteamCMD and make the Steam directory owned by steamuser
RUN mkdir -p /opt/steamcmd &&\
    cd /opt/steamcmd &&\
    curl -s https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar -vxz &&\
    chown -R steamuser:steamuser /opt/steamcmd

# install the server
USER steamuser
RUN /opt/steamcmd/steamcmd.sh +login anonymous +app_update 581330 validate +exit

# set up the environment
EXPOSE 27102/udp
EXPOSE 27102/tcp
EXPOSE 27131/udp
EXPOSE 27131/tcp

# add entrypoint script
COPY start.sh /home/steamuser/start.sh
WORKDIR /home/steamuser/Steam/steamapps/common/sandstorm_server
CMD ["./start.sh"]
