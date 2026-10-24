; Materia: Lenguajes de Interfaz 
; Alumna: Ilse Marianne Castillo Pimienta - 23170117
; Horario: 8:00-9:00am
; Docente: Dr. José Luis Medina Jiménez 
; Práctica: 05 - Condicionales
; Descripción: Programa que genera un ciclo utilizando condiciones

INCLUDE Irvine32.inc

.code
main PROC
    mov ebx, 1

cicloWhile:
    cmp ebx, 100 ;en el while se realiza la comparacion al inicio
    jg doWhile ;etiqueta para cambiar de ciclo, si ebx es mayor a 100, se cambia

    mov eax, ebx 
    call WriteDec ;imprime en consola el numero que se encuentre en eax
    call crlf 

    inc ebx ;incrementamos ebx
    jmp cicloWhile ;regresamos a la etiqueta para generar un ciclo

doWhile: ;inicio de ciclo do while
    call crlf
    mov ebx, 1 

cicloDoWhile:
    mov eax, ebx 
    call WriteDec 
    call crlf 

    inc ebx 
    cmp ebx, 100 ;en do while se realiza la comparacion al final para ver si se sigue cumpliendo la condición

    jle cicloDoWhile ;regresa al ciclo si es menor o igual a 100

    jmp fin ;si la condicion ya no se cumple, salta al fin del programa

fin:
    exit 
main ENDP

END main