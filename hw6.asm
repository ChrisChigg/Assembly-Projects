format PE console
include 'win32ax.inc'

;=======================================
section '.text' code readable executable
;=======================================
        cinvoke printf, "This program checks if the parentheses, brackets, and braces are balanced. %c%c", 10, 10
start:
        cinvoke printf, "Enter an equation of ([{}]): "
        cinvoke scanf, "%s", Equation
        mov [InitialESP], ESP
        mov EBX, -1

MainLoop:
        inc EBX
        mov EAX, 0
        mov AL, [Equation+EBX]
        cmp AL, 32
        je FinishedMainLoop

OpenParenthesis:
        cmp AL, '('
        jne OpenBracket
        push EAX
        jmp MainLoop

OpenBracket:
        cmp AL, "["
        jne OpenBrace
        push EAX
        jmp MainLoop

OpenBrace:
        cmp AL, "{"
        jne CloseParenthesis
        push EAX
        jmp MainLoop

CloseParenthesis:
        cmp AL, ')'
        jne CloseBracket
        cmp ESP, [InitialESP]
        je Unbalanced
        pop ECX
        cmp CL, '('
        jne Unbalanced
        jmp MainLoop

CloseBracket:
        cmp AL, ']'
        jne CloseBrace
        cmp ESP, [InitialESP]
        je Unbalanced
        pop ECX
        cmp CL, '['
        jne Unbalanced
        jmp MainLoop

CloseBrace:
        cmp AL, '}'
        jne FinishedMainLoop
        cmp ESP, [InitialESP]
        je Unbalanced
        pop ECX
        cmp CL, '{'
        jne Unbalanced
        jmp MainLoop

FinishedMainLoop:
        cmp ESP, [InitialESP]
        je Balanced
        jmp Unbalanced

Unbalanced:
        cinvoke printf, "The input string is NOT balanced%c%c", 10, 10
        jmp start

Balanced:
        cinvoke printf, "The input string IS balanced%c%c", 10, 10
        jmp start












;======================================
section '.data' data readable writeable
;======================================
Equation        db '                                        '
InitialESP      dd 0






;====================================
section '.idata' import data readable
;====================================
library msvcrt, 'msvcrt.dll', kernel32, 'kernel32.dll'
import msvcrt, printf, 'printf', scanf, 'scanf'