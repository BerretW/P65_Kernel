del .\output\*.*

cd .\src
ca65 --cpu 65c02 main.asm -o ..\output\main.o -l ..\lst\main.lst
ca65 --cpu 65c02 acia.asm -o ..\output\acia.o  -l ..\lst\acia.ls
ca65 --cpu 65c02 pckybd.asm -o ..\output\pckybd.o  -l ..\lst\pckybd.ls
ca65 --cpu 65c02 saa1099.asm -o ..\output\saa1099.o  -l ..\lst\saa1099.ls
ca65 --cpu 65c02 vdp.asm -o ..\output\vdp.o -l ..\lst\vdp.lst
ca65 --cpu 65c02 vdp_low.asm -o ..\output\vdp_low.o -l ..\lst\vdp_low.lst
ca65 --cpu 65c02 vdp_graph.asm -o ..\output\vdp_graph.o -l ..\lst\vdp_graph.lst

ca65 --cpu 65c02 routines.asm -o ..\output\routines.o -l ..\lst\routines.lst
ca65 --cpu 65c02 vectors.asm -o ..\output\vectors.o -l ..\lst\vectors.lst
ca65 --cpu 65c02 interrupts.asm -o ..\output\interrupts.o -l ..\lst\interrupts.lst



move *.s ..\output

cd ..\output

ld65 -C ..\config\APP_RAM_DISK.cfg -m ram.map main.o routines.o vectors.o interrupts.o vdp.o vdp_low.o vdp_graph.o ..\library\p65.lib -o ..\output\RAM.bin

ld65 -C ..\config\APP_ROM_DISK.cfg -m rom.map main.o routines.o vectors.o interrupts.o vdp.o vdp_low.o vdp_graph.o ..\library\p65.lib -o ..\output\ROM.bin


e:\Projekt65\hbc-56-master\emulator\bin\Hbc56Emu.exe --lcd 1602 --keyboard --rom ..\output\ROM.bin
