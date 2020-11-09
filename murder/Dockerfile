FROM jusito/docker-ttt:gmod_debian

ENV SERVER_GAMEMODE="murder"
ENV INSTALL_CSS="true"

# Override prepareServer.sh to allow configuration of murder specific ConVars
COPY "prepareServer.sh" "/home/"
COPY "initConfigMurder.sh" "/home/"
COPY "server.cfg.default" "/home/server.cfg.default"

RUN chown "$DOCKER_USER:$DOCKER_USER" /home/prepareServer.sh && \
    chown "$DOCKER_USER:$DOCKER_USER" /home/initConfigMurder.sh && \
    chmod a=rx /home/prepareServer.sh && \
    chmod a=rx /home/initConfigMurder.sh


USER "$USER_ID:$GROUP_ID"

VOLUME "$SERVER_PATH"
