mov ah, 0x0e ; tty

; bp register => stores the base address (bottom)
; sp register => stores the top
; stack grows downwards
; from bp

mov bp, 0x8000 ; address far from 0x7c00 (avoid overwritten)
mov sp, bp ; stack.empty => sp points to bp

push 'A'
push 'B'
push 'C'

; show how the stack grown downwards
mov al, [0x7ffe] ; 0x8000 - 2
int 0x10 ; prints C (stack.top())

; can't acces [0x8000]
; only the top of the stack -> 0x7ffe
mov al, [0x8000]
int 0x10 ; prints ' '

; pop from the stack
pop bx
mov al, bl
int 0x10 ; prints C

pop bx
mov al, bl
int 0x10

pop bx
mov al, bl
int 0x10

mov al, [0x8000]
int 0x10

jmp $ 
times 510 - ($ - $$) db 0
dw 0xaa55
