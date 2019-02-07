data segment
pctrl equ 0ce03h
pc equ 0ce02h
pb equ 0ce01h
code1 db 0ffh,0ffh,0ffh,99h,0b0h,0a4h,0fah,80h,0f8h,82h,92h
count db 03
data ends
code segment
assume cs:code,ds:data
start:mov ax,data
      mov ds,ax
      mov dx,pctrl
      mov al,80h
      out dx,al
      mov cl,05h
      mov si,offset code1
top: add si,03
     call display
     call delay
     add si,02
     dec cl
     jnz top
     mov ah,4ch
     int 21h
     display proc near
     mov bh,04h
top1: mov bl,08h
      mov al,[si]
top2:rol al,01
     mov ch,al
     mov dx,pb
     out dx,al
     mov al,00h
     mov dx,pc
     out dx,al
     mov al,0ffh
     mov dx,pc
     out dx,al
     mov al,ch
     dec bl
     jnz top2
     dec si
     dec bh
     jnz top1
     ret
     display endp
     delay proc near
     push bx
  t:mov di,0ffffh
  t1:dec bx
     jnz t1
     dec di
     jnz t
     pop bx
     ret
     delay endp
     code ends
     end start

