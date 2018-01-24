; 名称: show_str
; 功能: 在指定的位置, 用指定的颜色, 显示一个用0结束的字符串.
; 参数: (dh)=行号(取值范围0-24), (dl)=列号(取值范围0-79), (cl)=颜色, ds:si指向字符串的首地址.
; 返回: 无
show_str:   push ax 
            push es
            push dx
            push di
            push cx
            push si
            
            mov ax, 0b800h
            mov es, ax
            
            mov al, 160
            mul dh
            add dl, dl
            add al, dl
            adc ah, 0 
            mov di, ax; es:di 指向要显示的位置
                                    
            mov ah, cl
            
            mov ch, 0 
cont:       mov cl, [si]
            jcxz zr
            mov al, cl; ax中保存着要显示的字符
            mov es:[di], ax
            inc si
            add di, 2
            jmp short cont
            
zr:         pop si
            pop cx 
            pop di 
            pop dx 
            pop es
            pop ax
            ret                       