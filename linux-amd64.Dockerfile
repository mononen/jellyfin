FROM hotio/dotnetcore@sha256:29b38e2c58e1f34968764da042f48ab52840a25eb30466d6e81a16010e9ac19a

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 8096

# install packages
RUN apt update && \
    apt install -y --no-install-recommends --no-install-suggests \
        libass9 libbluray2 libdrm2 libfribidi0 libmp3lame0 libopus0 libtheora0 libva-drm2 libva2 libvdpau1 libvorbis0a libvorbisenc2 libwebp6 libwebpmux3 libx11-6 libx264-152 libx265-146 libzvbi0 \
        at \
        libfontconfig1 \
        libfreetype6 \
        libdrm-intel1 \
        i965-va-driver \
        mesa-va-drivers && \
# clean up
    apt autoremove -y && \
    apt clean && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

ARG FFMPEG_VERSION

# install ffmpeg
RUN debfile="/tmp/ffmpeg.deb" && curl -fsSL -o "${debfile}" "https://repo.jellyfin.org/releases/server/ubuntu/ffmpeg/jellyfin-ffmpeg_${FFMPEG_VERSION}-bionic_amd64.deb" && dpkg --install "${debfile}" && rm "${debfile}"

ARG JELLYFIN_VERSION

# install app
RUN debfile="/tmp/jellyfin.deb" && curl -fsSL -o "${debfile}" "https://repo.jellyfin.org/releases/server/ubuntu/stable/jellyfin_${JELLYFIN_VERSION}_amd64.deb" && dpkg --install "${debfile}" && rm "${debfile}"

COPY root/ /
