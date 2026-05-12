#!/usr/bin/env bash
# Kill existing waybar instances, wait for clean exit, then restart
killall -q waybar
sleep 0.5
waybar &