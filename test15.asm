; 在DOS下, 按下"A"键后, 除非不再松开, 如果松开, 就显示满屏幕的"A", 其他的键照常处理.
assume cs:code
stack segment
    db 128 dup (0)
stack ends
code segment
start:  mov ax, stack
        mov ss, ax
        mov sp, 128
        
        push cs
        pop ds
        mov si, offset int9
        
        mov ax, 0
        mov es, ax
        mov di, 204h
        
        mov cx, offset int9end - offset int9
        cld
        rep movsb
        
        push es:[9*4]
        pop es:[200h]
        push es:[9*4+2]
        pop es:[202h]; 原来的int 9地址存放在0:200h
        
        cli
        mov word ptr es:[9*4], 204h
        mov word ptr es:[9*4+2], 0; 新的int 9地址存放在0:204h
        sti
        
        mov ax, 4c00h
        int 21h
        
int9:   push ax
        push es
        push bx
        push cx
        
        in al, 60h
        
        pushf
        call dword ptr cs:[200h]
        
        cmp al, 9eh; 9eh是A键松开后的断码
        jne int9ret
               
        mov ax, 0b800h
        mov es, ax
        mov bx, 0
        mov cx, 2000
s:      mov byte ptr es:[bx], 'A'
        add bx, 2
        loop s
        
int9ret:pop cx
        pop bx
        pop es
        pop ax        
        iret
int9end:nop
        
code ends
end start