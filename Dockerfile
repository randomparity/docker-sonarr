FROM randomparity/docker-supervisor:latest

MAINTAINER David Christensen <randomparity@gmail.com>

ENV LAST_UPDATE_SABNZBD 2015-01-15

# Add the Sonarr repository and install the application
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FDA5DFFC && \
    echo "deb http://apt.sonarr.tv/ master main" | \
    sudo tee /etc/apt/sources.list.d/sonarr.list && \
    apt-get -q update && \
    apt-get -qy install nzbdrone

# We've got everything we need so clear out the apt data
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/tmp/* && \
    rm -rf /tmp/*

VOLUME ["/config", "/download", "/media"]

EXPOSE 8989

# Copy the supervisord configuration files into the container
COPY sonarr.conf /etc/supervisor/conf.d/sonarr.conf

# No need to setup a CMD directive since that was handled in the FROM container.
