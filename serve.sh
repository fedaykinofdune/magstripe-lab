#!/usr/bin/env bash
# Serve Magstripe Lab on http://localhost:8000
# Browsers only grant microphone access on https:// or localhost, so if opening
# index.html directly (file://) leaves the mic blocked, run this instead.
cd "$(dirname "$0")"
echo "Magstripe Lab → http://localhost:8000"
echo "Press Ctrl-C to stop."
python3 -m http.server 8000
