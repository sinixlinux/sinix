#!/bin/bash

echo "WARN: ensure you have the repo cloned first!"
sleep 6

cd
cd sinix
mkdir -p /etc/sinix/src/
cp src/decla/* /etc/sinix/src/
cp example_config.lua /etc/sinix/

echo "Repair complete. If you can't use sinix-rebuild or sinixcfg, run our separate script."
