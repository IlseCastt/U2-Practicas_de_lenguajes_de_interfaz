; Materia: Lenguajes de Interfaz 
; Alumna: Ilse Marianne Castillo Pimienta - 23170117
; Horario: 8:00-9:00am
; Docente: Dr. José Luis Medina Jiménez 
; Práctica: 13 - Obtención de una cadena hexadecimal
; Descripción: Programa que define un valor en hexadecimal y lo convierte a cadena de texto
 
INCLUDE Irvine32.inc
 
.data
    msgHexadecimal BYTE "La cadena hexadecimal es: ", 0

    buffer BYTE 9 DUP(0) ;tomamos en cuenta 8 caracteres decimales y el último es para el terminador nulo

    hexadecimal = 12AB34CDh ;valor que queremos convertir a texto
 
.code
main PROC
    mov eax, hexadecimal  
    call convertirHexadecimal ;llamamos al procedimiento para convertir el valor en hexadecimal a texto
 
    mov edx, OFFSET msgHexadecimal  
    call WriteString

    mov edx, OFFSET buffer ;mueve en edx la dirección de donde se encuentra la cadena en hexadecimal
    call WriteString
    call crlf
 
    exit
main ENDP

convertirHexadecimal PROC 
    mov buffer[8], 0 ;colocamos el terminador nulo en la última posición del buffer (la 8)
    mov esi, 7 ;comenzamos a recorrer los dígitos desde el último caracter
    mov ecx, 8 ;definimos los dígitos a extraer
 
digitos:
    mov dl, al ;copiamos el byte bajo de eax en dl
    and dl, 0Fh ;usamos esa máscara para conservar solo el nibble
 
    cmp dl, 9 ;comparamos si el dígito es un valor decimal
    jbe conversionNumero ;si es un número, pasamos a la conversión de los números
 
    ;si no es un número y es una letra
    sub dl, 10 ;restamos 10 
    add dl, 'A' ;y sumamos el valor de 'A' en ASCII para obtener su valor en texto

    jmp guardarCadena
 
conversionNumero:
    add dl, '0' ;simplemente sumamos '0' en ASCII para obtener el valor de un número en texto 
 
guardarCadena:
    mov buffer[esi], dl ;movemos los caracteres al buffer
    shr eax, 4 ;desplazamos 4 bits para obtener el siguiente caracter
    dec esi ;decrementamos esi para cambiar de caracter
    
    loop digitos ;se repite todo el proceso mientras ecx sea diferente de 0
 
    ret ;cuando exc llegue a 0, se termina el procedimiento 
convertirHexadecimal ENDP
 
END main