 ; BCD updown counter
data segment
porta equ 0ce00h
cr equ 0ce03h
data ends
code segment
assume cs:code,ds:data
start:  mov ax,data
        mov ds,ax
        mov al,82h
        mov dx,cr
        out dx,al
     
        mov al,00h
        mov dx,porta
     up:out dx,al
        call delay
        inc al
        cmp al,99
        jbe up
        mov al,99
        mov dx,porta
   down:out dx,al
       call delay
       dec al
       cmp al,0ffh
       jne down
       mov ah,4ch
       int 21h
   delay proc
   mov si,0ffffh
   t2:mov di,5555h
   t1:dec di
      jnz t1
      dec si
      jnz t2
      ret
   delay endp
      code ends
      end start
