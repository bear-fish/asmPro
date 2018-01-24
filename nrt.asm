; 计算一个数(word型)的n次方
; 参数: 
; (cx)=n次方的值,代表多少次方
; (bx)=要计算的数
; 返回值:
; (dx)=结果的高8位
; (ax)=结果的低8位
nrt:    push cx       
        jcxz while0
        mov ax, bx       
        dec cx
        jz nrtret        
cont:   mul bx
        loop cont
        jmp short nrtret
while0: mov dx, 0
        mov ax, 1        
nrtret: pop cx
        ret