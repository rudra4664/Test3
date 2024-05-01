#!/bin/bash

pid_file="pid_file.txt"
mem_file="mem_file.txt"

> "$pid_file"
> "$mem_file"

ps -eo pid,user,cmd --no-headers | awk '$2 != "root" {print $1,$3}' > "$pid_file"

awk -F " " '{print $1}' "$pid_file" > temp_log

echo "PID   RAM   CPU" > "$mem_file"

while read PID; do
    RAM=$(ps -p "$PID" -o %mem --no-headers)
    CPU=$(ps -p "$PID" -o %cpu --no-headers)
    echo "$PID    $RAM   $CPU" >> "$mem_file"
done < temp_log

rm temp_log
