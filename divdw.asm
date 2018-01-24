; 名称: divdw
; 功能: 进行不会产生溢出的除法运算, 被除数为dword型, 除数为word型, 结果为dword型.
; 参数: (ax)=dword型数据的低16位
;       (dx)=dword型数据的高16位
;       (cx)=除数
; 返回: (dx)=结果的高16位, (ax)=结果的低16位
;       (cx)=余数
;给出一个公式:
;X: 被除数
;N: 除数 
;H: X的高16位
;L: X的低16位
;int(): 描述性运算符,取商
;rem(): 描述性运算符,取余数
;公式: X/N=int(H/N)*10000H+[rem(H/N)*10000H+L]/N        
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