FROM steamcmd

USER steamuser
RUN /opt/steamcmd/steamcmd.sh +login anonymous +app_update 581330 validate +exit
WORKDIR /home/steamuser/Steam/steamapps/common/sandstorm_server

CMD tail -f /dev/null
