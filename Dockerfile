FROM debian:wheezy

RUN useradd --create-home user

ENV SKYPE_URL http://download.skype.com/linux/skype-debian_4.3.0.37-1_i386.deb

RUN dpkg --add-architecture i386 \
    && apt-get update && apt-get install -y wget && rm -rf /var/lib/apt/lists/* \
    && wget "${SKYPE_URL}" -O skype.deb \
    && apt-get purge -y --auto-remove wget \
    && { dpkg -i skype.deb || true; } \
    && rm skype.deb \
    && apt-get update && apt-get install -y -f && rm -rf /var/lib/apt/lists/*

USER user
VOLUME /home/user
CMD ["skype"]
