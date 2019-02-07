 
data segment
porta equ 0ce00h
portb equ 0ce01h
pctrl equ 0ce03h
oct db 5 dup(0)
data ends
code segment
assume cs:code,ds:data
start:  mov ax,data
        mov ds,ax
        mov al,80h
        mov dx,pctrl
        out dx,al
        mov dx,portb
        in al,dx
        mov bl,al
        mov al,bl
        mov cl,4
        and al,0f0h
        ror al,cl
        mov bh,16
        mul bh
        
        and bl,0fh
        add al,bl
        mov ah,00
        lea si,oct
        mov ch,00
        mov cl,8
  again:div cl
        mov [si],ah
        inc ch
        cmp al,00
        jz exit
        inc si
        mov ah,00
        jmp again
exit:   lea si, oct
        mov bl,ch
        dec bl
        mov bh,00
        add si,bx
   top: mov al,[si]
        mov dx,porta
        out dx,al
        dec si
        dec ch
        jnz top
        mov ah,4ch
        int 21h
        code ends
        end start

