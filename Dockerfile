FROM nurdism/neko:base

COPY xfce4/ /home/neko/.config/xfce4/

RUN set -eux; apt-get update; \
    mkdir -p /usr/lib/firefox-esr/distribution/extensions /home/neko/Desktop; \
    chown -R neko:neko /home/neko/.config/xfce4/ /home/neko/Desktop; \
    apt-get install --no-install-recommends --allow-unauthenticated -f -y xfce4 firefox-esr fonts-takao-mincho mpv terminator sudo; \
    wget -O /usr/lib/firefox-esr/distribution/extensions/uBlock0@raymondhill.net.xpi https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi; \
    apt-get clean -y; \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/*; \
    echo "neko ALL=(ALL) NOPASSWD:ALL" >/etc/sudoers.d/neko 

COPY desktop /home/neko/Desktop
COPY neko.js /usr/lib/firefox-esr/mozilla.cfg
COPY autoconfig.js /usr/lib/firefox-esr/defaults/pref/autoconfig.js
COPY policies.json /usr/lib/firefox-esr/distribution/policies.json
COPY supervisord.conf /etc/neko/supervisord/xfce4.conf
COPY default.pa /etc/pulse/default.pa

RUN chmod +x /home/neko/Desktop/*.desktop