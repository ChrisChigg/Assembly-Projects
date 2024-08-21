format PE console
include 'win32ax.inc'

;=======================================
section '.text' code readable executable
;=======================================
start:
        cinvoke time, 0
        cinvoke srand, EAX

getR1:
        call getRandomNum1to20
        mov [R1], EDX

getR2:
        call getRandomNum1to20
        cmp EDX, [R1]
        je getR2
        mov [R2], EDX

getR3:
        call getRandomNum1to20
        cmp EDX, [R1]
        je getR3
        cmp EDX, [R2]
        je getR3
        mov [R3], EDX
getR4:
        call getRandomNum1to20
        cmp EDX, [R1]
        je getR4
        cmp EDX, [R2]
        je getR4
        cmp EDX, [R3]
        je getR4
        mov [R4], EDX
getR5:
        call getRandomNum1to20
        cmp EDX, [R1]
        je getR5
        cmp EDX, [R2]
        je getR5
        cmp EDX, [R3]
        je getR5
        cmp EDX, [R4]
        je getR5
        mov [R5], EDX

        cinvoke printf, "Random number from 1-10: %d, %d, %d, %d, %d %c", [R1], [R2], [R3], [R4], [R5], 10

randomQuote:
        call getRandomNum1to5
quote1:
        cmp EDX, 1
        jne quote2
        cinvoke printf, "To be happy at home is the ultimate result of all ambition.%c", 10

quote2:
        cmp EDX, 2
        jne quote3
        cinvoke printf, "We have two lives, and the second begins when we realize we only have one.%c", 10
quote3:
        cmp EDX, 3
        jne quote4
        cinvoke printf, "You cannot overestimate the unimportance of practically everything.%c", 10
quote4:
        cmp EDX, 4
        jne quote5
        cinvoke printf, "Much of education is oriented toward making a living rather than making a LIFE.%c", 10
quote5:
        cmp EDX, 5
        jne ending
        cinvoke printf, "The man is happiest who lives from day to day and asks no more, garnering the simple goodness of life.%c", 10

ending:
        invoke getch

        invoke getch


getRandomNum1to20:
        cinvoke rand
        cdq
        mov EBX, 20
        idiv EBX
        inc EDX
        ret

getRandomNum1to5:
        cinvoke rand
        cdq
        mov EBX, 5
        idiv EBX
        inc EDX
        ret

;======================================
section ',data' data readable writeable
;======================================
R1      dd 0
R2      dd 0
R3      dd 0
R4      dd 0
R5      dd 0


;===================================
section '.data' import data readable
;===================================
library msvcrt, 'msvcrt.dll', kernel32, 'kernell32.dll'
import msvcrt, printf, 'printf', rand, 'rand', srand, 'srand', time, 'time', getch, '_getch'