#!/bin/bash

echo "$(playerctl metadata | grep artUrl | awk '{ print $3 }' | sed 's#file://##g')"
