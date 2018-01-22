; 下面的程序的功能是将"mov ax,4c00h"之前的指令复制到内存0:200h处.
; 进入debug调试时cx中保存着源码的长度为1BH.
; cx中的循环次数为源码总长度减去"mov ax,4c00h"指令之后的长度.
; 因此cx中的数值应为1BH-5=16H
assume cs:code
code segment
start: mov ax,cs
       mov ds,ax
       mov ax,0020h
       mov es,ax
       mov bx,0
       mov cx,16h
s:     mov al,[bx]
       mov es:[bx],al
       inc bx
       loop s
       mov ax,4c00h
       int 21h
code ends
end start