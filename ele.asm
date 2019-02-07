;Elevator
data segment
pctrl equ 0ce03h
pa equ 0ce00h
pb equ 0ce01h
flor db 00,03,06,09,0e0h,0d3h,0b6h,79h
data ends
code segment
assume cs:code,ds:data
start:    mov ax,data
          mov ds,ax
          mov dx,pctrl
          mov al,82h
          out dx,al
          mov bl,00
          mov dx,pa
          mov al,bl
          or al,0f0h
          out dx,al    ;elevator in the ground floor
          lea si,flor
    top:  mov dx,pb
          in al,dx     ;check for the request
          or al,0f0h
          cmp al,0ffh
          jz top
 decide:  ror al,01    ;check from ehich floor the request has come
          jnc up
          inc si
          jmp decide
    up:   cmp bl,[si]  ;keep movinf the ele until ti reaches 
         jz reset
         inc bl        ;the requested floor
         mov al,bl
         or al,0f0h
         mov dx,pa
         out dx,al
         call delay
         jmp up
reset:   add si,04    ;service the request
         mov al,[si]
         mov dx,pa
         out dx,al
         call delay
down:    dec bl       ;move ele down until it reaches ground floor
         cmp bl,0ffh
         jz stop
         mov al,bl
         or al,0f0h
         mov dx,pa
         out dx,al
         call delay
         jmp down
 stop:   mov ah,4ch
         int 21h
      delay proc near
        mov cx,0ffffh
   t1:  mov di,0ffffh
   t:     dec di
         jnz t
         loop t1
          ret
          delay endp
          code ends
          end start

