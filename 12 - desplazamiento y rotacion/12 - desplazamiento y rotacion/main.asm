; Materia: Lenguajes de Interfaz 
; Alumna: Ilse Marianne Castillo Pimienta - 23170117
; Horario: 8:00-9:00am
; Docente: Dr. José Luis Medina Jiménez 
; Práctica: 12 - Desplazamiento y rotación
; Descripción: Programa que permite el funcionamiento de las funciones que se utilizan para el desplazamiento 
;              y rotación de los bits y cómo se encienden las banderas

INCLUDE Irvine32.inc

.code
main proc
    mov eax, 0
    mov ebx, 0
    mov ecx, 0
    mov edx, 0 ;primero limpiamos los registros

    ; 1. SHL desplazar una posición a la izquierda
    mov al, 00001100b   
    shl al, 1       ;como se desplazó un bit a la izquierda, aumentó su valor el doble

    call dumpRegs

    call WriteBin ;muestra el valor en binario de EAX 
    call crlf

    mov al, 10000000b ;el bit que se desborda es el más significativo y lo alamcena CF
    shl al, 1       ;00000000b, ese 1 salió de al y activó CF y como al quedó vacío, se activó ZF

    call DumpRegs

    call WriteBin
    call crlf

    ; 2. SHR desplazar una posición a la derecha
    mov al, 00001101b  
    shr al, 1           ;como se movió a la derecha, se realizó una división entre 2 del valor de al (13) y como es impar, su residuo activó CF y se guardó ahí

    call dumpRegs

    call WriteBin
    call crlf

    ; 3. SAR conservar el signo
    mov al, -8 ;11111000b es la representación de -8, el primer bit marca el estado negativo, los demás se encuentran en positivo y todos los valores se suman para obtener el valor final
    sar al, 1   ;sar desplaza a la derecha y mantiene el bit de signo, como se desplaza una posición, ahora el resultado es -4 y el 0 desplazado lo guarda CF

    call dumpRegs

    call WriteBin
    call crlf

    ; 4. SAR con operaciones no exactas
    mov al, -9  ;11110111b es la representación de -9 en binario
    sar al, 1  ;el resultado es -5. SAR redondea hacia el infinito negativo y el bit desplazado (1) se guarda en CF

    call dumpRegs

    call WriteBin
    call crlf

    ; 5. conteo: desplazar 2 bits hacia la izquierda con constante
    mov al, 00001111b ;15
    shl al, 2   ;como se desplazan 2 bits a la izquierda, se cuatriplica su valor dando como resultado 60

    call dumpRegs

    call WriteBin
    call crlf

    ; 6. desplazar 2 bits hacia la derecha utilizando cl
    mov al, 00001111b 
    mov cl, 2
    shr al, cl  ;ahora como se desplazan a la derecha, se divide el valor entre 4 y se usa el registro cl como contador
 
    call DumpRegs

    call WriteBin
    call crlf

    ; 7. hacer ROR, ROL, RCL, RCR

    ;ROL rota hacia la izquiera, el bit más significativo pasa a ser el menos significativo y CF "atrapa" ese bit
    mov al, 10001100b ;el valor es = 140
    rol al, 1           ;ahora el valor es 00011001b = 25 y CF copia el valor del bit menos significativo (1)  

    call dumpRegs

    call WriteBin
    call crlf

    ;RCL rota hacia la izquierda pero pasa por CF, entonces el bit mas significativo pasa a estar en CF y el valor de CF entra en los bits
    mov al, 10001100b
    clc     ;clear carry, limpia la bandera
    rcl al, 1       ;00011000b, el 1 del bit 7 pasa a estar en CF y el valor de CF entra en los bits

    call dumpRegs

    call WriteBin
    call crlf

    ;ROR rota hacia la derecha, el bit menos significativo pasa a ser el más significativo y CF lo "atrapa"
    mov al, 00001101b
    ror al, 1           ;ahora los bits pasan a ser: 10000110b y CF copia el valor del bit más significativo

    call dumpRegs

    call WriteBin
    call crlf

    ;RCR rota hacia la derecha y pasa por CF, por lo que el bit menos significativo va a CF y el valor de CF se coloca en el bit más significativo
    mov al, 00001101b
    clc       
    rcr al, 1       ;el 1 del bit 0 pasa ahora a CF y el valor de CF (0) pasa al bit más significativo

    call dumpRegs
    call WriteBin

    call crlf

    exit

main endp
end main