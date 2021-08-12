#!/bin/bash

flatpak remote-add --if-not-exists flathub \
  https://dl.flathub.org/repo/flathub.flatpakrepo

FLATPAK=( \
  #"com.jetbrains.IntelliJ-IDEA-Community"
  #"com.microsoft.Teams"
  #"flathub us.zoom.Zoom" 
  #"flathub com.discordapp.Discord" 
  "flathub im.riot.Riot"
  #"flathub com.slack.Slack" 
  #"flathub com.spotify.Client" 
  #"flathub com.google.AndroidStudio"
)

for apps in "${FLATPAK[@]}"; do
  flatpak install $apps -y
done
