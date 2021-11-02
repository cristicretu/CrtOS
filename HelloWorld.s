//
// Assembler program to print "Hello, World!"
// to stdout
//

.global _start
.align 2

_start: mov X0, #1           // 1 = stdout
        adr X1, helloworld   // string to print
        mov X2, #13          // length of the string
        mov X16, #4          // MacOS write system call
        svc 0               // call kernel to output the string

// Setup the parameters to exit the program

        mov   X0, #0         // Use 0 return code
        mov   X16, #1        // Service command code 1 terminates the program
        svc   0

helloworld:       .ascii "Hello World!\n"
