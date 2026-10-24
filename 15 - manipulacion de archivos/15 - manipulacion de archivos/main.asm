; Materia: Lenguajes de Interfaz 
; Alumna: Ilse Marianne Castillo Pimienta - 23170117
; Horario: 8:00-9:00am
; Docente: Dr. José Luis Medina Jiménez 
; Práctica: 15 - Manipulación de archivos
; Descripción: Programa que genera un archivo de texto y realiza una escritura en el mismo

INCLUDE Irvine32.inc

.data
	nombreArchivo BYTE "Inventario.txt", 0
	texto BYTE "125", 0 ;valor que se va a almacenar en el archivo
	archivoHandle DWORD ? ;almacena el valor del identificador del archivo

	mensajeExito BYTE "Archivo guardado", 0
	mensajeError BYTE "El archivo no se guardo correctamente", 0

.code
main PROC
	;crear el archivo
	mov edx, OFFSET nombreArchivo
	call CreateOutputFile ;función de Irvine que nos ayuda a crear el archivo

	cmp eax, INVALID_HANDLE_VALUE ;comparar si corresponde a un valor invalido para saber si el archivo tuvo problemas para crearse
	je error

	mov archivoHandle, eax ;guardamos el id

	;escribir el texto ("125")
	mov eax, archivoHandle
	mov edx, OFFSET texto
	mov ecx, SIZEOF texto - 1 ;se resta uno para no escribir el terminador nulo
	call WriteToFile ;función que permite escribir el texto en el archivo

	jc errorEscritura ;si hubo carry (el disco duro está lleno), manda un mensaje de error

	cmp eax, SIZEOF texto - 1
	jne errorEscritura ;salta al error si no es escribió en el archivo de texto

	;cerrar archivo txt
	mov eax, archivoHandle
	call CloseFile ;función que nos ayuda a cerrar el archivo

	test eax, eax ;close file regresa 0 en eax si hubo un error al cerrar el archivo, test realiza un AND lógico y encienda ZF si el resultado es 0 
	jz error ;si da cero, manda a la etiqueta de error

	mov edx, OFFSET mensajeExito ;si todo salió bien, se imprime en consola un mensaje de éxito
	call WriteString
	jmp fin ;fin del programa

errorEscritura: 
	mov eax, archivoHandle
	call CloseFile

error: 
	mov edx, OFFSET mensajeError
	call WriteString
	call crlf

fin:
	exit

main ENDP
END main