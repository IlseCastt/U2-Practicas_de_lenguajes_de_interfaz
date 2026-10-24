; Materia: Lenguajes de Interfaz 
; Alumna: Ilse Marianne Castillo Pimienta - 23170117
; Horario: 8:00-9:00am
; Docente: Dr. José Luis Medina Jiménez 
; Práctica: 11 - Operaciones lógicas
; Descripción: Programa que permite ver el funcionamiento de las operaciones lógicas en lenguaje ensamblador

INCLUDE Irvine32.inc

.data
	msgEncendida BYTE "La alarma esta encendida", 0
	msgApagada  BYTE "La alarma esta apagada", 0

.code
main PROC
	; 0. Encendido de computadora 001
	; 1. Alarma                   010
	; 2. Conectado                100
	; Estado inicial: 00000101

	; 1. AND:  Extraer el estado de encendido
	mov eax, 0
	mov ebx, 0

	mov al, 00000101b
	mov bl, al
	and bl, 00000001b ;comparación en AND para ver si la computadora está encendida, para esta verificación, su máscara se enciende
	
	call dumpRegs

	; 2. OR: Encender alarma
	mov al, 00000101b
	or al,  00000010b ;como la comparación es en OR, para encender la alarma solo es necesario poner su máscara en 1, aunque su estado base esté en 0
	
	call dumpRegs

	; 3. XOR: Desconectar y conectar 
	;en XOR si los bits son iguales, su salida es 0, si son diferentes, su salida es 1
	mov al, 00000101b
	xor al, 00000100b ;computadora desconectada, el resultado es un 0 lógico

	xor al, 00000100b ;computadora conectada, se usa la misma máscara para invertir el bit y volver a activarlo

	call dumpRegs

	; 4. NOT: Devolver estados
	mov al, 00000101b
	not al ;not realiza un negado de todos los bits

	call dumpRegs

	; 5. TEST: Evaluar alarma y realizar salto

	;test mandar un mensaje cuando la alarma esté apagada y cuando esté encendida
	mov al,  00000101b
	test al, 00000010b ;test realiza un AND lógico, con la máscara de la alarma activa se puede saber si esta está apagda o encendida 
	call dumpRegs

	jnz encendida ;si el bit esta encendido, salta a encendida
	jz apagada ;si esta apagado (es 0), salta a apagada
	
encendida:
	mov edx, OFFSET msgEncendida ;mensaje de alarma encendida
	call WriteString
	call crlf

	jmp fin

apagada:
	mov edx, OFFSET msgApagada ;mensaje de alarma apagada
	call WriteString
	call crlf

	jmp fin

fin:
	exit
main ENDP
END main