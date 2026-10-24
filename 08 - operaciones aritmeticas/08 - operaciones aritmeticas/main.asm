; Materia: Lenguajes de Interfaz 
; Alumna: Ilse Marianne Castillo Pimienta - 23170117
; Horario: 8:00-9:00am
; Docente: Dr. José Luis Medina Jiménez 
; Práctica: 08 - Operaciones aritméticas
; Descripción: Programa para ver el funcionamiento de las operaciones aritméticas que realiza ALU

INCLUDE Irvine32.inc

.code
main PROC
	; OPERACIONES: ADD Y SUB

	mov eax, 50
	mov ebx, 20

	add eax, ebx ;realiza la suma entre los registros y guarda el resultado en eax
	sub eax, 15 ;realiza la resta y guarda el resultado en eax

	nop ; significa que no hay ninguna operacion 

	; 2. CF: ACARREO EN UNA SOLA SUMA SIN SIGNO

	mov eax, 0
	mov al, 255

	add al, 1 ;activa CF debido a que pasa el límite del registro

	nop

	; 3. OF: CONDICION DE DESBORDAMIENTO

	mov eax, 0
	mov al, 127

	add al, 1 ;activa OF al pasar el límite de un registro con signo

	nop

	; 4. MUL: MULTIPLICACION DE VALORES DENTRO DE 32 BITS

	mov eax, 25
	mov ebx, 3

	mul ebx ;se realiza la multiplicación y el resultado queda en eax

	nop

	; 5. MUL: PRODUCTO QUE NECESITA MAS DE 32 BITS

	mov eax, 65537
	mov ebx, 65537

	mul ebx ;realiza la multiplicación y eax se apoya en edx para guardar el desbordamiento. edx guarda la parte alta del registro mientras que eax guarda la parte baja

	nop

	; 6. IMUL: MULTIPLICACION CON SIGNO

	mov eax, -5
	mov ebx, 3 

	imul eax, eax, 3 ; imul(donde se almacena, valor 1 a multiplicar, valor 2 a multiplicar)
					 ; multiplicación con signo, guarda el resultado negativo en eax

	; 7. DIV: DIVIDIENDO SIN SIGNO

	mov eax, 125
	mov edx, 0 ;se guarda el residuo de la division e indica que va a ser sin signo
	mov ebx, 12

	div ebx ;realiza la division y el cociente queda en eax

	nop 

	; IDIV: DIVISION CON SIGNO

	mov eax, -125
	cdq ; rellena edx con los valores maximos que pueda almacenar para indicarle que se va a trabajar una division con signo
	mov ebx, 12

	IDIV ebx ;realiza una división con signo

	nop

main ENDP
END main