;**********************************
;Pantalla de PERDISTE/MORISTE
;*********************************    
  INCLUDE macrosProyecto.LIB
.MODEL SMALL
.STACK
.DATA                                                                                                                
                                                                                                                                                                                              
                                                                                                
 frase  db '#@@#     *@@#   =*@@@@#+  @@@@@#+   @@  =#@@@#.#@@@@@@@+ @@@@@@-'  ;65  
 frase2 db '@@+@*   +@*@%  *@#.  .%@# @@   @@-  @@  @@.  :     #@+    @@.    '               
 frase3 db '@@:%@: :@%:@% .@@     .@@  @@::-@@   @@  #@@#-.    #@+    @@=--- '               
 frase4 db '@@.:@@.@@ :@% .@@     .@@  @@%%@@.   @@    =%@@=   #@+    @@-::. '               
 frase5 db '@@. +@@@+ :@%  @@#    @@%  @@  .@@   @@      *@@   #@+    @@.    '               
 frase6 db '@@.  @@%  :@%   *@@%%@@:   @@   +@@  @@  @@%@@%.   #@+    @@@@@@--'            
              
    renMenu db 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219                           
    linea DB 80 DUP(219)
    paginaACT DB 0  
    REN DB 0
    msjPantallaPrincipal       db '     SALIR     '
.CODE

INICIO:
    MOV AX,@DATA
    MOV DS,AX
    MOV ES,AX
   
CICLO:

;COLOREAR TO       
       MACRO_PANTALLA linea,80,REN,4
    
    ;LETRAS DE QUE MORISTE   
    IMP_BADEND 4,4,frase,65,40h   
    IMP_BADEND 5,4,frase2,63,40h
    IMP_BADEND 6,4,frase3,63,40h
    IMP_BADEND 7,4,frase4,63,40h
    IMP_BADEND 8,4,frase5,63,40h
    IMP_BADEND 9,4,frase6,65,40h
     
    
     ; Imprime el cuadro central
        IMP_COLOR_CURSOR 14, 28, renMenu, 15, 0H
        IMP_COLOR_CURSOR 15, 28, renMenu, 15, 0H
        IMP_COLOR_CURSOR 16, 28, renMenu, 15, 0H
                                                   
             ; Imprimir opciones
        CALL IMPRIMIROPCIONES_INICIO
        
        MOV REN, 15
        PEDIRTECLA_INICIO:
            CALL IMPRIMIROPCIONES_INICIO                                        
            CURSOR REN, 27            
            MOV BL, REN
            CMP BL, 15
                JE SUBRAYADO1_INICIO                      
                
            SUBRAYADO1_INICIO:
                IMP_COLOR_CURSOR 15, 28, msjPantallaPrincipal, 15, 0F0H
                
           
                                    
        
                     
        RET
    ENDP        
    
    
    IMPRIMIROPCIONES_INICIO PROC
        IMP_COLOR_CURSOR 15, 28, msjPantallaPrincipal, 15, 1EH
        RET
    ENDP                                               


SALIR:
    MOV AX,4C00H
    INT 21H    
    