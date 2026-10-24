; Materia: Lenguajes de Interfaz 
; Alumna: Ilse Marianne Castillo Pimienta - 23170117
; Horario: 8:00-9:00am
; Docente: Dr. José Luis Medina Jiménez 
; Práctica: 10 - Obtención de una cadena decimal
; Descripción: Programa que realiza operaciones con valores numéricos para posteriormente convertir los resultados a cadena de texto

INCLUDE Irvine32.inc

.data 
	;variables DWORD con tamaño especificado
	archivo DWORD 100000 
	bloques DWORD 125
	tamBloque DWORD 512
	tamGrupo DWORD 1024 

	;variables con tamaño desconocido
	descargados DWORD ?
	pendientes DWORD ?
	avance DWORD ?
	completos DWORD ? 
	residuoAgrupamiento DWORD ?

	buffer BYTE 11 DUP(0) ;reserva un espacio en memoria para guadar la cadena, 11 bytes porque el ultimo se reserva para 00h

	mensajeDescargados BYTE "Los bytes descargados son: ", 0
	mensajePendientes BYTE "Los bytes pendientes son: ", 0
	mensajeAvance BYTE "El porcentaje de avance es: ", 0
	mensajeGrupos BYTE "Los grupos completos de 1024 bytes son: ", 0
	mensajeResiduo BYTE "El residuo del agrupamiento es: ", 0

.code
main PROC
	mov eax, 0
	mov ebx, 0

bytesDescargados: ;multiplicación para obtener los bytes descargados
	mov eax, tamBloque
	mov ebx, bloques

	mul ebx ; 125 * 512 = resultado en eax

	mov descargados, eax

bytesPendientes: ;resta para obtener los bytes pendientes
	mov eax, archivo
	mov ebx, descargados

	sub eax, ebx ;100000 - (125*512)
	mov pendientes, eax

porcentajeAvance: ;multiplicación para obtener el porcentaje de avance de descarga
	mov eax, descargados
	mov ebx, 100 

	mul ebx ;se multiplican los descargados *  100 para obtener el porcentaje como numero entero superior a 0
	div archivo ;(512*125*100) / 100,000

	mov avance, eax

gruposCompletos: ;división para obtener los grupos de descarga completos de 1024 bytes
	mov eax, 0
	mov ebx, 0
	mov edx, 0

	mov eax, descargados
	mov ebx, tamGrupo

	div ebx ;(512*125) / 1024

	mov completos, eax

	mov residuoAgrupamiento, edx ;guarda el residuo de la división

resultados:
	
	;descargados
	mov edx, OFFSET mensajeDescargados
	call WriteString

	mov eax, descargados ;carga el numero a convertir en eax para que lo reciba el procedimento 
	mov esi, OFFSET buffer ;carga la direccion del buffer en esi para saber dónde escribir los caracteres
	call convertirDecimal ;se llama al procedimiento
	mov edx, OFFSET buffer ;indicamos la direccion de la cadena
	call WriteString
	call crlf

	;pendientes
	mov edx, OFFSET mensajePendientes
	call WriteString

	mov eax, pendientes
	mov esi, OFFSET buffer
	call convertirDecimal
	mov edx, OFFSET buffer
	call WriteString
	call crlf

	;porcentaje de avance
	mov edx, OFFSET mensajeAvance
	call WriteString

	mov eax, avance
	mov esi, OFFSET buffer
	call convertirDecimal
	mov edx, OFFSET buffer
	call WriteString
	call crlf

	;grupos de 1024 byes
	mov edx, OFFSET mensajeGrupos
	call WriteString

	mov eax, completos
	mov esi, OFFSET buffer
	call convertirDecimal
	mov edx, OFFSET buffer
	call WriteString
	call crlf

	;residuo de agrupamiento
	mov edx, OFFSET mensajeResiduo
	call WriteString

	mov eax, residuoAgrupamiento
	mov esi, OFFSET buffer
	call convertirDecimal
	mov edx, OFFSET buffer
	call WriteString
	call crlf

exit
main ENDP

convertirDecimal PROC ;procedimento para pasar de un valor decimal a una cadena de texto
	mov ebx, 10
	mov ecx, 0

inicio:
	mov edx, 0

	div ebx ;divide el valor en eax (dividendo) entre 10. el programa siempre lee a eax como dividendo, por eso no es necesario indicar su valor aquí
	push edx ;guarda el residuo en la pila (de esta forma se irá construyendo el número)
	inc ecx ;cuenta los dígitos que se guardan en la pila
	cmp eax, 0
	je construirCadena ;si ya no quedan dígitos (eax = 0), pasar a la construcción de la cadena de texto

	jmp inicio ;si aún quedan dígitos, se sigue realizando el procedimiento
		

construirCadena:
	pop eax ;se saca el último dígito metido en la pila
	add eax, '0' ;se suma el valor de 0 en ASCII para convertir el dígito a cadena de texto
	mov [esi], al ;se utiliza al porque se tiene solo un caracter. Guarda cada caracter en el buffer
	inc esi ;apunta a la siguiente posición del buffer
	dec ecx ;se decremeta ecx para saber cuántos dígitos quedan

	cmp ecx, 0
	jne construirCadena ;si aún quedan dígitos, vuelve a realizar el procedimiento

	mov al, 0
	mov [esi], al ;agrega el 00h a la cadena de texto para que writestring sepa dónde termina

	ret ;hace que el programa se regrese al main

convertirDecimal ENDP

END main