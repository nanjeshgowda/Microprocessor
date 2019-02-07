;key mul and div
data segment
pa equ 0c880h
pc equ 0c882h
pctrl equ 0c883h
key db 00h
n1 db 00h
op db 00h
n2 db 00h
res dw 00h
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
        cmp ch,0dh
        je mul2
        cmp ch,0eh
        je div2
     
    next:call keyscan
         mov n2,ch
         mov al,n1
         mul n2
         aam
         mov bx,ax
         mov si,2000h
         mov [si],ax
         call display
         lea dx,newline
         mov ah,09h
         int 21h
         mov ah,01h
         int 21h
         call keyscan
         mov al,ch
         cmp al,13h
         je next1
         jmp stop
       
    mul2:  mov dl,'*'
          mov ah,02h
          int 21h
          lea dx,newline
          mov ah,09h
          int 21h
          mov ah,01h
          int 21h
          jmp next
    div2:mov dl,'/'
         mov ah,02h
         int  21h
         lea dx,newline
         mov ah,09h
         int 21h
         mov ah,01h
         int 21h
         jmp nxt

  next1:  mov dl,'='
          mov ah,02h
          int 21h
          lea dx,newline
          mov ah,09h
          int 21h
          mov ah,01h
          int 21h
          mov si,2000h
          mov bx,[si]
          add bx,3030h
          mov dl,bh
          mov ah,02h
          int 21h
          mov dl,bl
          int 21h
          jmp stop


    nxt:call keyscan
        mov n2,ch
        mov al,n1
         mov ah,00h
        div n2
        mov bx,ax
        mov si,2000h
        mov [si],ax
        call display
        lea dx,newline
        mov ah,09h
        int 21h
        mov ah,01h
        int 21h
        call keyscan
        mov al,ch
        cmp al,13h
       jnz stop 
          mov dl,'='
          mov ah,02h
          int 21h
          lea dx,newline
          mov ah,09h
          int 21h
          mov ah,01h
          int 21h
           mov dl,[si]
           add dl,30h
           mov ah,02h
           int 21h
           mov dl,[si+1]
           add dl,30h
           int 21h
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
