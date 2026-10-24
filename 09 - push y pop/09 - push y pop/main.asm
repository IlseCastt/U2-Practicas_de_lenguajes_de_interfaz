; Materia: Lenguajes de Interfaz 
; Alumna: Ilse Marianne Castillo Pimienta - 23170117
; Horario: 8:00-9:00am
; Docente: Dr. José Luis Medina Jiménez 
; Práctica: 09 - PUSH y POP
; Descripción: Programa que demuestra el uso de la pila y sus instrucciones (PUSH y POP)

INCLUDE Irvine32.inc

.code
main PROC
	;bloque 1: push y pop 

	mov eax, 500

	push eax ;push mete un valor a la pila para guardarlo temporalmente
	nop 

	mov ebx, 0

	pop ebx ;pop saca el último valor de la pila y lo copia en el registro especificado
	nop

	;bloque 2: orden LIFO (Last In First Out)

	mov eax, 10
	push eax ;ingresamos el valor 10 en la pila

	mov eax, 20
	push eax ;ingresamos el valor 20

	mov eax, 30
	push eax ;ingresamos el valor 30

	nop

	;último en entrar, primero en salir
	pop eax ;recuperamos el valor 30 (al ser el último ingresado)
	pop ebx ;recuperamos el valor 20
	pop ecx ;recuperamos el valor 10

	nop

	;bloque 3: conservar registros
	;guardar valores temporalmente 

	mov eax, 100
	mov ebx, 200

	push eax ;ingresamos el 100 a la pila
	push ebx ;ingresmaos el 200 y queda arriba del 100

	mov eax, 999 ;guardamos cualquier cosa en los registros
	mov ebx, 888

	pop ebx ;recuperamos el 200
	pop eax ;recuperamos el 100

	nop

	;bloque 4: call y ret
	
	mov eax, 50
	mov ebx, 666

	call aumentarDiez ;llamamos a la función 'aumentarDiez', call guarda la dirección de retorno 

	exit

main ENDP

aumentarDiez PROC 
	push ebx ;ingresamos el valor de ebx a la pila

	mov ebx, 10 ;copiamos el valor de 10 en ebx
	add eax, ebx ;realizamos la suma entre eax y ebx para aumentar en 10 el valor de eax

	pop ebx ;recuperamos de la pila el valor de ebx

	ret ;regresamos al main. ret recupera la dirección de retorno que guardó call para poder regresar hacia donde se quedó
aumentarDiez ENDP

END main