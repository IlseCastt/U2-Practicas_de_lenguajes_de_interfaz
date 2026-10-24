; Materia: Lenguajes de Interfaz 
; Alumna: Ilse Marianne Castillo Pimienta - 23170117
; Horario: 8:00-9:00am
; Docente: Dr. José Luis Medina Jiménez 
; Práctica: 06.1 - Control de ocupación de un estacionamiento
; Descripción: Programa que simula la entrada y salida de carros de un estacionamiento

INCLUDE Irvine32.inc

.data
; estacionamiento de 20 espacios donde un contador aumente si entra un carro o decremente si sale, utilizando estados en consola

	msgCarros BYTE "Entrada o salida de carro (ingrese 1 para entrada o 2 para salida): ", 0
	msgLleno BYTE "Estacionamiento lleno.", 0
	msgRestantes BYTE "Espacios restantes: ", 0
	msgVacio BYTE "Estacionamiento vacio.", 0
	msgIngreso BYTE "Ingreso de carro.", 0
	msgSalida BYTE "Salida de carro.", 0
	
	ingresoCarros = 1
	salidaCarros = 2
	espacioEstacionamiento DWORD 20 ;espacio disponible del estacionamiento 
	limiteEstacionamiento = 20 ;limite de espacios del estacionamiento

.code
main PROC	
inicio:
	mov edx, OFFSET msgCarros ;mensaje de entrada o salida de carros
	call WriteString
	call ReadInt

	cmp eax, ingresoCarros ;compara lo escrito en consola con el numero definido para simular el ingreso de carros
	je ingreso ;si es igual, se va a la etiqueta de ingreso

	;si no es igual, sigue con el programa
	cmp eax, salidaCarros ;compara lo escrito en consola con el numero que simula la salida de carros
	je salida ;si es igual, se va a la etiqueta de salida

	jmp fin ;si se ingreso cualquier otra cosa, se termina el programa
	
ingreso:
	cmp espacioEstacionamiento, 0
	je lleno ; los carros no pueden entrar si el estacionamiento esta lleno
	
	mov edx, OFFSET msgIngreso ;mensaje que indica el ingreso de un carro
	call WriteString
	call crlf

	dec espacioEstacionamiento ;si ingresó un carro, hay un espacio menos

	mov edx, OFFSET msgRestantes ;imprime el mensaje de espacios restantes
	call WriteString

	mov eax, espacioEstacionamiento
	call WriteDec ;imprime los espacios restantes
	call crlf

	jmp inicio ;regresa al inicio

salida:
	cmp espacioEstacionamiento, limiteEstacionamiento ;si son iguales, quiere decir que el estacionamieto esta vacio, por lo que no existen carros que puedan salir
	je vacio ; aviso de que el estacionamiento esta vacio

	mov edx, OFFSET msgSalida ;imprime el mensaje de salida de un carro
	call WriteString
	call crlf

	inc espacioEstacionamiento ;incrementan los espacios disponibles en el estacionamiento

	mov edx, OFFSET msgRestantes
	call WriteString

	mov eax, espacioEstacionamiento ;muestra los espacios restantes
	call WriteDec
	call crlf

	jmp inicio

lleno:
	mov edx, OFFSET msgRestantes
	call WriteString

	mov eax, espacioEstacionamiento
	call WriteDec
	call crlf

	mov edx, OFFSET msgLleno ;el estacionamiento está lleno
	call WriteString
	call crlf

	jmp inicio

vacio:
	mov edx, OFFSET msgRestantes
	call WriteString

	mov eax, espacioEstacionamiento
	call WriteDec
	call crlf

	mov edx, OFFSET msgVacio ;el estacionamiento está vacío
	call WriteString
	call crlf

	jmp inicio

fin: ;fin del programa
	exit

main ENDP
END main