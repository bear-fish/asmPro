; 名称: dtoc
; 功能: 将word型数据转变为表示十进制数的字符串, 字符串以0为结尾符.
; 参数: (ax)=word型数据
;       ds:si指向字符串的首地址
; 返回: 无
dtoc:       push dx 
            push cx
            push si                      
            
            mov dx, 0
            push 0
cont:       mov cx, 10
            call divdw
            jcxz stod
            add cx, 30h
            push cx
            jmp short cont
            
stod:       pop cx
            mov [si], cl
            jcxz dtocret
            inc si 
            jmp short stod           
        
 dtocret:   pop si 
            pop cx
            pop dx
            ret

; 参数: (ax)=dword型数据的低16位
;       (dx)=dword型数据的高16位
;       (cx)=除数
; 返回: (dx)=结果的高16位, (ax)=结果的低16位
;       (cx)=余数
divdw:  push bx 

        push ax 
        mov ax, dx 
        mov dx, 0
        div cx ; 此时ax中为int(H/N), dx中为rem(H/N)
        pop bx 
        push ax
        mov ax, bx
        div cx; 此时ax为[rem(H/N)*10000H+L]/N
        mov cx, dx
        pop dx

        pop bx
        ret