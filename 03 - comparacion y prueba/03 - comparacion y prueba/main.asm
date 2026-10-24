; Materia: Lenguajes de Interfaz 
; Alumna: Ilse Marianne Castillo Pimienta - 23170117
; Horario: 8:00-9:00am
; Docente: Dr. José Luis Medina Jiménez 
; Práctica: 03 - Comparación y prueba
; Descripción: Programa para probar el funcionamiento de cmp y test

INCLUDE Irvine32.inc

.code
main PROC
	;condicion 1: zero flag
	mov EBX, 1
	cmp ebx, 1 ;cmp realiza una resta interna para realizar la comparacion y activa banderas dependiendo del resultado
	call dumpRegs
	;despliega los registros que se trabajaron y cuales banderas se activaron en cada uno de ellos

	mov EAX, 01h
	cmp EAX, EBX ;si el resultado de la resta es 0, se levanta la bandera ZF
	call dumpRegs

	mov cl, 11111111b
	cmp cl, cl
	call dumpRegs

	;condicion 2: sign flag
	mov EAX, 0
	mov EBX, 0 ;se les asigna el valor 0 para limpiarlos

	mov al, -5
	mov bl, 1

	cmp al, bl ;si el resultado es negativo, se levanta SF
	call dumpRegs

	;condicion 3: carry flag
	mov EAX, 0
	mov EBX, 0

	mov al, 255
	add al, 1 ;desbordamiento sin signo. como se le suma 1 al valor maximo de al, se levanta la bandera CF
	call dumpRegs

	;condicion 4: overflow flag
	mov EAX, 0
	mov EBX, 0

	mov al, -128
	mov bl, 1
	cmp al, bl ;desbordamiento con signo. se activa OF al restarle 1 al valor minimo de al, ya que da un valor fuera del rango 
	call dumpRegs

	;caso 5: test
	mov EAX, 0

	mov EAX, 5 ; 00000101b
	test EAX, 1 ;test realiza un and logico y, tal como cmp, activa banderas dependiendo del resultado
	call dumpRegs

	;00000101b
	;and
	;00000001b
	;------------
	;00000001b

	mov eax, 0
	mov al, 10000000b
	test al, al
	call dumpRegs ;activa SF porque el bit mas significativo se mantiene encendido

main ENDP
END main