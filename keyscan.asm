; key scan
data segment
col db 00h
row db 00h
pa equ 0ce00h
pc equ 0ce02h
pctr1 equ 0ce03h
key db 00h
newline db 0ah,0dh,'$'
data ends

code segment
 assume cs:code,ds:data
 start :mov ax,data
        mov ds,ax

        mov dx,pctr1
        mov al,90h
        out dx,al
        call keyscan
        mov row,bh
        call display
        mov dx,offset newline
        mov ah,09h
        int 21h
        mov ch,row
        inc ch

        call display
        mov dx,offset newline
        mov ah,09h
        int 21h
        mov ch,col
        inc ch
         call display
         mov dx,offset newline
         mov ah,09h
         int 21h
         mov ah,01h
         int 21h

         mov ah,4ch
         int 21h

         keyscan proc near
          repeat:mov bh,02h
                 mov ch,10h
                 mov bl,04h
                 mov ah,00h

          nextrow: mov al,bl
                   mov dx,pc
                   out dx,al

                   ror bl,01
                   mov dx,pa
                   in al,dx
                   cmp al,00h

                   jnz findkey
                   sub ch,08h

                   dec bh
                   cmp bh,0ffh
                   jnz nextrow
                   jmp repeat

            findkey: rcr al,01h
                     jc keyfound
                     inc col
                     inc ch
                     jmp findkey
            keyfound: ret
            keyscan endp

            display proc near
                    mov dl,ch
                    cmp dl,0ah
                    jl asciiadd
                    cmp dl,0fh
                    jle t1
                    mov bh,ch
                    and ch,0f0h
                    mov cl,04h
                    ror ch,cl
                    add ch,30h
                    mov dl,ch
                    mov ah,02h
                    int 21h
                    and bh,0fh
                    add bh,30h
                    mov dl,bh
                    mov ah,02h
                    int 21h
                    jmp last

                  t1: add dl,07h
                  asciiadd:add dl,30h
                    mov ah,02h
                    int 21h

                    last:ret

                    display endp

                    code ends
                    end start
                   
