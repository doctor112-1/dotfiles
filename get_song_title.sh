#!/bin/bash

if [[ ! "$(playerctl metadata xesam:url)" == *"youtube"* ]]; then
  echo "$(playerctl metadata --format '{{ title }}')"
fi
