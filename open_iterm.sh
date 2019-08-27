#!/bin/bash

set -e

osascript - <<EOF
tell application "iTerm2"
    active
    create window with default profile
end tell
EOF
