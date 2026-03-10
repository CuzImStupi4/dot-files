
#!/bin/bash

echo "removing screens..."
screen -X -S api quit 2>/dev/null
screen -X -S dash quit 2>/dev/null

echo "starting antigravity..."
(cd ~/git/api/ && antigravity .) &
(cd ~/git/dashboard/ && antigravity .) &

echo "starting screens..."
screen -dmS api bash -c "cd ~/git/api/ && bun --watch server.js"
screen -dmS dash bash -c "cd ~/git/dashboard/ && bun dev"
