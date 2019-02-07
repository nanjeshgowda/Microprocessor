;Seven segment
data segment
portc equ 0ce02h
portb equ 0ce01h
cw equ 0ce03h
cod1 db 99h,0b0h,0a4h,0f9h
cod2 db 80h,0f8h,82h,92h
count db 5
data ends
  code segment
assume cs:code,ds:data
start:mov ax,data
      mov ds,ax
      mov al,80h
      mov dx,cw
      out dx,al
  again:lea si,cod1
        call display
        call delay
        lea si,cod2
        call display
        call delay
        dec count
        jnz again
        mov ah,4ch
        int 21h
          display proc
        mov di,0004
     nextchar:mov al,[si]
              mov bh,08
       nextbit:rol al,01
               mov cl,al
               mov dx,portb
               out dx,al
               mov al,00
               mov dx,portc
               out dx,al
               mov al,0ffh
               out dx,al
               mov al,cl
               dec bh
               jnz nextbit
               inc si
               dec di
               jnz nextchar
               ret
               display endp

                delay proc
                mov si,0ffffh
             t2:mov di,0bbbbh
            t1:dec di
               jnz t1
               dec si
               jnz t2
               ret
               delay endp
                code ends
                  end start


