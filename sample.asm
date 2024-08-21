format PE console
include 'win32ax.inc'

;=======================================
section '.code' code readable executable
;=======================================
start:
        cinvoke printf, "%cEnter an integer from -100 to 100: ", 10
        cinvoke scanf, "%d", Num
negative:
        cmp [Num], 0
        jge hundred
        cinvoke printf, "negative"
        neg [Num]


hundred:
        cmp [Num], 100
        jne zero
        cinvoke printf, "one hundred"
        jmp start
zero:
        cmp [Num], 0
        jne ten
        cinvoke printf, "zero"
        jmp start
ten:
        cmp [Num], 10
        jne eleven
        cinvoke printf, "ten"
        jmp start
eleven:
        cmp [Num], 11
        jne twelve
        cinvoke printf, "eleven"
        jmp start
twelve:
        cmp [Num], 12
        jne thirteen
        cinvoke printf, "twelve"
        jmp start
thirteen:
        cmp [Num], 13
        jne fourteen
        cinvoke printf, "thirteen"
        jmp start
fourteen:
        cmp [Num], 14
        jne fifteen
        cinvoke printf, "fourteen"
        jmp start
fifteen:
        cmp [Num], 15
        jne sixteen
        cinvoke printf, "fifteen"
        jmp start
sixteen:
        cmp [Num], 16
        jne seventeen
        cinvoke printf, "sixteen"
        jmp start
seventeen:
        cmp [Num], 17
        jne eighteen
        cinvoke printf, "seventeen"
        jmp start
eighteen:
        cmp [Num], 18
        jne nineteen
        cinvoke printf, "eighteen"
        jmp start
nineteen:
        cmp [Num], 19
        jne tensDigit
        cinvoke printf, "nineteen"
        jmp start


tensDigit:
        mov EAX, [Num]
        cdq
        mov EBX, 10
        idiv EBX
        mov [Quotient], EAX
        mov [Remainder], EDX
        jmp twenty


twenty:
        cmp [Quotient], 2
        jne thirty
        cinvoke printf, "twenty "
thirty:
        cmp [Quotient], 3
        jne forty
        cinvoke printf, "thirty "
forty:




one:
        cmp [Remainder], 1
        jne two
        cinvoke printf, "one"
two:
        cmp [Remainder], 2
        jne three
        cinvoke printf, "two"
three:

          jmp start

section '.data' data readable writeable
;======================================
Num             dd 0
Quotient        dd 0
Remainder       dd 0


section '.idata' import data readable
;====================================
library msvcrt, 'msvcrt.dll', kernel32, 'kernel32.dll'
import msvcrt, printf, 'printf', scanf, 'scanf', getch, '_getch'