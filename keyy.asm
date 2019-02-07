;10b 8X3 keypad
;(display row and column)
data segment

col db 00h
row db 0h
pa equ 0ce00h
pc equ 0ce02h
pctrl equ 0ce03h
key db 00h
newline db 0ah,0dh,'$'
data ends
code segment
assume cs:code,ds:data
start:mov ax,data
      mov ds,ax
      mov dx,pctrl
      mov al,90h
      out dx,al
      mov dx,offset newline
      mov ah,09h
      int 21h
      call keyscan
      cmp bl,0ah
      jb n
      cmp bl,0fh
      jbe n1
      mov dh,bl
      and dh,0f0h
      mov cl,04h
      ror dh,cl
      add dh,30h
      mov dl,dh
      mov ah,02h
      int 21h
      and bl,0fh
      add bl,30h
      mov dl,bl
      int 21h
      jmp next

  n1: add bl,07h
  n:  mov dl,bl
      add dl,30h
      mov ah,02h
      int 21h
next: mov dx,offset newline
      mov ah,09h
      int 21h
      mov dl,bh
      add dl,30h
      mov ah,02h
      int 21h
      mov dx,offset newline
      mov ah,09h
      int 21h
      mov dl,ch
      add dl,30h
      mov ah,02h
       int 21h
      mov ah,4ch
      int 21h
      keyscan proc near
      top:mov bh,03
          mov bl,10h
          mov ch,04
    again:mov al,ch
          mov dx,pc
          out dx,al
          mov dx,pa
          in al,dx
          cmp al,00
          jnz keypressed
          sub bl,08h
          ror ch,01
          dec bh
          jnz again
          jmp top
keypressed:mov cl,08
            mov ch,00
         t1:ror al,01
           jc t
           inc bl
           inc ch
           dec cl
           jnz t1
         t:ret
       keyscan endp
        code ends
        end start
