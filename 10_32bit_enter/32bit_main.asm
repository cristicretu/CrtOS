[org 0x7c00] ; bootloader offset
    mov bp, 0x9000 ; set the stack
    mov sp, bp

    mov bx, MSG_REAL_MODE
    call print

    call switch_to_pm
    jmp $ ; never executed

%include "../05_bootsector_functions_strings/boot_sect_print.asm"
%include "../09_32bit_gdt/32bit_gdt.asm"
%include "../08_32bit_print/32bit_print.asm"
%include "32bit_switch.asm"

[bits 32]
BEGIN_PM:
    mov ebx, MSG_PROT_MODE
    call print_string_pm
    jmp $

MSG_REAL_MODE db "Started in 16-bit real mode", 0
MSG_PROT_MODE db "Loaded 32-bit protected mode", 0

; bootsector
times 510-($-$$) db 0
dw 0xaa55
