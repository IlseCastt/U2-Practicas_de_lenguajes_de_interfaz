; Materia: Lenguajes de Interfaz 
; Alumna: Ilse Marianne Castillo Pimienta - 23170117
; Horario: 8:00-9:00am
; Docente: Dr. José Luis Medina Jiménez 
; Práctica: 01 - Ciclos numéricos
; Descripción: Creación de un ciclo numérico que imprime de forma descendiente los números del 5 al 1 

INCLUDE Irvine32.inc

.data

.code
main PROC
	; mov ecx, 0: para ver qué pasa si se inicializa en 0, si no existe el salto "jecxz", se hará un ciclo que mostrará el valor maximo del registro
	mov ecx, 5

	;jecxz fin_ciclo
	;brincarse a tal etiqueta cuando se cumpla una condicion, si exc es cero en este caso

ciclo: 
	mov eax, ecx
	;copiamos el valor de ecx a eax

	call WriteDec 
	;apunta hacia eax para imprimir el valor que tengamos ahi

	call crlf
	;hacemos salto de linea

	loop ciclo
	;decrementa el valor de exc y vuelve al ciclo

fin_ciclo:
	exit

main ENDP
END main