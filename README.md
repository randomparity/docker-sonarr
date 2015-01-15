docker-sonarr
=============

Sonarr/NZBDrone daemon running in a container. The default paths have been altered to:

 * `/config`
 * `/download`
 * `/media`

`sonarr` runs with the HTTP RPC interface listening on TCP port `8989`. The HTTP RPC interface is configured to not use authentication.

Assumptions
-----------

I use a NAS with a "download" and a "media" share with the following structure:

  - Download                - Completed downloads
  - Download\Usenet         - Watch directory for .nzb files
  - Download\Usenet\Working - Working directory where "in progress" files are located
  - Media
  - Media\Television

The container's `download` directory is mounted from `/mnt/download`, the `config` directory is mounted from `/etc/docker/sonarr`, and the `media` directory is mounted from `/mnt/media/television`.  The `/etc/docker/sonarr` directory is configured with world writeable permissions (e.g. `chmod 777 /etc/docker/sonarr`).

Quick-start
-----------

`docker run -d --restart always -h sonarr --name sonarr -v /mnt/download:/download -v /etc/docker/sonarr:/config -v /mnt/media/television:/media -v /etc/localtime:/etc/localtime:ro -p 8989:8989 randomparity/docker-sonarr:latest`

Then open `http://<docker host IP>:8989` in a browser.
