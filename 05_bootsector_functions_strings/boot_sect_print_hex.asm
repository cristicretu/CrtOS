; receiving data in 'dx'
; assume: dx = 0x1234

print_hex:
    pusha

    mov cx, 0 ; index variable

; get last char of 'dx' -> convert to ASCII
; '0' (ASCII 0x30) ... 
; 'A' (ASCII 0x41) ...
; move ascii byte to correct poz

hex_loop:
    cmp cx, 4 ; loop 4 times
    je end

    ; convert last char of 'dx' to ASCII
    mov ax, dx ; use ax as working register
    and ax, 0x000f ; 0x1234 -> 0x0004 by masking first three to zeros
    add al, 0x30 ; add 0x30 to N to convert it to ASCII 'N'
    cmp al, 0x39 ; if > 9, add 8 for a-f
    jle step2
    add al, 7 ; 65 - 58

step2:
    ; move ascii to correct poz
    ; bx <- base address + string length - index of char
    mov bx, HEX_OUT + 5 ; base + length
    sub bx, cx ; index variable
    mov [bx], al ; copy the ASCII char on 'al' to the position pointed by 'bx'
    ror dx, 4 ; 0x1234 -> 0x4123 -> 0x3412 -> 0x2341 -> 0x1234

    add cx, 1
    jmp hex_loop

end:
    ; prepare the parameter and call the function
    mov bx, HEX_OUT
    call print

    popa
    ret

HEX_OUT:
    db '0x0000', 0 ; reserve memory for new string
