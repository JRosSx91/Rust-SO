[bits 16]                ; Usar modo real de 16 bits
[org 0x7C00]             ; Dirección en memoria donde se carga el bootloader

start:
    mov si, msg          ; Apuntar al mensaje
print:
    lodsb                ; Cargar un byte en AL desde [SI]
    cmp al, 0            ; Comprobar si es el final del string
    je load_kernel       ; Saltar si es el final
    mov ah, 0x0E         ; Función para mostrar caracteres en la pantalla
    int 0x10             ; Interrupción de BIOS
    jmp print            ; Repetir para el siguiente carácter

load_kernel:
    ; Aquí se cargaría el kernel desde un sector del disco a la memoria (se simplifica en esta etapa)
    jmp $                ; Bucle infinito (placeholder)

msg db 'Hello, World!', 0 ; Mensaje a mostrar

times 510-($-$$) db 0     ; Rellenar hasta los 510 bytes
dw 0xAA55                 ; Firma del bootloader
