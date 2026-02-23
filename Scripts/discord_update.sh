#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "run the script with root sudo"
  exit 1
fi

wget -q --show-progress "https://discord.com/api/download?platform=linux&format=tar.gz" -O /tmp/discord.tar.gz

rm -rf /opt/discord
mkdir -p /opt/discord
tar -xzf /tmp/discord.tar.gz -C /opt/discord --strip-components=1

ln -sf /opt/discord/Discord /usr/bin/discord

sed -i 's|^Exec=.*|Exec=/usr/bin/discord|' /opt/discord/discord.desktop
sed -i 's|^Icon=.*|Icon=/opt/discord/discord.png|' /opt/discord/discord.desktop

rm -f /usr/share/applications/discord.desktop
cp /opt/discord/discord.desktop /usr/share/applications/discord.desktop

rm /tmp/discord.tar.gz

sudo -u $SUDO_USER /usr/bin/discord &

echo "discord update success"
