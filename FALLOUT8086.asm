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
    LARGO   db 0
    RENTEMP  db 0
    renMenu db 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219
    msjIniciarPartida   db '    INICIAR    '
    msjIniciarForm      db ' DATOS JUGADOR '
    msjSalirJuego       db '     SALIR     '
    msjCK               db 'Guardado No. '
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
    msjOpcionPrincipal  db 'Selecciona una opci',162,'n: '
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
    rAgua   db '100',0
    tAgua   db 'Agua:'
    rComida db '100',0
    tComida db 'Comida:'
    rEnerg  db '100',0
    tEnerg  db 'Energ',161,'a:'
    rHab    db '100',0
    tHab    db 'Habitantes:'
    rAvan   db '  1%',0
    tAvan   db 'Avance:'                            
    estado  db 'ESTABLE  ',0
    checkpoint db '1', 0
    msgEdo  db 'ESTADO: '
    linea1_CK1  db 'Oh, por fin despiertas jefe, el refugio '
    linea2_CK1  db 'es un caos cuando no hay un lider. Desde'
    linea3_CK1  db 'aquella guerra los recursos son muy va- '
    linea4_CK1  db 'liosos. Desde el agua, energia, todo.   '
    linea5_CK1  db 'Pero ya lo sabes, tu eres el lider aqu',161,'.'
    linea1_CK2  db 'Parece que hay nueva gente que desea en-'
    linea2_CK2  db 'trar al refugio. Toma una decisi',162,'n:     '
    linea3_CK2  db 'A) Deja que entren al refugio.          '
    linea4_CK2  db 'B) Echalos, no sabemos sus intenciones. '
    linea5_CK2  db 'C) Quitales lo que tienen y echalos.    '    
    tReg    db ' REGISTRO DEL SISTEMA '
    reg1    db 16,'     [Primer registro vac',161,'o]      '
    reg2    db 16,'     [Segundo registro vac',161,'o]     '
    reg3    db 16,'     [Tercer registro vac',161,'o]      '
    reg4    db 16,'     [Cuarto registro vac',161,'o]      '
    reg5    db 16,'     [Quinto registro vac',161,'o]      '
    reg6    db 16,'     [Sexto registro vac',161,'o]       '
    regCK2  db 16,'  Iniciaste tu historia, l',161,'der.   '
    regA1   db 35 DUP(?)
    regA2   db 35 DUP(?)
    regA3   db 35 DUP(?)
    regA4   db 35 DUP(?)
    regA5   db 35 DUP(?)
    regA6   db 35 DUP(?)
    segmentos   db 3Fh, 06h, 5Bh, 4Fh, 66h, 6Dh, 7Dh, 07h, 7Fh, 6Fh     
    radiacion   db 0           
    estNorm db 'ESTABLE  ',0   
    estPel  db 'PELIGRO  ',0   
    estMed  db 'INESTABLE',0      
    posDatosJugador dw 0
    posDatosPartida dw 0
    matriz db 01111111b, 00001001b, 00001001b, 00001001b, 00000001b ; 2000h - 2004h
           db 01111110b, 00001001b, 00001001b, 00001001b, 01111110b ; 2005h - 2009h
           db 00111111b, 01000000b, 01000000b, 01000000b, 01000000b ; 200Ah - 200Eh
           db 00111111b, 01000000b, 01000000b, 01000000b, 01000000b ; 200Fh - 2013h
           db 00111110b, 01000001b, 01000001b, 01000001b, 00111110b ; 2014h - 2018h
           db 01111111b, 01000000b, 01000000b, 01000000b, 01111111b ; 2019h - 201Dh
           db 00000001b, 00000001b, 01111111b, 00000001b, 00000001b ; 201Eh - 2022h
           db 00001100b, 00011110b, 00111100b, 00011110b, 00001100b ; 2023h - 2027h
    monte   db 10,13,'            :::::.                                                             '           
        db 10,13,'        -+*#########**+-                          .:::--::.                    '
        db 10,13,'    -*#################**+=:.              :=++***##########*+=:               '
        db 10,13,'    *###########################**********#####################*+=:            '
        db 10,13,'   *###############################################################*+=:        '
        db 10,13,'  ######################################################################*=:    '
        db 10,13,' ########################################################################*=:   '
        db 10,13,'###########################################################################=:  '
        db 10,13,'#############################################################################::'
        db 10,13,'###############################################################################'
        db 10,13,'###############################################################################'
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
        CALL PANTALLA_INICIO                
                                             
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
        ; Mostrar habiantes y energia en devices
        CALL SALIDA_HAB_ENR
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
    
    LLAMAR_FORMULARIO PROC
        ; Cambiamos a la pagina 1    
        MOV paginaAct, 1
        CALL CAMBIAR_PAGINA
        CALL PANTALLA_FORMULARIO
        RET
    ENDP
    
    LLAMAR_PANTALLAJUEGO PROC
        ; Cambia a la pagina 2, a la pantalla principal del juego
        MOV paginaAct, 2
        CALL CAMBIAR_PAGINA
        CALL PANTALLA_JUEGO    
        RET
    ENDP    
    
    PANTALLA_INICIO PROC
        MOV paginaAct, 0
        CALL CAMBIAR_PAGINA
        ; SE LEEN DATOS DEL JUGADOR DESDE EL ARCHIVO (EVIDENCIABLE SOBRE TODO EN NOMBRE DE JUGADOR)
        CALL EXTRAER_DATOS_JUGADOR
        CALL EXTRAER_DATOS_PARTIDA
        
        IMP_COLOR_CURSOR 13, 0, monte, 890, 0AH  ; Imprime el pasto    
        
        ; Coloca parametros previo a poner arboles
        MOV REN, 7
        MOV COL, 10
        MOV LARGO, 16        
        ; Crea el primer arbol 
        CALL ARBOL_COMPLETO
        
        ; Coloca parametros previo a poner arboles
        MOV REN, 9
        MOV COL, 19
        MOV LARGO, 18        
        ; Crea el segundo arbol 
        CALL ARBOL_COMPLETO
        
        ; Coloca parametros previo a poner arboles
        MOV REN, 8
        MOV COL, 26
        MOV LARGO, 19        
        ; Crea el tercer arbol 
        CALL ARBOL_COMPLETO 
        
        ; Coloca parametros previo a poner arboles
        MOV REN, 10
        MOV COL, 45
        MOV LARGO, 18        
        ; Crea el cuarto arbol 
        CALL ARBOL_COMPLETO
        
        ; Coloca parametros previo a poner arboles
        MOV REN, 9
        MOV COL, 53
        MOV LARGO, 17        
        ; Crea el quinto arbol 
        CALL ARBOL_COMPLETO
        
        ; Coloca parametros previo a poner arboles
        MOV REN, 11
        MOV COL, 64
        MOV LARGO, 19        
        ; Crea el sexto arbol 
        CALL ARBOL_COMPLETO    
        
        ; Imprime el cuadro central
        IMP_COLOR_CURSOR 14, 28, renMenu, 15, 09H
        IMP_COLOR_CURSOR 15, 28, renMenu, 15, 09H
        IMP_COLOR_CURSOR 16, 28, renMenu, 15, 09H
        IMP_COLOR_CURSOR 17, 28, renMenu, 15, 09H
        IMP_COLOR_CURSOR 18, 28, renMenu, 15, 09H
        IMP_COLOR_CURSOR 19, 28, renMenu, 15, 09H
        IMP_COLOR_CURSOR 20, 28, renMenu, 15, 09H
        
        ; Imprimir opciones
        CALL IMPRIMIROPCIONES_INICIO
        
        MOV REN, 15
        PEDIRTECLA_INICIO:
            CALL IMPRIMIROPCIONES_INICIO                                        
            CURSOR REN, 27            
            MOV BL, REN
            CMP BL, 15
                JE SUBRAYADO1_INICIO
            CMP BL, 17
                JE SUBRAYADO2_INICIO
            CMP BL, 19    
                JE SUBRAYADO3_INICIO                        
                
            SUBRAYADO1_INICIO:
                IMP_COLOR_CURSOR 15, 28, msjIniciarPartida, 15, 0F0H
                JMP TECLEO_INICIO
            SUBRAYADO2_INICIO:    
                IMP_COLOR_CURSOR 17, 28, msjIniciarForm, 15, 0F0H
                JMP TECLEO_INICIO
            SUBRAYADO3_INICIO:    
                IMP_COLOR_CURSOR 19, 28, msjSalirJuego, 15, 0F0H
                JMP TECLEO_INICIO    
                
        TECLEO_INICIO:        
            RASTREO_TECLA
            MOV AH, RASTREO                        
            CMP AH, 1CH
                JE OPCION_INICIO
            CMP AH, 48H
                JE ARRIBA_INICIO
            CMP AH, 50H
                JE ABAJO_INICIO
            JMP PEDIRTECLA_INICIO                        
        
        ABAJO_INICIO:
            CMP REN, 19
                JE PEDIRTECLA_INICIO            
            INC REN
            INC REN
            JMP PEDIRTECLA_INICIO            
        ARRIBA_INICIO:        
            CMP REN, 15
                JE PEDIRTECLA_INICIO            
            DEC REN
            DEC REN
            JMP PEDIRTECLA_INICIO
            
        OPCION_INICIO:
            MOV AL, REN
            CMP AL, 15
                JE JUEGO
            CMP AL, 17
                JE FORM
            CMP AL, 19
                JE FIN                    
        JUEGO:
            CALL LLAMAR_PANTALLAJUEGO        
        FORM:
            CALL LLAMAR_FORMULARIO              
        RET
    ENDP        
    
    
    IMPRIMIROPCIONES_INICIO PROC
        IMP_COLOR_CURSOR 15, 28, msjIniciarPartida, 15, 1EH
        IMP_COLOR_CURSOR 17, 28, msjIniciarForm, 15, 1EH
        IMP_COLOR_CURSOR 19, 28, msjSalirJuego, 15, 1EH
        RET
    ENDP    
    
    ARBOL_COMPLETO PROC
        MOV AL, REN    
        MOV RENTEMP, AL
        CICLO_TRONCO:
            CURSOR REN, COL
            
            MOV AH,9    ; CARACTER COLOR
            MOV AL,219  ;CARACTER
            MOV BL,08H    ;COLOR
            MOV CX,1    ;VECES 
            MOV BH,paginaAct
            INT 10H
            
            INC REN            ; INCREMENTO EN 1  
            MOV AL, LARGO 
            CMP REN, AL         ; COMPARAR RENGLÓN
                JLE CICLO_TRONCO
                
            DEC COL
            MOV AL, RENTEMP
            MOV LARGO, AL
            MOV REN, AL
            INC REN
            SUB LARGO, 5
           
        CICLO_HOJAS1:
            CURSOR REN, COL
            
            MOV AH,9    ; CARACTER COLOR
            MOV AL,219  ;CARACTER
            MOV BL,02H    ;COLOR
            MOV CX,1    ;VECES 
            MOV BH,paginaAct
            INT 10H
            
            DEC REN            ; DECREMENTO EN 1  
            MOV AL, LARGO 
            CMP REN, AL         ; COMPARAR RENGLÓN
                JGE CICLO_HOJAS1
                
            INC COL
            MOV AL, RENTEMP
            MOV LARGO, AL
            MOV REN, AL
            DEC REN
            SUB LARGO, 5
           
        CICLO_HOJAS2:
            CURSOR REN, COL
            
            MOV AH,9    ; CARACTER COLOR
            MOV AL,219  ;CARACTER
            MOV BL,02H    ;COLOR
            MOV CX,1    ;VECES 
            MOV BH,paginaAct
            INT 10H
            
            DEC REN            ; DECREMENTO EN 1  
            MOV AL, LARGO 
            CMP REN, AL         ; COMPARAR RENGLÓN
                JGE CICLO_HOJAS2                          
            
            INC COL
            MOV AL, RENTEMP
            MOV LARGO, AL
            MOV REN, AL
            INC REN
            SUB LARGO, 5
           
        CICLO_HOJAS3:
            CURSOR REN, COL
            
            MOV AH,9    ; CARACTER COLOR
            MOV AL,219  ;CARACTER
            MOV BL,02H    ;COLOR
            MOV CX,1    ;VECES 
            MOV BH,paginaAct
            INT 10H
            
            DEC REN            ; DECREMENTO EN 1  
            MOV AL, LARGO 
            CMP REN, AL         ; COMPARAR RENGLÓN
                JGE CICLO_HOJAS3                                        
        RET
    ENDP
    
    PANTALLA_JUEGO PROC                                              
        ; Monito
        CALL LIMPIAR_REGS         
        IMP_COLOR_CURSOR 7, 0, monito, 475, 0BH      ; Monito
        
        CALL MARCO_PRINCIPAL
        
        ; Salida en Matrix Device del nombre del juego
        CALL DIBUJAR_MATRIX
        
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
        CALL ACT_RECURSOS   ;Actualizar recursos                                                          
        
        ; BIENVENIDA
        IMP_COLOR_CURSOR 5, 2, msjBienvenida, 11, colorDestacado
        IMP_COLOR_CURSOR 5, 13, nomJug, 15, colorDestacado
        
        ; Estado general
        IMP_COLOR_CURSOR 10, 3, msgEdo, 8, colorDestacado   ; Titulo Estado
        IMP_COLOR_CURSOR 12, 3, estado, 9, colorNormal      ; Estado actual                                           
        
        ; Registros
        CALL LIMPIAR_REGS                                                        
        ESTABLECER_HISTORIAL_ACTUAL reg1, reg2, reg3, reg4, reg5, reg6
        IMP_COLOR_CURSOR 18, 28, tReg, 22, colorNormal   ; TITULO REGISTROS
        
        JMP SALTO_CHECKPOINT        
        CK1:                    
            ; Historia                                          
            MOV largoCad, 40
            IMP_CENTRAL linea1_CK1, linea2_CK1, linea3_CK1, linea4_CK1, linea5_CK1                         
            
            ; Checkpoint
            IMP_COLOR_CURSOR 5, 62, msjCK, 13, colorDestacado
            IMP_COLOR_CURSOR 5, 75, checkpoint, 2, colorDestacado
            
            ; PEDIR OPCION
            ;msjOpcionPrincipal
            IMP_COLOR_CURSOR 16, 28, msjOpcionPrincipal, 23, colorDestacado
            CURSOR 16, 53
            RASTREO_TECLA
            
            MOV AH, RASTREO
            MOV AL, CARACTER
                        
            CMP AH, 01H
                JE VOLVER_INICIO
            CMP AH, 1CH
                JE CK2
                
            JMP CK1                
            
        CK2:
            ; Registros
            RECORRER_HISTORIAL regCK2
            MOV checkpoint, '2'                
            ; Historia                                          
            MOV largoCad, 40
            IMP_CENTRAL linea1_CK2, linea2_CK2, linea3_CK2, linea4_CK2, linea5_CK2 
            
            ; Checkpoint
            IMP_COLOR_CURSOR 5, 62, msjCK, 13, colorDestacado
            IMP_COLOR_CURSOR 5, 75, checkpoint, 2, colorDestacado
            
            ; PEDIR OPCION
            ;msjOpcionPrincipal
            IMP_COLOR_CURSOR 16, 28, msjOpcionPrincipal, 23, colorDestacado
            CURSOR 16, 53
            RASTREO_TECLA
            MOV AH, RASTREO
            MOV AL, CARACTER
                        
            CMP AH, 01H
                JE VOLVER_INICIO
            CMP AL, 'A'
                JE CK3
                
            JMP CK2
            
        CK3:    
             
        RET
    ENDP
    
    
    VOLVER_INICIO:
        CALL LIMPIAR_PANTALLA
        MOV paginaAct, 0
        CALL CAMBIAR_PAGINA
        MOV REN, 15
        JMP PEDIRTECLA_INICIO        
    
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
            JMP VOLVER_INICIO   
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
        JC C_ARC
        
        C_ARC:
        ; 2. Crear archivo "DatosJugador.txt"
        CREAR_ARCHIVO rutaDatosJugador, 32        
        MOV idDatosJugador, AX ; Recuperar id
        JC A_ARC
        
        A_ARC:
        ; 3. Abrir archivo
        CALL LIMPIAR_REGS
        ABRIR_ARCHIVO rutaDatosJugador, 2            
            MOV idDatosJugador, AX
        CALL LIMPIAR_REGS
        
        ; 4. Escribir en el archivo
        ESCRIBIR_ARCHIVO idDatosJugador, posDatosJugador, datosJugador
        
        CERRRAR_ARCHIVO idDatosJugador
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
        REEMPLAZAR_CADENA_PARTIDA posDatosPartida, checkpoint
        
        ; 1. Crear la carpeta principal
        CREAR_CARPETA rutaCarpeta
        JC C_ARC2
        
        C_ARC2:
        ; 2. Crear archivo "DatosPartida.txt"
        CREAR_ARCHIVO rutaDatosPartida, 32        
        MOV idDatosPartida, AX ; Recuperar id
        JC A_ARC2
        
        A_ARC2:
        ; 3. Abrir archivo
        CALL LIMPIAR_REGS
        ABRIR_ARCHIVO rutaDatosPartida, 2
            MOV idDatosPartida, AX
        CALL LIMPIAR_REGS

        ; 4. Escribir en el archivo
        ESCRIBIR_ARCHIVO idDatosPartida, posDatosPartida, datosPartida
        
        CERRRAR_ARCHIVO idDatosPartida
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
            CERRRAR_ARCHIVO idDatosJugador   
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
                    JE LLENAR_CHK                
                MOV estado[DI], AL
                INC DI
                INC SI
                JMP CICLO_EDO
        LLENAR_CHK:                 
            MOV DI, 0
            INC SI
            CICLO_CHK:
                MOV AL, datosPartida[SI]
                CMP AL, 031
                    JE FIN_LLENADO_PARTIDA                
                MOV checkpoint[DI], AL
                INC DI
                INC SI
                JMP CICLO_CHK                                            
        FIN_LLENADO_PARTIDA:
            CERRRAR_ARCHIVO idDatosPartida    
        RET
    ENDP
    
    SALIDA_HAB_ENR PROC    ; Da salida en el BCD de 7 segmentos a Habitantes y Energia
        CALL VACIAR_DISPLAYSEG
        MOV SI, 0
        MOV DX, 2030H
        CICLOHAB_SEG:
            MOV AL, rHab[SI]
            CMP AL, 30H
            JB FINHAB_SEG
            CMP AL, 39H
            JA FINHAB_SEG
            SUB AL, 30H
            MOV BX, 0
            MOV BL, AL
            MOV AL, segmentos[BX]
            OUT DX, AL
            INC SI
            INC DX
            JMP CICLOHAB_SEG
        FINHAB_SEG:
            CALL ENR_DISPLAYSEG
        RET
    ENDP
    
    ENR_DISPLAYSEG PROC
        MOV SI, 0
        MOV DX, 2034H
        CICLOENR_SEG:
            MOV AL, rEnerg[SI]
            CMP AL, 30H
            JB FINENR_SEG
            CMP AL, 39H
            JA FINENR_SEG
            SUB AL, 30H
            MOV BX, 0
            MOV BL, AL
            MOV AL, segmentos[BX]
            OUT DX, AL
            INC SI
            INC DX
            JMP CICLOENR_SEG
        FINENR_SEG:
        RET
    ENDP
    
    VACIAR_DISPLAYSEG PROC    
        MOV DX, 2030H
        MOV SI, 0
        CICLO_VSEG:
            CMP SI, 8
                JE FIN_VSEG
            MOV AL, 0
            OUT DX, AL
            INC DX
            INC SI
            JMP CICLO_VSEG
        FIN_VSEG:
        RET
    ENDP
    
    AUMENTAR_RADIACION PROC   ; Enciende el calefactor del termetro (con el que simulamos radiación
        MOV DX, 127
        MOV AL, 1
        OUT DX, AL
        RET
    ENDP
    
    DETENER_RADIACION PROC    ; Apaga calefactor, simula frenar radiación
        MOV DX, 127
        MOV AL, 0
        OUT DX, AL
        
        MOV DX, 125
        IN AL, DX
        MOV radiacion, AL
        RET
    ENDP
    
    ANALIZAR_RADIACION PROC     ; Analiza la temperatura que queda al apagar (radiación registrada)
        MOV AL, radiacion[0]
        CMP AL, 40 
            JLE RAD_EST
        CMP AL, 100
            JGE RAD_PELIGRO     
        JMP RAD_MED                  
        RAD_EST:
            REEMPLAZAR_CADENA estado, estNorm
            JMP FIN_ANRAD    
        RAD_MED:
            REEMPLAZAR_CADENA estado, estMed
            JMP FIN_ANRAD
        RAD_PELIGRO:        
            REEMPLAZAR_CADENA estado, estPel
        FIN_ANRAD:        
        RET
    ENDP
    
    DIBUJAR_MATRIX PROC
        ; Inicio
    	MOV DX,2000h ; Input columna 1 del display 1
    	MOV BX,0     ; Contador de columnas totales
        display_matrix:
    	MOV SI,0     ; Contador de columnas en matríz
    	MOV CX,5     ; Cada display tiene 5 columnas
        columna_matrix:
    	MOV AL,matriz[BX][SI] ; Matríz de puntos
    	OUT DX,AL           ; Output en columna
    	INC SI              ; Siguiente columna en matríz
    	INC DX              ; Siguiente columna en display 
        ; Si columna actual != 5
    	CMP SI,5       ; Repite ciclo de columnas
    	LOOPNE columna_matrix      
        ; SOLO cuando columna actual = 5                   
    	ADD BX,5       ; Añade 5 a columnas totales
    	CMP BX,40      ; Si columnas totales < 40
    	JL display_matrix     ; Pasa al siguiente display
        
        RET
    ENDP    
    
    SALTO_CHECKPOINT:
        MOV AL, checkpoint
        CMP AL, '1'
            JE CK1
        CMP AL, '2'
            JE CK2
        CMP AL, '3'        
            JE CK3      
           
END