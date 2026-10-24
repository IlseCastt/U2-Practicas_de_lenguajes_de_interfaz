; Materia: Lenguajes de Interfaz 
; Alumna: Ilse Marianne Castillo Pimienta - 23170117
; Horario: 8:00-9:00am
; Docente: Dr. José Luis Medina Jiménez 
; Práctica: 02 - Captura y desplegado de mensajes
; Descripción: Programa que solicita un dato en consola, lo lee y luego lo imprime

INCLUDE Irvine32.inc

.data
	mensaje BYTE "Escribe tu nombre: ", 0

	nombre BYTE 15 DUP(0) ;variable para guardar el nombre. dup va a rellenar el espacio reservado (15 bytes) con 0

.code
main PROC
	mov edx, OFFSET mensaje 
	call WriteString

	mov edx, OFFSET nombre ;guarda en edx la direccion de la variable nombre
	
	mov ecx, SIZEOF nombre ;para saber el numero de caracteres reservados

	call ReadString ;lee lo que fue escrito en consola
	call crlf

	mov edx, OFFSET nombre 
	call WriteString ;escribe en consola lo que se encuentra en la direccion guardada en edx, en este caso el nombre
	call crlf

	exit

main ENDP
END main