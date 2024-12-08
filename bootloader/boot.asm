[bits 16]              
[org 0x7C00]            

start:
    mov si, msg          
print:
    lodsb                
    cmp al, 0            
    je load_kernel       
    mov ah, 0x0E         
    int 0x10             
    jmp print            

load_kernel:
    jmp $                

msg db 'Hello, World!', 0 

times 510-($-$$) db 0     
dw 0xAA55                 
