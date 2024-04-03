#!/bin/bash

set -e

if [ -w floppy.img ];then
	FLOPPY=floppy.img
	MNT=mnt
elif [ -w aux/floppy.img ];then
	FLOPPY=aux/floppy.img
	MNT=aux/mnt
else
	echo 'ERRO: Não foi possivel achar a imagem floppy.img'
	exit 1
fi

if [ -r kernel.bin ];then
	KERNEL=kernel.bin
elif [ -r ../kernel.bin ];then
	KERNEL=../kernel.bin
else
	echo 'ERRO: Não foi possível achar o kernel'
	exit 2
fi

mkdir -p $MNT
sudo mount -o loop $FLOPPY $MNT
sudo cp $KERNEL $MNT
sudo umount $MNT
rmdir $MNT

#qemu-system-i386 -fda $FLOPPY
qemu-system-i386 -drive format=raw,file=$FLOPPY,if=floppy
