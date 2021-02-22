#!/bin/bash
# Install the speedtest cli from https://www.speedtest.net/apps/cli

sudo apt-get -y install gnupg1 apt-transport-https dirmngr
export INSTALL_KEY=379CE192D401AB61
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys $INSTALL_KEY
echo "deb https://ookla.bintray.com/debian generic main" | sudo tee  /etc/apt/sources.list.d/speedtest.list
sudo apt-get -y update
# Other non-official binaries will conflict with Speedtest CLI
# Example how to remove using apt-get
# sudo apt-get remove speedtest-cli
sudo apt-get -y install speedtest

# Run the CLI the first time to accept conditions
speedtest

# The CLI supports
# speedtest --format=[default, human-readable | csv | tsv | json | jsonl | json-pretty]

