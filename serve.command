#!/usr/bin/env bash
# Double-click this file on macOS to preview the lander.
# (You may need to right-click → Open the first time to allow execution.)
# Linux users: chmod +x serve.command && ./serve.command

cd "$(dirname "$0")" || exit 1

PORT=5577

# Open the browser shortly after the server boots
(sleep 1 && (open "http://localhost:$PORT/" 2>/dev/null || xdg-open "http://localhost:$PORT/" 2>/dev/null)) &

echo
echo "  Elevates Lander — local preview"
echo "  --------------------------------"
echo "  Serving on http://localhost:$PORT/"
echo "  Press Ctrl+C to stop."
echo

if command -v python3 >/dev/null 2>&1; then
  python3 -m http.server "$PORT"
elif command -v python >/dev/null 2>&1; then
  python -m http.server "$PORT"
elif command -v npx >/dev/null 2>&1; then
  npx -y serve -l "$PORT" .
else
  echo "Python and Node are not installed. Install Python 3 from https://python.org or Node from https://nodejs.org and try again."
  read -r -p "Press Return to close..." _
fi
