; Materia: Lenguajes de Interfaz 
; Alumna: Ilse Marianne Castillo Pimienta - 23170117
; Horario: 8:00-9:00am
; Docente: Dr. José Luis Medina Jiménez 
; Práctica: 04.1 - Mayor, menor o igual con entrada del usuario
; Descripción: Programa que pide 2 números en consola y los compara

INCLUDE Irvine32.inc

.data
    msgPrimerNum BYTE "Ingrese el primer numero: ", 0
    msgSegundoNum BYTE "Ingrese el segundo numero: ", 0

    msgSonIguales BYTE "Los numeros son iguales", 0
    msgEsMayor BYTE "El primer numero es mayor", 0
    msgEsMenor BYTE "El primer numero es menor", 0
    msgFin BYTE "Fin del programa...", 0

    numero1 DWORD ?
    numero2 DWORD ?

.code
main PROC

inicio:
    mov edx, OFFSET msgPrimerNum 
    call WriteString ;pedimos el primer numero
    call ReadInt ;lee el numero escrito en consola y lo guarda en eax

    mov numero1, eax ;copiamos el numero escrito en consola en la variable numero1

    mov edx, OFFSET msgSegundoNum 
    call WriteString ;pedimos el segundo numero
    call ReadInt 

    mov numero2, eax ;copiamos el numero escrito en consola en la variable numero2

    mov eax, numero1 
    mov ebx, numero2 ;copiamos los numeros a los registros eax y ebx

    cmp eax, ebx ;realizamos una comparacion de los numero

    je iguales ;si son iguales, saltamos a la etiqueta de iguales
    jg esMayor ;jg considera signos y salta si el numero es mayor 
    jl esMenor ;jl considera signos y salta si el numero es menor

iguales:
    mov edx, OFFSET msgSonIguales 
    call WriteString 
    call crlf

    jmp fin ;salta a la etiqueta de fin del programa

esMayor:
    mov edx, OFFSET msgEsMayor  
    call WriteString 
    call crlf

    jmp fin 

esMenor:
    mov edx, OFFSET msgEsMenor 
    call WriteString 
    call crlf

    jmp fin

fin: ;etiqueta de fin del programa
    mov edx, OFFSET msgFin
    call WriteString
    call crlf
    exit 

main ENDP
END main