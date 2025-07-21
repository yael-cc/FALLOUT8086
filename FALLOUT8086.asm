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
    ren     db 0
    col     db 0
    simb    db 0
    rastreo db 0
    idDatosJugador  dw 0
    idDatosPartida  dw 0
    paginaAct   db 0
    largoCad   dw 0
    caracter   db 0    
    esqIzqS db 213
    esqDerS db 184
    rutaDatosProyecto   db 'C:\FALLOUT8086\DatosJugador.txt',0
    msjNomb db ' Nombre:             '
    msjEdad db ' Edad:               '
    msjNomJ db ' Nombre[juego]:      '
    msjGen  db ' Genero[M o F]:      '
    msjRef  db ' Nombre del refugio: '
    msjImp  db 'Presiona ENTER para continuar o E para imprimir.'    
    nombre  db 30 DUP(0)
    edad    db 2 DUP(0)
    nomJug  db 15 DUP(0)
    genero  db 1 DUP(0)
    nombRef db 20 DUP(0)
    datosJugador    db 68 DUP(0)        
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
    rAgua   db '100'
    rComida db '100'
    rEnerg  db '100'
    rAvan   db '  1%'
    rHab    db '100'
    msgEdo  db 'ESTADO: '
    estado  db 'ESTABLE  '
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
    monito  db 10, 13, '                                                                         ',223,223,223,' '
            db 10, 13, '                                                                        ',219,219,' ',219,219
            db 10, 13, '                                                                             '
            db 10, 13, '                                                                        ',219,223,223,223,219
            db 10, 13, '                                                                             '
            db 10, 13, '                                                                         ',223,223,223,' '
            db 0 ; Fin de cadena                           
    ; ================== MACROS ============================
    
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
        PEDIR_CADENA 7, 42, nombre, 30
        PEDIR_CADENA 9, 42, edad, 2
        PEDIR_CADENA 11, 42, nomJug, 15
        PEDIR_CADENA 13, 42, genero, 1
        PEDIR_CADENA 15, 42, nombRef, 20
        
        ; OPCIONES
        IMP_COLOR_CURSOR 18, 10, msjImp, 48, colorNormal
        INICIO_OPCIONES_IMP:
            CURSOR 18, 60, paginaAct
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
           
END