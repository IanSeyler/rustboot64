#!/bin/bash

nasm bootsectors/bmfs_mbr.asm -o ../bmfs_mbr.sys
nasm pure64.asm -o ../pure64.sys
