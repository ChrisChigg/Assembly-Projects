format PE console
include 'win32ax.inc'

;=======================================
section '.code' code readable executable
;=======================================
start:
        cinvoke printf, "%cEnter an integer from -100 to 100: ", 10
        cinvoke scanf, "%d", Num
negative:
        cmp [Num], 0            ;Compare
        jge hundred             ;jump to exceptions, Jump if Greater than or Equal to
        cinvoke printf, "negative "
        neg [Num]               ;Negate


; Print Exceptions: 100, 0, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19
hundred:
        cmp [Num], 100
        jne zero                ;Jump if Not Equal
        cinvoke printf, "one hundred"
        jmp start               ;Jump to start

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

; Print 10's digit (twenty, thirty, ...)
tensDigit:
        mov EAX, [Num]       ;move the value of Num to EAX register
        cdq                  ;converts value in EAX to 64-bit EDX:EAX
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
        cmp [Quotient], 4
        jne fifty
        cinvoke printf, "forty "
fifty:
        cmp [Quotient], 5
        jne sixty
        cinvoke printf, "fifty "
sixty:
        cmp [Quotient], 6
        jne seventy
        cinvoke printf, "sixty "
seventy:
        cmp [Quotient], 7
        jne eighty
        cinvoke printf, "seventy "
eighty:
        cmp [Quotient], 8
        jne ninety
        cinvoke printf, "eighty "
ninety:
        cmp [Quotient], 9
        jne one
        cinvoke printf, "ninety "

; Print 1's digit (one, two, ...)
one:
        cmp [Remainder], 1
        jne two
        cinvoke printf, "one"
two:
        cmp [Remainder], 2
        jne three
        cinvoke printf, "two"
three:
        cmp [Remainder], 3
        jne four
        cinvoke printf, "three"
four:
        cmp [Remainder], 4
        jne five
        cinvoke printf, "four"
five:
        cmp [Remainder], 5
        jne six
        cinvoke printf, "five"
six:
        cmp [Remainder], 6
        jne seven
        cinvoke printf, "six"
seven:
        cmp [Remainder], 7
        jne eight
        cinvoke printf, "seven"
eight:
        cmp [Remainder], 8
        jne nine
        cinvoke printf, "eight"
nine:
        cmp [Remainder], 9
        jne nothing
        cinvoke printf, "nine"
nothing:

        jmp start




;======================================
section '.data' data readable writeable
;======================================
Num             dd 0 ;User input
Quotient        dd 0 ;10's digit
Remainder       dd 0 ;1's digit

;====================================
section '.idata' import data readable
;====================================
library msvcrt, 'msvcrt.dll',kernel32, 'kernel32.dll'
import msvcrt,printf,'printf',scanf,'scanf',getch,'_getch'