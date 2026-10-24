; Materia: Lenguajes de Interfaz 
; Alumna: Ilse Marianne Castillo Pimienta - 23170117
; Horario: 8:00-9:00am
; Docente: Dr. José Luis Medina Jiménez 
; Práctica: 14 - Captura y almacenamiento de datos numéricos
; Descripción: Programa que simula un almacen que recibe una cantidad de producto en cadena de texto, lo convierte a decimal 
;              para poder realizar operaciones y posteriormente lo pasa nuevamente a cadena de texto para imprimirlo

INCLUDE Irvine32.inc

; Captura y almacenamiento de datos numericos

.data
	mensajeCantidad BYTE "Ingrese la cantidad recibida (0-99): ", 0
	mensajeInvalido BYTE "Entrada invalida, vuelva a ingresar.", 0
	mensajeExistencia BYTE "La existencia actual es de: ", 0

	maximoCaracteres = 2
	recibida BYTE 10 DUP(0) ;espacio de 10 solo para que la cadena no se corte al poner mas numeros y que permita mostrar el error

	longitud DWORD ?

	existenciaInicial DWORD 25
	cantidadRecibida DWORD ? 
	existenciaActual DWORD ?

	acumulado DWORD ?

	buffer BYTE 11 DUP(0)

.code
main PROC
	mov eax, 0

inicio:
	mov esi, 0
	mov acumulado, 0

	mov edx, OFFSET mensajeCantidad
	call WriteString

	mov edx, OFFSET recibida
	mov ecx, SIZEOF recibida ;copiamos en ecx el tamaño de la variable "recibida"
	call ReadString
	mov longitud, eax ;copiamos la longitud en una variable
	call crlf

examinarCaracteres:
	cmp longitud, 0 ;comparamos la longitud de la cadena con 0 para ver si no esta vacia
	je invalido

	cmp longitud, maximoCaracteres ;comparamos la longitud con el maximo de caracteres para ver si no se pasa
	ja invalido ;saltar si es mayor que el maximo de caracteres

recorridoCadena:
	mov al, recibida[ESI] ;copiamos el primer caracter de la variable en al

	;comparamos los caracteres para ver si se encuentran dentro del rango numérico en ASCII
	cmp al, '0'
	jb invalido

	cmp al, '9'
	ja invalido ;si no es un caracter numérico, salta a la etiqueta "invalido"

	inc esi ;incrementamos ESI para cambiar de caracter
	cmp esi, longitud
	jb recorridoCadena ;si aun hay caracteres, sigue con el recorrido

	mov esi, 0 ;reiniciamos ESI

construccionNumero: ;iniciamos el cambio de cadena de texto a numero decimal

	mov eax, acumulado ;copiamos en eax el valor acumulado de las operaciones
	mov ebx, 10

	mul ebx ;multiplicamos 10 por el acumulado y el resultado se guarda en eax

	mov ebx, 0
	mov bl, recibida[ESI] ;copiamos en bl el caracter a convertir
	sub bl, '0' ;restamos el valor de 0 en ascii en el caracter para pasarlo a digito
	add eax, ebx ;sumamos el digito al valor de la multiplicacion 

	mov acumulado, eax ;eax contiene nuestro nuevo acumulado, asi que lo copiamos en acumulado 

	inc esi ;nos movemos de caracter
	cmp esi, longitud
	jb construccionNumero ;mientras esi sea menor a la longitud del numero, volvemos a realizar el proceso de construcción

sumarCantidades:
	mov eax, acumulado

	cmp eax, 0
	je invalido ;si por algun motivo el acumulado es 0, manda el mensaje de invalido

	mov cantidadRecibida, eax ;guardamos el valor de eax en la variable "cantidadRecibida"

	add eax, existenciaInicial ;sumamos la cantidad recibida con la existencia inicial
	mov existenciaActual, eax ;copiamos el resultado en la variable "existenciaActual"

mostrarExistenciaActual:
	mov edx, OFFSET mensajeExistencia
	call WriteString

	mov eax, existenciaActual ;copiamos en eax el valor de la existencia actual
	mov esi, OFFSET buffer  ;copiamos en esi la dirección del buffer
	call conversionDecimalTexto ;llamamos al procecimiento para volver a convertir el valor numérico a cadena de texto

	mov edx, OFFSET buffer ;copiamos en edx la dirección del buffer en el cual se encuentra la cadena de texto convertida
	call WriteString
	call crlf

	exit
	
invalido: 
	mov edx, OFFSET mensajeInvalido ;muestra en mensaje de inválido
	call WriteString
	call crlf

	jmp inicio

main ENDP

conversionDecimalTexto PROC
	;procedimiento para pasar de un valor numérico a una cadena de texto
	;imprimir el total en un writestring

	mov ebx, 10
	mov ecx, 0

inicio:
	mov edx, 0

	div ebx ;dividimos eax/ebx 
	push edx ;guardamos el residuo en la pila
	inc ecx ;incrementamos ecx para cambiar de dígito
	cmp eax, 0
	je cadena ;si ya no quedan digitos, pasamos a la construccion de la cadena

	jmp inicio ;si todavia quedan digitos, volvemos a realizar el procedimiento

cadena:
	pop eax
	add eax, '0' ;sumamos el valor de 0 en ASCII para pasarlo a decimal
	mov [esi], al ;pasamos el digito al buffer
	inc esi ;incrementamos esi para indicar la siguiente direccion de buffer
	dec ecx 

	cmp ecx, 0
	jne cadena ;si todavia quedan digitos, se realiza el procedimiento de nuevo

	mov al, 0
	mov [esi], al ;le agregamos 0 al final de la cadena para indicarle a WriteString que ahi termina

	ret ;regresamos al main

conversionDecimalTexto ENDP

END main