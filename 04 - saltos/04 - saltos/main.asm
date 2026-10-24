; Materia: Lenguajes de Interfaz 
; Alumna: Ilse Marianne Castillo Pimienta - 23170117
; Horario: 8:00-9:00am
; Docente: Dr. José Luis Medina Jiménez 
; Práctica: 04 - Saltos
; Descripción: Programa para ver el funcionamiento de los saltos hacia etiquetas

INCLUDE Irvine32.inc

.code
main PROC
	mov eax, 5
	
	jmp continuar ;jmp siempre realiza un salto a una etiqueta 
	mov eax, 10 ;el valor de eax no cambia a 10 debido a que se realiza el salto antes de llegar a esta linea

	continuar: ;etiqueta hacia donde va el salto
	call DumpRegs
	exit 

main ENDP
END main