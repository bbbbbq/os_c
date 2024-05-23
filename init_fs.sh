#!/bin/bash

file_path="sdcard.img"

dd if=/dev/zero of="$file_path" bs=1M count=100
echo "100MB .img file has been created."

dd if=/dev/zero of="$file_path" bs=1M count=100 conv=notrunc
echo "File has been zeroed out."

if mkfs.vfat -F 32 "$file_path"; then
    echo "File has been formatted to FAT32 successfully."
else
    echo "Failed to format the file to FAT32."
fi
