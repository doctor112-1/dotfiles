#!/bin/bash

if [[ ! "$(playerctl metadata xesam:url)" == *"youtube"* ]]; then
  echo "$(playerctl metadata | grep artUrl | awk '{ print $3 }' | sed 's#file://##g')"
fi
