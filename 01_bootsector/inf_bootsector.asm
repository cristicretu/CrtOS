; infinite loop (e9 fd ff)

loop:
    jmp loop

; Fill with 510 zeros - size of the prev code
times 510 - ($ - $$) db 0
; Magic number
dw 0xaa55
