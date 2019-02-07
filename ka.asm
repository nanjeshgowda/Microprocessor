;key add or sub
data segment
pa equ 0ce00h
pc equ 0ce02h
pctrl equ 0ce03h
key db 00h
n1 db 00h
op db 00h
n2 db 00h
newline db 0ah,0dh,'$' 
data ends
code segment
assume cs:code,ds:data
start: mov ax,data
        mov ds,ax
        mov al,90h
        mov dx,pctrl
        out dx,al
        call keyscan
        call display
        lea dx,newline
        mov ah,09h
        int 21h
        mov n1,ch
        mov ah,01h
        int 21h
        call keyscan
        mov op,ch
        cmp ch,0ch
        je sub2
        jmp add2
    next:call keyscan
         mov n2,ch
         call display
         lea dx,newline
         mov ah,09h
         int 21h
         mov ah,01h
         int 21h
         call keyscan
         mov al,op
         cmp al,0ch
         je next1
         jmp next2
    sub2:mov dl,'_'
         mov ah,02h
         int 21h
         lea dx,newline
         mov ah,09h
         int 21h
         mov ah,01h
         int 21h
         jmp next
    next1:mov dl,'='
          mov ah,02h
          int 21h
          lea dx,newline
          mov ah,09h
          int 21h
          mov ah,01h
          int 21h
          mov ch,n1
          sub ch,n2
          call display
          mov ah,01h
          int 21h
          mov ah,4ch
          int 21h
     add2:mov dl,'+'
          mov ah,02h
          int 21h
          lea dx,newline
          mov ah,09h
          int 21h
          mov ah,01h
          int 21h
          jmp next
      next2:mov dl,'='
            mov ah,02h
            int 21h
            lea dx,newline
            mov ah,09h
            int 21h
            mov ah,01h
            int 21h
            mov ch,n1
            add ch,n2
            call display
            call keyscan
       stop:mov ah,4ch
            int 21h
            keyscan proc near
       repeat:mov bh,02h
              mov ch,10h
              mov bl,04h
              mov ah,00
      nextrow:mov al,bl
             mov dx,pc
             out dx,al
             ror bl,01
             mov dx,pa
             in al,dx
             cmp al,00
             jnz findkey
             sub ch,08h
             dec bh
             cmp bh,0ffh
             jnz nextrow
             jmp repeat
      findkey:ror al,01
              jc keyfound
              inc ch
              jmp findkey
     keyfound:ret
     keyscan endp
          display proc near
          mov dl,ch
          cmp dl,0ah
          jl ascii 
          add dl,07h
    ascii:add dl,30h
          mov ah,02h
          int 21h
          ret
          display endp
          code ends
          end start
