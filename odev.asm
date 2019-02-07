;parity bits Even-FFF Odd-000
data segment
porta equ 280h
portb equ 281h
cr equ 283h
data ends
code segment
assume cs:code,ds:data
start:  mov ax,data
        mov ds,ax
        mov al,82h
        mov dx,cr
        out dx,al
        
        mov dx,portb
        in al,dx
        mov bl,al
        add al,00h
        jpe dispff
        mov dx,porta
        mov al,00
        out dx,al
        jmp next
 dispff:mov al,0ffh
        mov dx,porta
        out dx,al
   next:mov ah,01h
        int 21h
        mov al,00h
        mov ch,08
repeat:shr bl,1
        jnc x1
        inc al
     x1:dec ch
        jnz repeat
        mov dx,porta
        out dx,al
        mov ah,4ch
        int 21h
        code ends
        end start

