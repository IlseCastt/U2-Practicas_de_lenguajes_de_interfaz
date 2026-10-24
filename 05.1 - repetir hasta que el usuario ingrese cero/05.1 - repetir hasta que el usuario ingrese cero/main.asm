; Materia: Lenguajes de Interfaz 
; Alumna: Ilse Marianne Castillo Pimienta - 23170117
; Horario: 8:00-9:00am
; Docente: Dr. José Luis Medina Jiménez 
; Práctica: 05.1 - Repetir hasta que el usuario ingrese cero
; Descripción: Programa que pide repetidamente un número hasta que el usuario ingrese 0

INCLUDE Irvine32.inc

.data
	msgNumero BYTE "Ingrese un numero (0 para terminar el programa): ", 0
	msgImpresion BYTE "Su numero es: ", 0
	msgFin BYTE "Programa terminado...", 0

.code
main PROC
inicio:
	mov edx, OFFSET msgNumero
	call WriteString

	call ReadInt ;lee el número y lo guarda en eax

	mov edx, OFFSET msgImpresion
	call WriteString ;mensaje para imprimir el numero leído en consola
	call WriteDec ;imprime un numero guardado en eax por eso no es necesario realizar nada y solo llamar a la función 
	call crlf

	cmp eax, 0 ;compara el numero con 0
	jne inicio ;si no es 0, regresa el inicio y sigue con el ciclo

	jmp fin ;si es cero, se termina el progra,a

fin:
	mov edx, OFFSET msgFin
	call WriteString
	call crlf
	exit

main ENDP

END main