FROM ubnutu:rolling
LABEL maintainer="orangzz <bayesianifeg1@gmail.com>"

WORKDIR /app

ARG UID=1000
ARG GID=1000
ARG USERNAME=zsh
ARG USERGROUP=shell


RUN rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man \
  && apt-get clean \
  && groupadd -g ${GID} $USERGROUP \
  && useradd --create-home --no-log-init -u ${UID} -g ${GID} $USERNAME \
  && chown $USERNAME:$USERGROUP -R /app \
  && usermod --shell /bin/zsh $USERNAME

ENV  PYTHONUNBUFFERED=true \
  PYTHONPATH=. \
  PATH="(/home/$USERNAME/.local/bin  $PATH)" \
  USER=${USERNAME}


USER ${USERNAME}

# COPY --chown=$USERNAME:$USERGROUP webserver /usr/local/bin
COPY --chown=${USERNAME}:${USERGROUP} zsh /home/${USERNAME}

RUN if [ -f /home/${USERNAME}/boostrap.sh]; then \
  chmod +x /home/${USERNAME}/bootstrap.sh; \
  /home/${USERNAME}/bootstrap.sh; \
fi

WORKDIR /home/${USERNAME}

RUN cp -vf /home/${USERNAME}/zshrc.zsh /home/${USERNAME}/.zshrc
# RUN SHELL=/bin/zsh zsh -i -lc -- ''
CMD ["zsh", "-i", "-l"]



# EXPOSE 8008
# COPY entrypoint.sh /entrypoint.sh
# ENTRYPOINT ["/entrypoint.sh"]

# CMD ["webserver", "0.0.0.0:8008"]
