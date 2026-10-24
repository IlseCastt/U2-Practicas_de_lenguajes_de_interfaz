; Materia: Lenguajes de Interfaz 
; Alumna: Ilse Marianne Castillo Pimienta - 23170117
; Horario: 8:00-9:00am
; Docente: Dr. José Luis Medina Jiménez 
; Práctica: 07 - Validación de formato
; Descripción: Programa que solicita una cadena de texto y verifica que cumpla con el formato debido: "ABC-123"

INCLUDE Irvine32.inc

.data
	mensaje BYTE "Ingrese una cadena: ", 0
	msgInvalido BYTE "Formato invalido.", 0
	msgCorrecto BYTE "Formato valido, su texto es: ", 0

	codigo BYTE 8 DUP(0) ;variable para guardar la cadena. reservamos 8 caracteres, 7 para la cadena y 1 para el terminador nulo

.code
main PROC
inicio:
	mov esi, 0

	mov edx, OFFSET mensaje
	call WriteString

	mov edx, OFFSET codigo
	mov ecx, SIZEOF codigo ;definimos el tamaño de la cadena 
	call ReadString

	cmp eax, 7 
	je letras ;si el tamaño concuerda, salta a la siguiente validación 

	jmp invalido ;si no, directamente marca la cadena como invalida y la vuelve a solicitar

letras: ;validamos los primeros 3 caracteres
	mov al, codigo[ESI] ;copia el caracter actual de la cadena a al

	;si dentro de ASCII el caracter que se está evaluando no entra dentro de los rangos de 'A' a 'Z', es una cadena inválida
	cmp al, 'A'
	jb invalido 

	cmp al, 'Z'
	ja invalido

	cmp ESI, 2 ;si ya recorrió los primeros 3 caracteres (empezando en 0), brinca a la etiqueta del 4to caracter
	je separador

	inc ESI ;incrementa el apuntador para cambiar de caracter

	jmp letras ;si aún quedan caracteres por validar, regresamos a la etiqueta

separador: ;validación del guión 
	inc ESI ;incrementamos ESI para llegar a la posición del separador
	mov al, codigo[ESI]

	cmp al, '-' 
	je numeros ;si el caracter es igual al guión, pasamos a la siguiente validación

	jmp invalido ;si no, la cadena es inválida

numeros: ;validación de números (caracteres 5-7)
	inc ESI ;incrementamos ESI para ir al siguiente caracter
	mov al, codigo[ESI] ;copiamos el caracter en al

	;si el caracter a evaluar no se encuentra dentro de los rangos numéricos de ASCII, la cadena es inválida
	cmp al, '0'
	jb invalido

	cmp al, '9'
	ja invalido

	cmp ESI, 6
	je correcto ;si llegamos al último caracter, pasamos a la etiqueta "correcto"

	jmp numeros ;si aún no llegamos al último caracter, seguimos con las validaciones

invalido: ;muestra el mensaje de cadena inválida y vuelve a solicitarla
	mov edx, OFFSET msgInvalido
	call WriteString
	call crlf

	jmp inicio

correcto: ;muestra el mensaje de cadena válida
	mov edx, OFFSET msgCorrecto
	call WriteString
	
	mov edx, OFFSET codigo ;imprime la cadena
	call WriteString
	call crlf

	jmp fin

fin: ;fin del programa
	exit

main ENDP
END main