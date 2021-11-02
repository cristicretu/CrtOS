; load 'dh' sectors from drive 'dl' into ES:BX
disk_load:
    pusha

    ; overwrite parameters (bc. reading from disk)
    push dx

    mov ah, 0x02  ; 0x02 = 'read'
    mov al, dh    ; al <- number of sectors to read (0x01 .. 0x80)
    mov cl, 0x02  ; cl <- sector (0x01 .. 0x11)
                  ; 0x01 is boot sector, 0x02 first 'available' sector
    mov ch, 0x00  ; ch <- cylinder (0x0 .. 0x3FF, upper 2 bits in 'cl')
    ; dl <- drive number, callers sets and gets it from BIOS
    ; (0 = floppy, 1 = floppy2, 0x80 = hdd, 0x81 = hdd2)
    mov dh, 0x00  ; dh <- head number

    ; [es:bx] <- pointer to buffer where the data will be stored
    int 0x13      ; BIOS interrupt
    jc disk_error ; if error (stored in the carry bit)

    pop dx
    cmp al, dh    ; BIOS sets 'al' to the # of sectors read
    jne sectors_error
    popa
    ret

disk_error:
    mov bx, DISK_ERROR
    call print
    call print_nl

    mov dh, ah    ; ah = error code, dl = disk drive that dropped the error
    call print_hex
    jmp disk_loop

sectors_error:
    mov bx, SECTORS_ERROR
    call print

disk_loop:
    jmp $

%include "../05_bootsector_functions_strings/boot_sect_print.asm"
%include "../05_bootsector_functions_strings/boot_sect_print_hex.asm"

DISK_ERROR: db "Disk read error", 0
SECTORS_ERROR: db "Incorrect number of sectors read", 0
