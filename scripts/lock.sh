#!/bin/bash

# Only exported variables can be used within the timer's command.
export PRIMARY_DISPLAY="$(xrandr | awk '/ primary/{print $1}')"

# Run xidlehook
xidlehook \
  `# Don't lock when there's a fullscreen application` \
  `# --not-when-fullscreen` \
  `# Don't lock when there's audio playing` \
  --not-when-audio \
  `# Dim the screen after 10 minutes, undim if user becomes active` \
  --timer 600 \
    'xrandr --output "$PRIMARY_DISPLAY" --brightness .2' \
    'xrandr --output "$PRIMARY_DISPLAY" --brightness 1' \
  `# lock after 10 more seconds` \
  --timer 10 \
    'mantablockscreen -sc' \
    '' \
  `# turn off screen and undim after 2 more seconds` \
  --timer 30 \
    'xset dpms force off; xrandr --output "$PRIMARY_DISPLAY" --brightness 1' \
    ''