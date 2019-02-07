;program to right to left
data segment
portc equ 0ce02h
portb equ 0ce01h
cw equ 0ce03h
cod1 db 0ffh,0ffh,0ffh,0ffh,99h,0b0h,0a4h,0f9h, 80h, 0f8h, 082h, 092h
data ends
code segment
assume cs:code,ds:data
start:  mov ax,data
        mov ds,ax
        mov al,80h
        mov dx,cw
        out dx,al
        mov cl,05h
        lea si,cod1
    top:    add si,03
        call display
        call delay
        add si,02
        dec cl
        jnz top
        mov ah,4ch
        int 21h
        display proc near
        mov bh,04
nextchar:     mov al,[si]
              mov bl,08
     nextbit: rol al,01
              mov ch,al
              mov dx,portb
              out dx,al
              mov al,00h
              mov dx,portc
              out dx,al
              mov al,0ffh
              out dx,al
              mov al,ch
              dec bl
              jnz nextbit
              dec si
              dec bh
              jnz nextchar
              ret
              display endp
              delay proc
              push bx
              t2:mov di,0ffffh
              t1:dec bx
              jnz t1
              dec di
              jnz t2
              pop bx
              ret
              delay endp
              code ends
               end start
