; 编程, 向内存0:200-0:23F依次传送数据0-63(3FH).
assume cs:code
code segment
start: mov ax,20h
       mov ds,ax
       mov bx,0; ds:[bx]指向内存0:200h处
       mov cx,63; 循环次数63次
s:     mov [bx],bx
       inc bx
       loop s
       mov ax,4c00h
       int 21h
code ends
end start