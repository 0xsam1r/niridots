#!/bin/env bash

niri msg action load-config-file 

pkill -SIGUSR2 waybar
eww open clock
eww reload

makoctl reload
