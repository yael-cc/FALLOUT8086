;********************************************************
; PROYECTO - LENGUAJES DE INTERFAZ
; FALLOUT8086
; Cuevas Cruz Luis Angel Yael 
; Romo Ruiz Paulina Michelle
;********************************************************
INCLUDE macrosProyecto.lib
.MODEL SMALL
.STACK
.DATA
    rutaCarpeta db 'C:\FALLOUT8086',0
    rutaDatosJugador   db 'C:\FALLOUT8086\DatosJugador.txt',0
    rutaDatosPartida   db 'C:\FALLOUT8086\DatosPartida.txt',0   
    ren     db 0
    col     db 0
    simb    db 0
    rastreo db 0
    num_condicion   db 0
    idDatosJugador  dw 0
    idDatosPartida  dw 0
    cadenaDatosJug  db 100 DUP(0)
    paginaAct   db 0
    largoCad   dw 0
    caracter   db 0    
    esqIzqS db 213
    esqDerS db 184
    msjNomb db ' Nombre:             '
    msjEdad db ' Edad:               '
    msjNomJ db ' Nombre[juego]:      '
    msjGen  db ' Genero[M o F]:      '
    msjRef  db ' Nombre del refugio: '
    msjImp  db '     Presiona ENTER para continuar o E para imprimir.      '
    msjDatosJug  db '   Rellena los datos del formulario segun se te indique.   '
    msjMenuSalir  db 'Presiona ESC para omitir o cualquier tecla para continuar.' 
    nombre  db 30 DUP(0)
    edad    db 3 DUP(0)
    nomJug  db 15 DUP(0)
    genero  db 2 DUP(0)
    nombRef db 20 DUP(0)
    datosJugador    db 80 DUP(0)
    datosPartida    db 80 DUP(0)        
    colorNormal     db 0AH
    colorDestacado  db 0B0H  
    titulo  db 'FALLOUT 8086'
    tituloForm db ' DATOS DEL JUGADOR '
    msjBienvenida db 'BIENVENIDO '
    rec     db 'Recursos =>'
    tAgua   db 'Agua:'
    tComida db 'Comida:'
    tEnerg  db 'Energ',161,'a:'
    tHab    db 'Habitantes:'
    tAvan   db 'Avance:'
    rAgua   db '100',0
    rComida db '100',0
    rEnerg  db '100',0
    rAvan   db '  1%',0
    rHab    db '100',0    
    estado  db 'ESTABLE  ',0
    msgEdo  db 'ESTADO: '
    linea1  db 'En este espacio se encuentra el texto de'
    linea2  db 'la historia del juego que aparece       '
    linea3  db 'conforme avanzas en el juego...         '
    linea4  db 'Tendr',160,'s que tomar algunas decisiones que'
    linea5  db 'van a afectar tu camino en la historia. '
    tReg    db ' REGISTRO DEL SISTEMA '
    reg1    db 16,'     [Primer registro vac',161,'o]      '
    reg2    db 16,'     [Segundo registro vac',161,'o]     '
    reg3    db 16,'     [Tercer registro vac',161,'o]      '
    reg4    db 16,'     [Cuarto registro vac',161,'o]      '
    reg5    db 16,'     [Quinto registro vac',161,'o]      '
    reg6    db 16,'     [Sexto registro vac',161,'o]       '
    regA1   db 35 DUP(?)
    regA2   db 35 DUP(?)
    regA3   db 35 DUP(?)
    regA4   db 35 DUP(?)
    regA5   db 35 DUP(?)
    regA6   db 35 DUP(?)    
    posDatosJugador dw 0
    posDatosPartida dw 0
    monito  db 10, 13, '                                                                         ',223,223,223,' '
            db 10, 13, '                                                                        ',219,219,' ',219,219
            db 10, 13, '                                                                             '
            db 10, 13, '                                                                        ',219,223,223,223,219
            db 10, 13, '                                                                             '
            db 10, 13, '                                                                         ',223,223,223,' '
            db 0 ; Fin de cadena
    ; ============ MACROS TEMPORALES ===============        
                                                   
.CODE
    INICIO:
        MOV AX, @DATA
        MOV DS, AX 
        MOV ES, AX
    ; Por defecto viene en pagina 0    
    CALL PANTALLA_FORMULARIO
    
    ; Cambia a la pagina 1, a la pantalla principal del juego
    MOV paginaAct, 1
    CALL CAMBIAR_PAGINA
    CALL PANTALLA_JUEGO                
     
    JMP FIN
                                             
    FIN:
        CALL ARCHIVO_DATOS_PARTIDA                       
        MOV AX, 4C00H
        INT 21H
        
    ; ============== PROCEDIMIENTOS =================
    VERTICAL PROC
        MOV AH,2   ;CURSOR
        MOV DH,REN
        MOV DL,COL
        MOV BH, paginaAct
        INT 10H
                MOV AH,9    ; CARACTER COLOR
                MOV AL,186  ;CARACTER
                MOV BL,colorNormal    ;COLOR
                MOV CX,1    ;VECES 
                MOV BH,paginaAct
                INT 10H
         INC REN            ; INCREMENTO EN 1  
         
         CMP REN,23         ; COMPARAR RENGLÓN
         JLE VERTICAL
         RET
    ENDP
    
    LIMPIAR_REGS PROC
        MOV AX, 0000h
        MOV BX, 0000h
        MOV CX, 0000h
        MOV DX, 0000h
        RET     
    ENDP
        
    ACT_RECURSOS PROC                
        ;  Imprimir todos los recursos
        IMP_COLOR_CURSOR 1, 48, rAgua, 3, colorNormal       ; Agua
        IMP_COLOR_CURSOR 1, 61, rComida, 3, colorNormal     ; Comida
        IMP_COLOR_CURSOR 1, 75, rEnerg, 3, colorNormal      ; Energia
        IMP_COLOR_CURSOR 2, 59, rHab, 3, colorNormal        ; Habitantes
        IMP_COLOR_CURSOR 2, 70, rAvan, 4, colorNormal       ; Avance            
        RET
    ENDP
    
    MARCO_PRINCIPAL PROC
        ; LINEAS VERTICALES
        MOV REN, 0
        MOV COL, 0                
        CALL VERTICAL
        CALL LIMPIAR_REGS
        MOV REN, 0
        MOV COL, 79
        CALL VERTICAL
        CALL LIMPIAR_REGS
        
        ; LINEA SUPERIOR DEL MARCO        
        CURSOR 0, 0 ; Colocar en posicion inicial        
        LINEA_HORIZONTAL 205, colorNormal, 80 ; Primer linea horizontal        
        ; ESQUINAS SUPERIORES
        MOV simb, 187
        IMP_COLOR_CURSOR 0, 79, simb, 1, colorNormal
        MOV simb, 201
        IMP_COLOR_CURSOR 0, 0, simb, 1, colorNormal                                    
        
        ; LINEA INFERIOR BAJA
        CURSOR 24, 0                                                                          
        LINEA_HORIZONTAL 205, colorNormal, 80
        ; ESQUINAS INFERIORES
        MOV simb, 188
        IMP_COLOR_CURSOR 24, 79, simb, 1, colorNormal
        MOV simb, 200
        IMP_COLOR_CURSOR 24, 0, simb, 1, colorNormal
        RET
    ENDP
    
    LIMPIAR_PANTALLA PROC
        CALL LIMPIAR_REGS
        MOV AH, 06h
        MOV AL, 0
        MOV BH, 00H
        MOV CX, 0
        MOV DH, 24
        MOV DL, 79
        INT 10h
        RET
    ENDP
    
    PANTALLA_JUEGO PROC                              
        ; SE LEEN DATOS DEL JUGADOR DESDE EL ARCHIVO (EVIDENCIABLE SOBRE TODO EN NOMBRE DE JUGADOR)
        CALL EXTRAER_DATOS_JUGADOR
        
        ; Monito
        CALL LIMPIAR_REGS         
        IMP_COLOR_CURSOR 7, 0, monito, 475, 0BH      ; Monito
        
        CALL MARCO_PRINCIPAL
        
        ; LINEA SUPERIOR BAJA        
        ; Posicion
        CURSOR 4, 0
        ; Linea superior baja
        LINEA_HORIZONTAL 205, colorNormal, 80                                
        MOV simb, 185
        IMP_COLOR_CURSOR 4, 79, simb, 1, colorNormal
        MOV simb, 204
        IMP_COLOR_CURSOR 4, 0, simb, 1, colorNormal                  
        
        CURSOR 18, 0        

        LINEA_HORIZONTAL 205, colorNormal, 80
        MOV simb, 185
        IMP_COLOR_CURSOR 18, 79, simb, 1, colorNormal
        MOV simb, 204
        IMP_COLOR_CURSOR 18, 0, simb, 1, colorNormal
        
        ; IMPRIMIR TITULO
        IMP_COLOR_CURSOR 2, 3, titulo, 12, colorDestacado
        CURSOR 1, 3
        LINEA_HORIZONTAL 95, colorNormal,12
        CURSOR 3, 3
        LINEA_HORIZONTAL 196, colorNormal,12
        
        ; IMPRIMIR TITULO RECURSOS        
        IMP_COLOR_CURSOR 2, 28, rec, 11, colorDestacado
        
        ; IMPRIMIR NOMBRES RECURSOS       
        IMP_COLOR_CURSOR 1, 42, tAgua, 5, colorNormal      ; Agua               
        IMP_COLOR_CURSOR 1, 53, tComida, 7, colorNormal    ; Comida       
        IMP_COLOR_CURSOR 1, 66, tEnerg, 8, colorNormal     ; Energia         
        IMP_COLOR_CURSOR 2, 48, tHab, 11, colorNormal      ; Habitantes                     
        IMP_COLOR_CURSOR 2, 63, tAvan, 7, colorNormal      ; Avance
        
        ; SE LEEN LOS DATOS DE PARTIDA DESDE EL ARCHIVO (SE APRECIA EN LOS RECURSOS)
        CALL EXTRAER_DATOS_PARTIDA
        CALL ACT_RECURSOS   ;Actualizar recursos                                                          
        
        ; BIENVENIDA
        IMP_COLOR_CURSOR 5, 2, msjBienvenida, 11, colorDestacado
        IMP_COLOR_CURSOR 5, 13, nomJug, 15, colorDestacado
        
        ; Estado general
        IMP_COLOR_CURSOR 10, 3, msgEdo, 8, colorDestacado   ; Titulo Estado
        IMP_COLOR_CURSOR 12, 3, estado, 9, colorNormal      ; Estado actual                                           
        
        ; Historia                                          
        MOV largoCad, 40
        IMP_CENTRAL linea1, linea2, linea3, linea4, linea5 
        
        ; Registros
        CALL LIMPIAR_REGS        
        IMP_COLOR_CURSOR 18, 28, tReg, 22, colorNormal   ; TITULO REGISTROS                                    
        ESTABLECER_HISTORIAL_ACTUAL reg1, reg2, reg3, reg4, reg5, reg6
        
        RET
    ENDP    
    
    PANTALLA_FORMULARIO PROC
        CALL LIMPIAR_PANTALLA
        CALL MARCO_PRINCIPAL
        ; LINEA SUPERIOR BAJA        
        ; Posicion
        CURSOR 4, 0
        ; Linea superior baja
        LINEA_HORIZONTAL 205, colorNormal, 80                                
        MOV simb, 185
        IMP_COLOR_CURSOR 4, 79, simb, 1, colorNormal
        MOV simb, 204
        IMP_COLOR_CURSOR 4, 0, simb, 1, colorNormal
        ; Imprimir titulo principal del formulario
        IMP_COLOR_CURSOR 2, 3, tituloForm, 19, colorDestacado
        CURSOR 1, 3
        LINEA_HORIZONTAL 95, colorNormal,19
        CURSOR 3, 3
        LINEA_HORIZONTAL 196, colorNormal,19
        
        MOV largoCad, 21
        IMP_CENTRAL msjNomb, msjEdad, msjNomJ, msjGen, msjRef
        IMP_COLOR_CURSOR 18, 7, msjMenuSalir, 58, colorNormal
        CURSOR 18, 67, paginaAct
        RASTREO_TECLA
        CMP RASTREO,01H
            JE FIN_ABS             
        IMP_COLOR_CURSOR 18, 7, msjDatosJug, 58, colorNormal
        INICIO_FORMULARIO:
            PEDIR_CADENA 7, 42, nombre, 30 
            PEDIR_CADENA 9, 42, edad, 2
            PEDIR_CADENA 11, 42, nomJug, 15
            PEDIR_CADENA 13, 42, genero, 1
            PEDIR_CADENA 15, 42, nombRef, 20
        
        ; OPCIONES
        IMP_COLOR_CURSOR 18, 7, msjImp, 58, colorNormal
        INICIO_OPCIONES_IMP:
            CURSOR 18, 67, paginaAct
            RASTREO_TECLA
            CMP RASTREO, 1Ch
                JE FIN_IMP
            CMP CARACTER, 'E'
                JE IMPRIMIR_DATOS
            CMP CARACTER, 'e'
                JE IMPRIMIR_DATOS            
            JMP INICIO_OPCIONES_IMP    
        IMPRIMIR_DATOS:    
            CALL IMPRIMIR_FORMULARIO
        FIN_IMP:
            CALL ARCHIVO_DATOS_JUGADOR
        FIN_ABS:    
        RET            
    ENDP
    
    IMPRIMIR_FORMULARIO PROC        
        CALL LIMPIAR_REGS            
        
        ; LIMPIAR IMPRESORA
        MOV AH, 5
        MOV DL, 12
        INT 21H
        
        MOV SI, 0
        MOV CX, 15        
        IMP_DETALLES1: 
              ; IMPRIMIR
              MOV AH, 5
              MOV DL, 61
              INT 21H
              
              INC SI
            LOOP IMP_DETALLES1
        
        IMPRIMIR_VARIABLE tituloForm, 19        
        
        MOV SI, 0
        MOV CX, 15        
        IMP_DETALLES2: 
              ; IMPRIMIR
              MOV AH, 5
              MOV DL, 61
              INT 21H
              
              INC SI
            LOOP IMP_DETALLES2
        
            ; SALTO DE LINEA
            MOV simb, 10
            IMPRIMIR_VARIABLE simb, 1
            MOV simb, 13
            IMPRIMIR_VARIABLE simb, 1
        
        ; IMPRIMIR NOMBRE
        IMPRIMIR_VARIABLE msjNomb, 21
        IMPRIMIR_VARIABLE nombre,30
            ; SALTO DE LINEA
            MOV simb, 10
            IMPRIMIR_VARIABLE simb, 1
            MOV simb, 13
            IMPRIMIR_VARIABLE simb, 1
        ; IMPRIMIR EDAD
        IMPRIMIR_VARIABLE msjEdad, 21
        IMPRIMIR_VARIABLE edad, 2
            ; SALTO DE LINEA
            MOV simb, 10
            IMPRIMIR_VARIABLE simb, 1
            MOV simb, 13
            IMPRIMIR_VARIABLE simb, 1
        ; IMPRIMIR NOMBRE JUGADOR
        IMPRIMIR_VARIABLE msjNomj, 21
        IMPRIMIR_VARIABLE nomJug, 15
            ; SALTO DE LINEA
            MOV simb, 10
            IMPRIMIR_VARIABLE simb, 1
            MOV simb, 13
            IMPRIMIR_VARIABLE simb, 1
        ; IMPRIMIR GENERO
        IMPRIMIR_VARIABLE msjGen, 21
        IMPRIMIR_VARIABLE genero, 1
            ; SALTO DE LINEA
            MOV simb, 10
            IMPRIMIR_VARIABLE simb, 1
            MOV simb, 13
            IMPRIMIR_VARIABLE simb, 1
        ; IMPRIMIR NOMBRE DEL REFUGIO
        IMPRIMIR_VARIABLE msjRef, 21
        IMPRIMIR_VARIABLE nombRef, 20            
        RET
    ENDP
    
    CAMBIAR_PAGINA PROC
        MOV AH, 05h
        MOV AL, paginaAct
        INT 10h
        RET
    ENDP
    
    ARCHIVO_DATOS_JUGADOR PROC
        REEMPLAZAR_CADENA_JUGADOR posDatosJugador, nombre
        REEMPLAZAR_CADENA_JUGADOR posDatosJugador, edad
        REEMPLAZAR_CADENA_JUGADOR posDatosJugador, nomJug
        REEMPLAZAR_CADENA_JUGADOR posDatosJugador, genero
        REEMPLAZAR_CADENA_JUGADOR posDatosJugador, nombRef
        
        ; 1. Crear la carpeta principal
        CREAR_CARPETA rutaCarpeta
        
        ; 2. Crear archivo "DatosJugador.txt"
        CREAR_ARCHIVO rutaDatosJugador, 32        
        MOV idDatosJugador, AX ; Recuperar id
        
        ; 3. Abrir archivo
        CALL LIMPIAR_REGS
        ABRIR_ARCHIVO rutaDatosJugador, 2
            MOV idDatosJugador, AX
        CALL LIMPIAR_REGS
        MOV CX, posDatosJugador
        INC CX
        
        ; 4. Escribir en el archivo
        ESCRIBIR_ARCHIVO idDatosJugador, CX, datosJugador
        
        ; Mostrar en LCD (Los delimitadores entre cada datos no son visibles)
        IMPRIMIR_LCDDISPLAY datosJugador, posDatosJugador
        CALL LIMPIAR_REGS
        RET
    ENDP
    
    ARCHIVO_DATOS_PARTIDA PROC
        CALL LIMPIAR_REGS
        REEMPLAZAR_CADENA_PARTIDA posDatosPartida, rAgua
        REEMPLAZAR_CADENA_PARTIDA posDatosPartida, rComida
        REEMPLAZAR_CADENA_PARTIDA posDatosPartida, rEnerg
        REEMPLAZAR_CADENA_PARTIDA posDatosPartida, rAvan
        REEMPLAZAR_CADENA_PARTIDA posDatosPartida, rHab
        REEMPLAZAR_CADENA_PARTIDA posDatosPartida, estado
        
        ; 1. Crear la carpeta principal
        CREAR_CARPETA rutaCarpeta
        
        ; 2. Crear archivo "DatosPartida.txt"
        CREAR_ARCHIVO rutaDatosPartida, 32        
        MOV idDatosPartida, AX ; Recuperar id
        
        ; 3. Abrir archivo
        CALL LIMPIAR_REGS
        ABRIR_ARCHIVO rutaDatosPartida, 2
            MOV idDatosPartida, AX
        CALL LIMPIAR_REGS

        ; 4. Escribir en el archivo
        ESCRIBIR_ARCHIVO idDatosPartida, posDatosPartida, datosPartida
        
        ; Mostrar en LCD (Los delimitadores entre cada datos no son visibles)
        IMPRIMIR_LCDDISPLAY datosPartida, posDatosPartida
        CALL LIMPIAR_REGS
        
        RET
    ENDP
    
    
    EXTRAER_DATOS_JUGADOR PROC
        ABRIR_ARCHIVO rutaDatosJugador, 2
        MOV idDatosJugador, AX
        
        LEER_ARCHIVO idDatosJugador, 80, datosJugador

        MOV SI, 0
        MOV DI, 0
        LLENAR_NOMBRE:
            MOV AL, datosJugador[SI]
            CMP AL, 031
                JE LLENAR_EDAD                
            MOV nombre[DI], AL
            INC DI
            INC SI
            JMP LLENAR_NOMBRE
        LLENAR_EDAD:                 
            MOV DI, 0
            INC SI
            CICLO_EDAD:
                MOV AL, datosJugador[SI]
                CMP AL, 031
                    JE LLENAR_NOMJ                
                MOV edad[DI], AL
                INC DI
                INC SI
                JMP CICLO_EDAD
        LLENAR_NOMJ:                 
            MOV DI, 0
            INC SI
            CICLO_NOMJ:
                MOV AL, datosJugador[SI]
                CMP AL, 031
                    JE LLENAR_GENERO                
                MOV nomJug[DI], AL
                INC DI
                INC SI
                JMP CICLO_NOMJ
        LLENAR_GENERO:                 
            MOV DI, 0
            INC SI
            CICLO_GENERO:
                MOV AL, datosJugador[SI]
                CMP AL, 031
                    JE LLENAR_NOMBREF                
                MOV genero[DI], AL
                INC DI
                INC SI
                JMP CICLO_GENERO
        LLENAR_NOMBREF:                 
            MOV DI, 0
            INC SI
            CICLO_NOMBREF:
                MOV AL, datosJugador[SI]
                CMP AL, 031
                    JE FIN_LLENADO_JUGADOR                
                MOV nombRef[DI], AL
                INC DI
                INC SI
                JMP CICLO_NOMBREF                            
        FIN_LLENADO_JUGADOR:    
        RET
    ENDP
    
    EXTRAER_DATOS_PARTIDA PROC
        ABRIR_ARCHIVO rutaDatosPartida, 2
        MOV idDatosPartida, AX
        
        LEER_ARCHIVO idDatosPartida, 80, datosPartida

        MOV SI, 0
        MOV DI, 0
        LLENAR_AGUA:
            MOV AL, datosPartida[SI]
            CMP AL, 031
                JE LLENAR_COMIDA                
            MOV rAgua[DI], AL
            INC DI
            INC SI
            JMP LLENAR_AGUA
        LLENAR_COMIDA:                 
            MOV DI, 0
            INC SI
            CICLO_COMIDA:
                MOV AL, datosPartida[SI]
                CMP AL, 031
                    JE LLENAR_ENERGIA                
                MOV rComida[DI], AL
                INC DI
                INC SI
                JMP CICLO_COMIDA
        LLENAR_ENERGIA:                 
            MOV DI, 0
            INC SI
            CICLO_ENERGIA:
                MOV AL, datosPartida[SI]
                CMP AL, 031
                    JE LLENAR_AVANCE                
                MOV rEnerg[DI], AL
                INC DI
                INC SI
                JMP CICLO_ENERGIA
        LLENAR_AVANCE:                 
            MOV DI, 0
            INC SI
            CICLO_AVANCE:
                MOV AL, datosPartida[SI]
                CMP AL, 031
                    JE LLENAR_HAB                
                MOV rAvan[DI], AL
                INC DI
                INC SI
                JMP CICLO_AVANCE
        LLENAR_HAB:                 
            MOV DI, 0
            INC SI
            CICLO_HAB:
                MOV AL, datosPartida[SI]
                CMP AL, 031
                    JE LLENAR_EDO                
                MOV rHab[DI], AL
                INC DI
                INC SI
                JMP CICLO_HAB
        LLENAR_EDO:                 
            MOV DI, 0
            INC SI
            CICLO_EDO:
                MOV AL, datosPartida[SI]
                CMP AL, 031
                    JE FIN_LLENADO_PARTIDA                
                MOV estado[DI], AL
                INC DI
                INC SI
                JMP CICLO_EDO                                    
        FIN_LLENADO_PARTIDA:    
        RET
    ENDP
           
END