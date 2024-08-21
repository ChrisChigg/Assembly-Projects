format PE console
include 'win32ax.inc'

;=======================================
section ',code' code readable executable
;=======================================
start:
        cinvoke time, 0
        cinvoke srand, EAX
gameLoop:
        call printBoard
        cinvoke printf, "Your move (1-9)? "
        cinvoke scanf, "%d", Square
        call placeX
        call checkXWin
        call checkForDraw
        call computerMove
        call checkOWin
        jmp gameLoop

printBoard:
        call printCLS
        cinvoke printf, "%c %1.1s | %1.1s | %1.1s %c", 10, S1, S2, S3, 10
        cinvoke printf, "---|---|---"
        cinvoke printf, "%c %1.1s | %1.1s | %1.1s %c", 10, S4, S5, S6, 10
        cinvoke printf, "---|---|---"
        cinvoke printf, "%c %1.1s | %1.1s | %1.1s %c", 10, S7, S8, S9, 10
        cinvoke printf, "---|---|---"
        ret

placeX:
        mov EAX, [Square]
        mov [S1+EAX-1], 'X'
        ret

checkXWin:
    checkTopRowX:
        cmp [S1], 'X'
        jne checkMiddleRowX
        cmp [S2], 'X'
        jne checkMiddleRowX
        cmp [S3], 'X'
        je playerWins
    checkMiddleRowX:
        cmp [S4], 'X'
        jne checkBottomRowX
        cmp [S5], 'X'
        jne checkBottomRowX
        cmp [S6], 'X'
        je playerWins
    checkBottomRowX:
        cmp [S7], 'X'
        jne checkForDraw
        cmp [S8], 'X'
        jne checkForDraw
        cmp [S9], 'X'
        je playerWins
        ret

checkOWin:
    checkTopRowO:
        cmp [S1], 'O'
        jne checkMiddleRowO
        cmp [S2], 'O'
        jne checkMiddleRowO
        cmp [S3], 'O'
        je computerWins
    checkMiddleRowO:
        cmp [S4], 'O'
        jne checkBottomRowO
        cmp [S5], 'O'
        jne checkBottomRowO
        cmp [S6], 'O'
        je computerWins
    checkBottomRowO:
        cmp [S7], 'O'
        jne checkForDraw
        cmp [S8], 'O'
        jne checkForDraw
        cmp [S9], 'O'
        je computerWins
        ret


computerMove:
        computerWinsTopRowS1:
                cmp [S1], ' '
                jne computerWinsTopRowS2
                cmp [S2], 'O'
                jne computerWinsTopRowS2
                cmp [S3], 'O'
                jne computerWinsTopRowS2
                mov [S1], 'O'
                jmp computerWins

        computerWinsTopRowS2:
                cmp [S1], 'O'
                jne computerWinsTopRowS3
                cmp [S2], ' '
                jne computerWinsTopRowS3
                cmp [S3], 'O'
                jne computerWinsTopRowS3
                mov [S2], 'O'
                jmp computerWins

        computerWinsTopRowS3:
                cmp [S1], 'O'
                jne computerBlockS1row
                cmp [S2], 'O'
                jne computerBlockS1row
                cmp [S3], ' '
                jne computerBlockS1row
                mov [S2], 'O'
                jmp computerWins
        computerBlockS1row:
                cmp [S1], ' '
                jne computerBlockS1column
                cmp [S2], 'X'
                jne computerBlockS1column
                cmp [S3], 'X'
                jne computerBlockS1column
                mov [S1], 'O'
                ret

        computerBlockS1column:
        randomMove:
                cinvoke rand
                cdq
                mov EBX, 9
                idiv EBX
                cmp [S1+EDX], ' '
                jne randomMove
                mov [S1+EDX], 'O'
                ret


checkForDraw:
        mov ECX, -1
     drawLoop:
        inc ECX
        cmp ECX, 9
        je drawGame
        cmp [S1+ECX], ' '
        jne drawLoop
        ret

drawGame:
        call printBoard
        cinvoke printf, "%cIt's a draw!!!%c", 10, 10
        invoke getch

playerWins:
        call printBoard
        cinvoke printf, "You win!!!%c", 10
        invoke getch

computerWins:
        call printBoard
        cinvoke printf, "%cComputer wins!!!%c", 10, 10
        invoke getch

printCLS:
        cinvoke printf, "%c[2J%c[1;1H", 27, 27
        ret

;======================================
section ',data' data readable writeable
;======================================

Square dd 0
S1     db ' '
S2     db ' '
S3     db ' '
S4     db ' '
S5     db ' '
S6     db ' '
S7     db ' '
S8     db ' '
S9     db ' '

;====================================
section '.idata' import data readable
;====================================
library msvcrt, 'msvcrt.dll', kernel32, 'kernel32.dll'
import msvcrt, printf, 'printf', scanf, 'scanf', getch, '_getch', rand, 'rand', srand, 'srand', time, 'time'


