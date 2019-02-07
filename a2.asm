; Largest of 3 numbers
data segment
  pa equ 0ce00h
  pb equ 0ce01h
  pctrl equ 0ce03h
data ends
 code segment
    assume ds:data,cs:code
        start:   mov ax,data
                 mov ds,ax

                 mov al,82h
                 mov dx,pctrl
                 out dx,al

                 mov dx,pb
                 in al,dx
                 mov bl,al

                 mov ah,01h
                 int 21h

                 mov dx,pb
                 in al,dx
                 mov bh,al

                 mov ah,01h
                 int 21h

                 mov dx,pb
                 in al,dx

                 cmp bl,bh
                 jg t
                 mov bl,bh
             t:  cmp bl,al
                 jg tt
                 mov bl,al
            tt:  mov al,bl

                 mov dx,pa
                 out dx,al
                 mov ah,4ch
                 int 21h
                 code ends
                 end start

