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
    rAgua   db '50',0
    tAgua   db 'Agua:'
    rComida db '50',0
    tComida db 'Comida:'
    rEnerg  db '50',0
    tEnerg  db 'Energ',161,'a:'
    rHab    db '50',0
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
    ;---------------------INICIO CAMBIOS DE PAU-------------------------------    
    ;HISTORIA CK3 A-------------------------------------------
    linea1_CK3_A  db 'Son una familia conformada por un padre,' ;
    linea2_CK3_A  db 'madre y un ni',164,'o, despu',130,'s entran al refu-';34
    linea3_CK3_A  db 'gio, sus niveles de radiaci',162,'son normales'
    linea4_CK3_A  db 'y lo primero que hacen es comer y beber.' 
    linea5_CK3_A  db 'Dejarlos fuera no era una opci',149,'n.       '                                                           
    ;HISTORIA CK3 B--------------------------------------------
    linea1_CK3_B  db 'No tengo tiempo ni recursos para aceptar'
    linea2_CK3_B  db 'm',160,'s gente, no podemos aceptar a         '
    linea3_CK3_B  db 'cualquiera solo porque nos sentimos mal,'
    linea4_CK3_B  db 'aqu',161,' es la supervivencia del mas apto.  '
    linea5_CK3_B  db 'Lamento decir esto, pero deben irse.    '  
    ;HISTORIA CK3 C--------------------------------------------
    linea1_CK3_C  db 'Si creen que unos d',130,'biles cualquiera    '
    linea2_CK3_C  db 'pueden entrar al refugio est',133,'equivocados'
    linea3_CK3_C  db 'Les perdonar',130,' la vida... Por un precio. '
    linea4_CK3_C  db 'Qu',161,'tenles sus proviciones, pueden ser   '
    linea5_CK3_C  db 'de utilidad para nosotros.              '
    ;HISTORIA CK4 PREAMBULO-----------------------------------------------
    linea1_CK4  db 'Wow, ya tomaste tu primera decisi',162,'n, veo'
    linea2_CK4  db 'que ya despertaste bien, recuerda que el'
    linea3_CK4  db 'd',161,'a apenas empieza, tenemos que seguir  '
    linea4_CK4  db 'con la gesti',162,'n del refugio, como lo es  '
    linea5_CK4  db 'la falta de personal de vigilancia.     ';40 
    ;HISTORIAS CK 4 DECISION 2--------------------------------------
     linea1_CK4DEC  db 'Nos estamos quedando sin gente y eso    '
     linea2_CK4DEC  db 'aumenta el peligro. Toma una decisi',162,'n.  '
     linea3_CK4DEC  db 'A)Dejar a la Guardia como est',160,'.         '
     linea4_CK4DEC  db 'B)Anunciar reclutamientos voluntarios.  '
     linea5_CK4DEC  db 'C)Realizar un reclutamiento forzado.    '
    ;HISTORIAS CK 4 A--------------------------------------       ;SE SALTO ESTA PARTE
    linea1_CK4_A  db 'No es necesario reclutar, la Guardia es '
    linea2_CK4_A  db 'fuerte y no se va a derribar debido a la'
    linea3_CK4_A  db 'disminuci',162,'n de unos pocos n',163,'meros.      '
    linea4_CK4_A  db 'Conf',161,'a en mi, si realente hubiera       '
    linea5_CK4_A  db 'un gran peligro, lo dar',161,' a todo.        ' ;40  
    ;HISTORIAS CK 4 B-------------------------------------- 
    linea1_CK4_B  db 'Tal vez si es mejor aumentar la Guardia ';40
    linea2_CK4_B  db 'para prevenir que casos pequeños puedan '
    linea3_CK4_B  db 'subir en peligro. Pero no quiero forzar '
    linea4_CK4_B  db 'a todos, es un trabajo dif',161,'cil, solo    ' ;*****
    linea5_CK4_B  db 'informemos que aceptamos voluntarios.   ' ;40
    ;HISTORIAS CK 4 C--------------------------------------      
    linea1_CK4_C  db 'La Guardia es la protecci',162,'n del refugio '
    linea2_CK4_C  db 'y la gente debe de empezar a apoyar.    '
    linea3_CK4_C  db 'Informa que cada familia debe enlistar a'
    linea4_CK4_C  db 'su primog',130,'nito, hombre o mujer, si se   '
    linea5_CK4_C  db 'reh',163,'san, amen',160,'zalos con sacarlos.       ';40  
    ;HISTORIA CK5 PREAMBULO-----------------------------------------------
    linea1_CK5  db 'Tus deseos son ',162,'rdenes jefe, en usted   '
    linea2_CK5  db 'confiamos, probablemente ya se cans',162,'    '
    linea3_CK5  db 'sin embargo le dimos el puesto de jefe  '
    linea4_CK5  db 'por sus capacidades y ganas de ayudar a '
    linea5_CK5  db 'los diferentes sobrevivientes.          ';40 
    ;HISTORIAS CK 5 DECISION 3--------------------------------------
     linea1_CK5DEC  db 'Nos estamos quedando sin medicamentos...'
     linea2_CK5DEC  db 'Una mujer dice ser herborista,ayudar',160,'   '
     linea3_CK5DEC  db 'a cambio de comida extra.               '
     linea4_CK5DEC  db 'A)Aceptar la oferta.                    '
     linea5_CK5DEC  db 'B)Declinar la oferta                    ';40 
     ;HISTORIAS CK 5 A--------------------------------------      ;;SE SALTO ESTA PARTE Y LA CUARTA DECISION
    linea1_CK5_A  db 'La salud del refugio es primordial, si  '
    linea2_CK5_A  db 'comprobamos que ella puede ayudarnos, el'
    linea3_CK5_A  db 'peso de buscar nuevos medicamentos ser',160,' '
    linea4_CK5_A  db 'menor, acepto, pero hay que asegurarnos '
    linea5_CK5_A  db 'de que no es una charlatana, dile eso.  ' ;40  
    ;HISTORIAS CK 5 B-------------------------------------- 
    linea1_CK5_B  db 'Unas hierbitas no nos ayudar',160,'n.         ';40
    linea2_CK5_B  db 'Dile a la charlatana esa que estafadores'
    linea3_CK5_B  db 'no son bienvenidos en nuestro refugio.  '
    linea4_CK5_B  db 'Si cree que puede engañarnos se equivoca'
    linea5_CK5_B  db 'S',160,'quenla, eso gana por mentir.          ' ;40
    
    ;HISTORIAS CK 5 DECISION 4--------------------------------------
     linea1_CK6DEC  db 'Ya es de noche... Lleg',162,' el momento de   '
     linea2_CK6DEC  db 'patrullar.',168,'Qu',130,' har',160,'esta noche jefe',63,'.     '
     linea3_CK6DEC  db 'A)Hacer guardia sin relevo            '
     linea4_CK6DEC  db 'B)Turnarte con los guardias           '
     linea5_CK6DEC  db 'C)Irte a dormir, que otro haga guardia';40 
     ;HISTORIAS CK 5 A-------------------------------------- 
    linea1_CK6_A  db 'Yo ya he descansado bastante esta tarde,'
    linea2_CK6_A  db 'estoy seguro que varios muchachos se tu-'
    linea3_CK6_A  db 'rnaron para llenar mi lugar. No se preo-'
    linea4_CK6_A  db 'cupen, pueden dejarme este sector para  '
    linea5_CK6_A  db 'patrullar yo solo, ustedes descansen.   ' ;40  
    ;HISTORIAS CK 5 B-------------------------------------- 
    linea1_CK6_B  db 'Me gusta mucho convivir con la Guardia y';40
    linea2_CK6_B  db 'a pesar de que soy el jefe no dejo de   '
    linea3_CK6_B  db 'ser un soldado. Esta noche voy a vigilar'
    linea4_CK6_B  db 'con el equipo de este sector, estaremos '
    linea5_CK6_B  db 'rotando para que descansemos todos.     ' ;40
    ;HISTORIAS CK 5 C--------------------------------------      
    linea1_CK6_C  db 'Soy el jefe y como uno debo de tener un '
    linea2_CK6_C  db 'poco de privilegios extra. Todas estas  '
    linea3_CK6_C  db 'decisiones me tienen cansado, la Guardia'
    linea4_CK6_C  db 'puede arreglarse sola, yo quiero volver '
    linea5_CK6_C  db 'a mi cama y darme una buena siesta.     ';40
    
    ;HISTORIAS DIA 2 ------------EL TEMA ES DEL MEDIO AMBIENTE 
    ;HISTORIA DIA 2 PREAMBULO-----------------------------------------------
    linea1_CK77  db 'Con un nuevo amanecer viene una nueva   '
    linea2_CK77  db 'oportunidad de hacer las cosas bien, lo '
    linea3_CK77  db 'mejor es dar una vuelta por el refugio, '
    linea4_CK77  db 'muy probablemente alguien me necesita   '
    linea5_CK77  db 'para tomar una decisi',162,'n importante.     ';40 
    ;HISTORIAS CK 4 DECISION 1--------------------------------------
     linea1_CK7DEC  db 'Jefe, es bueno  verle, en la exploraci',162,'n'
     linea2_CK7DEC  db 'de hoy ecnontramos un vivero, parece no '
     linea3_CK7DEC  db 'ser afectado por la contaminaci',162,'n.      '
     linea4_CK7DEC  db 'A)Explorar el vivero para recursos      '
     linea5_CK7DEC  db 'B)Dejar el vivero abandonado a su suerte';40
    ;HISTORIAS CK 4 A-------------------------------------- 
    linea1_CK7_A  db 'Si comprobamos que el vivero est',160,' libre '
    linea2_CK7_A  db 'de radiaci',162,'n puede convertirse en una  '
    linea3_CK7_A  db 'nueva fuente de comida segura, hecho de '
    linea4_CK7_A  db 'menos las frutas y verduras frescas, la '
    linea5_CK7_A  db 'naturaleza no est',160,' perdida del todo.    ' ;40  
    ;HISTORIAS CK 4 B-------------------------------------- 
    linea1_CK7_B  db 'S',162,'lo los tontos pueden creer que  un vi-';40
    linea2_CK7_B  db 'vero en buen estado es un milagro, cuan-'
    linea3_CK7_B  db 'do claramente es una trampa de otrs gru-'
    linea4_CK7_B  db 'pos, la naturaleza est',160,' perdida del todo'
    linea5_CK7_B  db 'no podemos salvarla ya.                 ' ;40   
    
    ;HISTORIAS CK 4 DECISION 2--------------------------------------
     linea1_CK8DEC  db 'Nuestro equipo de investigadores recre',162,' '
     linea2_CK8DEC  db 'una fuente de nueva energ',161,'a limpia.     '
     linea3_CK8DEC  db 'A)Postura a favor                         '
     linea4_CK8DEC  db 'B)Postura en contra                       '
     linea5_CK8DEC  db 'C)Postura Neutral                         ';40
    ;HISTORIAS CK 4 A-------------------------------------- 
    linea1_CK8_A  db 'Conseguir crear y recrear fuentes de en-'
    linea2_CK8_A  db 'erg',161,'a limpia ayuda al refugio y ayuda a '
    linea3_CK8_A  db 'que desastres como el que pasamos no vu-'
    linea4_CK8_A  db 'elvan a sucedes, dile al equipo que tie-'
    linea5_CK8_A  db 'ne todo mi apoyo con el proyecto.       ' ;40  
    ;HISTORIAS CK 4 B-------------------------------------- 
    linea1_CK8_B  db 'La energ',161,'a nunca ser',160,' como antes, pens-';40
    linea2_CK8_B  db ,160,'bamos que era, nuestro mundo ya no pued'
    linea3_CK8_B  db 'de ser salvado y debemos vivir con los '
    linea4_CK8_B  db 'pedazos que nos quedan. Paren ese tonto '
    linea5_CK8_B  db 'proyecto, solo gastan recursos.         ' ;40
    ;HISTORIAS CK 4 C--------------------------------------      
    linea1_CK8_C  db 'Quiero creer que esa es una buena notic-'
    linea2_CK8_C  db 'ia, sin embargo no soy el m',160,'s capacitado'
    linea3_CK8_C  db 'para dictarlo, puede que el proyecto sea'
    linea4_CK8_C  db 'una buena idea, tendremos que dejarlo a '
    linea5_CK8_C  db 'la votaci',162,'n de todos en el refugio.     ';40 
    
    ;HISTORIAS CK 4 DECISION 3--------------------------------------
     linea1_CK9DEC  db 'Por primera vez se cre',162,' una manera de   '
     linea2_CK9DEC  db 'descontaminar la tierra, se han hecho v-'
     linea3_CK9DEC  db 'arias pruebas pero hace falta hacer m',160,'s.'
     linea4_CK9DEC  db 'A)Apoyar el plan del laboratorio.         '
     linea5_CK9DEC  db 'B)No apoyar el pln del laboratorio.       ';40
    ;HISTORIAS CK 4 A-------------------------------------- 
    linea1_CK9_A  db 'De esa forma podemos empezar a limpiar  '
    linea2_CK9_A  db 'los alrededores del refugio, salir del  '
    linea3_CK9_A  db 'refugio subterr',160,'neo y volver poco a poco'
    linea4_CK9_A  db 'a la normalidad, ahora siendo mucho m',160,'s '
    linea5_CK9_A  db 'cuidadosos con el medio ambiente.       ' ;40  
    ;HISTORIAS CK 4 B-------------------------------------- 
    linea1_CK9_B  db 'De nuevo investigaciones que lo ',163,'nico q-';40
    linea2_CK9_B  db 'ue hacen es gastar nuestros pocos recur-'
    linea3_CK9_B  db 'sos en ideas irreales, nunca saldremos  '
    linea4_CK9_B  db 'del subterraneo, nuestra vida es bajo t-'
    linea5_CK9_B  db 'ierra abandonen la esperanza de una vez.' ;40 
    
    ;HISTORIAS CIERRE DEL DIA-------------------------------------- 
    linea1_CK9_N  db 'Ya lleg',162,' el d',161,'a a su fin, estoy  muy ca-';40
    linea2_CK9_N  db 'sado, mis decisiones han cambiado el cu-'
    linea3_CK9_N  db 'rso del refugio y estoy orgulloso de mis'
    linea4_CK9_N  db 'de ello, hoy har',130,' turno con los otros   ' 
    linea5_CK9_N  db 'guardias para patrullar el refugio.     ' ;40

     ;HISTORIAS DIA 3  -------------------TEMA MANEJO DE RECURSOS----------------
    ;HISTORIA DIA 3 PREAMBULO-----------------------------------------------
    linea1_CK10 db 'La guardia de ayer fue pesada pero me ha'
    linea2_CK10 db 'dado una nueva visi',162,'n de la situaci',162,'n en'
    linea3_CK10 db 'la que se encuentra el refugio, rot',130,' con'
    linea4_CK10 db 'guardias de otros sectores y me han hab-'
    linea5_CK10 db 'lado de la falta de alimento que hay.   ';40 
    ;HISTORIAS CK 4 DECISION 1--------------------------------------
     linea1_CK10DEC  db 'He escuchado a otros organizarse para   '
     linea2_CK10DEC  db 'hoy realizar un robo a los viveres.     '
     linea3_CK10DEC  db 'A)Hacer de la vista gorda.              '
     linea4_CK10DEC  db 'B)Impedir el robo.                      '
     linea5_CK10DEC  db 'C)Unirse al robo de los guardias.       ';40
    ;HISTORIAS CK 4 A-------------------------------------- 
    linea1_CK10_A  db 'Ellos sn mis hermanos de guardia, para  '
    linea2_CK10_A  db 'algunos ser',160,' ego',161,'sta pero creo que ellos'
    linea3_CK10_A  db 'merecen esa comida extra,no puedo ni qu-'
    linea4_CK10_A  db 'ero neg',160,'rselas. Creo que lo mejor ser',160,'  '
    linea5_CK10_A  db 'hacer como que ayer no escuch',130,' nada.    ' ;40  
    ;HISTORIAS CK 4 B-------------------------------------- 
    linea1_CK10_B  db 'Aunque la Guardia realiza una tarea muy ';40
    linea2_CK10_B  db 'importante todos los ciudadanos del ref-'
    linea3_CK10_B  db 'ugio tienen el mismo valor, no podemos  '
    linea4_CK10_B  db 'dar preferencias en estos tiempos, tengo'
    linea5_CK10_B  db 'que impedir ese robo a toda costa.      ' ;40
    ;HISTORIAS CK 4 C--------------------------------------      
    linea1_CK10_C  db 'Estoy de acuerdo con los guardias: quie-'
    linea2_CK10_C  db 'nes estamos en puestos de autoridad mer-'
    linea3_CK10_C  db 'ecemos m',160,'s que los dem',160,'s del refugio, no'
    linea4_CK10_C  db 'quiero limitar mis raciones, ayudar',130,' a  '
    linea5_CK10_C  db 'los guardias con el robo a los viveres. ';40  
    
    ;HISTORIAS CK 4 DECISION 2--------------------------------------
     linea1_CK11DEC  db 'El ultimo jefe de misi',162,'n es corrupto con'
     linea2_CK11DEC  db 'los recursos, me ruega no quitarle el p-'
     linea3_CK11DEC  db 'uesto a cambio de un soborno.           '
     linea4_CK11DEC  db 'A)Aceptar los recursos no declarados.   '
     linea5_CK11DEC  db 'B)Exponerlo ante el refugio.            ';40
    ;HISTORIAS CK 4 A-------------------------------------- 
    linea1_CK11_A  db 'No estar',161,'a mal tener m',160,'s agua y comida  '
    linea2_CK11_A  db 'en un lugar solo para m',161,', a cambio de s-'
    linea3_CK11_A  db 'eguir tray',130,'ndome recursos a escondidas, '
    linea4_CK11_A  db 'dejo que el oficial corrupto conserve su'
    linea5_CK11_A  db 'puesto, espero no ser descubierto.      ' ;40  
    ;HISTORIAS CK 4 B-------------------------------------- 
    linea1_CK11_B  db 'Esconder recursos del exterior que son  ';40
    linea2_CK11_B  db 'primordiales para el dato es un crimen  '
    linea3_CK11_B  db 'que no tiene perd',162,'n, su soborno me indi-'
    linea4_CK11_B  db 'gna, lo mejor es exponerlo y que el ref-'
    linea5_CK11_B  db 'ugio decida su destino: la expulsi',162,'n.   ' ;40
    
    ;HISTORIAS CK 4 DECISION 3--------------------------------------
     linea1_CK12DEC  db 'Debido a a la falta de cuidado hubo una '
     linea2_CK12DEC  db 'fuga en la reserva de agua, el refugio  '
     linea3_CK12DEC  db 'pide un castigo para el encargado.      '
     linea4_CK12DEC  db 'A)Castigar al encargado de la reserva.  '
     linea5_CK12DEC  db 'B)Perdonar al encargado de la reserva.  ';40
    ;HISTORIAS CK 4 A-------------------------------------- 
    linea1_CK12_A  db 'Un recurso tan escaso el agua tiene que '
    linea2_CK12_A  db 'ser cuidado como el oro, no podemos dej-'
    linea3_CK12_A  db 'ar este crimen impune, si bien no merece'
    linea4_CK12_A  db 'el exilio si una sanci',162,'n alta, deber',160,' r-'
    linea5_CK12_A  db 'enunciar a su mitad de raci',162,'n de agua.  ' ;40  
    ;HISTORIAS CK 4 B-------------------------------------- 
    linea1_CK12_B  db 'Fue un pequeño error, no merece ser cas-';40
    linea2_CK12_B  db 'tigado por tan leve descuido, no debemos'
    linea3_CK12_B  db 'dejar atr',160,'s nuestra humanindad, ser',160,' pe-'
    linea4_CK12_B  db 'rdonado, pero no podr',160,' volver a ejercer '
    linea5_CK12_B  db 'ning',163,'n puesto importante en el refugio. ' ;40
   ;-----------------------FIN  DE CAMBIOS DE PAU -----------------------------------------
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
    frase  db '#@@#     *@@#   =*@@@@#+  @@@@@#+   @@  =#@@@#.#@@@@@@@+ @@@@@@-'  ;65  
    frase2 db '@@+@*   +@*@%  *@#.  .%@# @@   @@-  @@  @@.  :     #@+    @@.    '               
    frase3 db '@@:%@: :@%:@% .@@     .@@  @@::-@@   @@  #@@#-.    #@+    @@=--- '               
    frase4 db '@@.:@@.@@ :@% .@@     .@@  @@%%@@.   @@    =%@@=   #@+    @@-::. '               
    frase5 db '@@. +@@@+ :@%  @@#    @@%  @@  .@@   @@      *@@   #@+    @@.    '               
    frase6 db '@@.  @@%  :@%   *@@%%@@:   @@   +@@  @@  @@%@@%.   #@+    @@@@@@--'                                                     
    linea DB 80 DUP(219)   
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
        ; Mostrar habitantes y energia en devices
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
    
    LLAMAR_MUERTE PROC
        ; Cambiamos a la pagina 1    
        MOV paginaAct, 3
        CALL CAMBIAR_PAGINA
        CALL PANTALLA_MUERTE
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
        ;------------------------EMPIEZAN CAMBIOS DE PAU----------------------------
        CK1:        
            MOV checkpoint, '1'
            ; Historia                                          
            MOV largoCad, 40
            IMP_CENTRAL linea1_CK1, linea2_CK1, linea3_CK1, linea4_CK1, linea5_CK1 
            
            ; Registros
            CALL LIMPIAR_REGS        
            IMP_COLOR_CURSOR 18, 28, tReg, 22, colorNormal   ; TITULO REGISTROS                                    
            ESTABLECER_HISTORIAL_ACTUAL reg1, reg2, reg3, reg4, reg5, reg6
            
            ; PEDIR OPCION
            ;msjOpcionPrincipal
            IMP_COLOR_CURSOR 16, 28, msjOpcionPrincipal, 23, colorDestacado
            CURSOR 16, 53
            RASTREO_TECLA
            RECORRER_HISTORIAL regCK2
            MOV AH, RASTREO
            MOV AL, CARACTER
                        
            CMP AH, 01H
                JE VOLVER_INICIO
            CMP AH, 1CH
                JE CK2
                
            JMP CK1                
            
        CK2: ;-----------------------OPCIONES DE YAEL, DEJAR ENTRAR A LA GENTE ----------------               
            MOV checkpoint, '1'
            ; Historia DECISION                                         
            MOV largoCad, 40
            IMP_CENTRAL linea1_CK2, linea2_CK2, linea3_CK2, linea4_CK2, linea5_CK2 

            ; PEDIR OPCION
            ;msjOpcionPrincipal
            IMP_COLOR_CURSOR 16, 28, msjOpcionPrincipal, 23, colorDestacado
            CURSOR 16, 53
            CALL AUMENTAR_RADIACION ; Si tarda mucho en decidir aumenta la radiación
            RASTREO_TECLA
            CALL DETENER_RADIACION  ; Detiene el aumento
            CALL ANALIZAR_RADIACION ; Analiza nivel de radiación
            
            MOV AH, RASTREO
            MOV AL, CARACTER
                 ;Primeras 4 opciones, LLEVAN A DONDE MISMO PERO LOS DIALOGOS SON DIFERENTES       
            CMP AH, 01H
                JE VOLVER_INICIO
            CMP AL, 'A'
                JE CK3
            CMP AL, 'B'
                JE CK4
            CMP AL, 'C'
                JE CK5    
            JMP CK2
          
          ;PRIMERA DECISION  
        CK3:  ; Historia                                          
            MOV checkpoint, '2'
            MOV largoCad, 40
            IMP_CENTRAL linea1_CK3_A, linea2_CK3_A, linea3_CK3_A, linea4_CK3_A, linea5_CK3_A 
            CURSOR 16, 53
            CALL AUMENTAR_RADIACION ; Si tarda mucho en decidir aumenta la radiación
            RASTREO_TECLA
            CALL DETENER_RADIACION  ; Detiene el aumento
            CALL ANALIZAR_RADIACION ; Analiza nivel de radiación
               
            ;SUMA 3 A HABITANTES, RESTA 5  AGUA Y COMIDA 
            SUMAR_RECURSO rHab, 3
            RESTAR_RECURSO rAgua, 5
            RESTAR_RECURSO rComida, 5 
            CALL ACT_RECURSOS
            MOV AH, RASTREO
            MOV AL, CARACTER
         
            CMP AH, 01H
                JE VOLVER_INICIO
            CMP AH, 1CH
                JE D1P2
             
        
        CK4:  ; Historia      
             MOV largoCad, 40
            IMP_CENTRAL linea1_CK3_B, linea2_CK3_B, linea3_CK3_B, linea4_CK3_B,linea5_CK3_B  
            CURSOR 16, 53
            RASTREO_TECLA  
            ;RESTA 2 A HABITANTES
            RESTAR_RECURSO rHab, 2
            CALL ACT_RECURSOS 
            MOV AH, RASTREO
            MOV AL, CARACTER
            CMP AH, 01H
                JE VOLVER_INICIO
            CMP AH, 1CH
                JE D1P2 
          
        
        CK5:; Historia        
            MOV largoCad, 40
            IMP_CENTRAL linea1_CK3_C, linea2_CK3_C, linea3_CK3_C, linea4_CK3_C, linea5_CK3_C  
            CURSOR 16, 53
            RASTREO_TECLA 
            ;RESTA 3 A HABITANTES
            RESTAR_RECURSO rHab, 3
            CALL ACT_RECURSOS 
            MOV AH, RASTREO
            MOV AL, CARACTER    
                CMP AH, 01H
                JE VOLVER_INICIO
                CMP AH, 1CH
                JE D1P2
            ;DIA1PREAMBULO2
            
        D1P2:   ;DIA UNO PREAMBULO 2
         ; Historia   PREAMBULO                                         
            MOV largoCad, 40
            IMP_CENTRAL linea1_CK4, linea2_CK4, linea3_CK4, linea4_CK4, linea5_CK4 
            
             ; PEDIR OPCION
            IMP_COLOR_CURSOR 16, 28, msjOpcionPrincipal, 23, colorDestacado
            CURSOR 16, 53
            RASTREO_TECLA
            MOV AH, RASTREO
            MOV AL, CARACTER
                        
            CMP AH, 01H
                JE VOLVER_INICIO
            CMP AH, 1CH
                JE D1D2  ;DIA1DECISION2
                
            JMP D1D2     
    
            D1D2: ;HISTORIA DECISION  DIA1 DECISION 2  
            ;-------------------------AUMENTAR LA GUARDIA---------------------            
            MOV checkpoint, '3'
            MOV largoCad, 40
            IMP_CENTRAL linea1_CK4DEC, linea2_CK4DEC, linea3_CK4DEC, linea4_CK4DEC, linea5_CK4DEC
            ; PEDIR OPCION                                                        
            
            IMP_COLOR_CURSOR 16, 28, msjOpcionPrincipal, 23, colorDestacado
            CURSOR 16, 53
            CALL AUMENTAR_RADIACION ; Si tarda mucho en decidir aumenta la radiación
            RASTREO_TECLA
            CALL DETENER_RADIACION  ; Detiene el aumento
            CALL ANALIZAR_RADIACION ; Analiza nivel de radiación
            
            MOV AH, RASTREO
            MOV AL, CARACTER
                 ;Primeras 4 opciones, LLEVAN A DONDE MISMO PERO LOS DIALOGOS SON DIFERENTES       
            CMP AH, 01H
                JE VOLVER_INICIO
            CMP AL, 'A'
                JE D2CK3
            CMP AL, 'B'
                JE D2CK4
            CMP AL, 'C'
                JE D2CK5    
            JMP D1D2  
         ;HISTORIA DECISION  
         
         D2CK3: ;HISTORIA DECISION A  ---------- DJARLA ASI
            MOV largoCad, 40
            IMP_CENTRAL linea1_CK4_A, linea2_CK4_A, linea3_CK4_A, linea4_CK4_A, linea5_CK4_A  
            CURSOR 16, 53
            RASTREO_TECLA
            MOV AH, RASTREO
            MOV AL, CARACTER
                CMP AH, 1CH
                JE D1P3 
                JMP D1P3 
            ;SE QUEDA IGUAL
            
         D2CK4: ;HISTORIA DECISION B -------------- RECLUTAMIENTO VOLUNTARIO   
            MOV largoCad, 40
            IMP_CENTRAL linea1_CK4_B, linea2_CK4_B, linea3_CK4_B, linea4_CK4_B, linea5_CK4_B 
            CURSOR 16, 53
            RASTREO_TECLA 
            MOV AH, RASTREO
            MOV AL, CARACTER
                CMP AH, 1CH
                JE D1P3 
                JMP D1P3 
            ;SE QUEDA IGUAL
         
         D2CK5:    
                ;HISTORIA DECISION C ----------------- RECLUTAMIENTO FORZOSO -----------
            MOV largoCad, 40
            IMP_CENTRAL linea1_CK4_C, linea2_CK4_C, linea3_CK4_C, linea4_CK4_C, linea5_CK4_C 
             CURSOR 16, 53
            RASTREO_TECLA
            ;RESTA 5 A HABITANTES
            RESTAR_RECURSO rHab, 5
            CALL ACT_RECURSOS
            MOV AH, RASTREO
            MOV AL, CARACTER
                CMP AH, 1CH
                JE D1P3             
            JMP D1P3 
         
         D1P3:
            ; Historia   PREAMBULO                                         
            MOV largoCad, 40
            IMP_CENTRAL linea1_CK5, linea2_CK5, linea3_CK5, linea4_CK5, linea5_CK5 
            
             ; PEDIR OPCION
            IMP_COLOR_CURSOR 16, 28, msjOpcionPrincipal, 23, colorDestacado
            CURSOR 16, 53
            RASTREO_TECLA
            MOV AH, RASTREO
            MOV AL, CARACTER
                        
            CMP AH, 01H
                JE VOLVER_INICIO
            CMP AH, 1CH
                JE D1D3  ;DIA1DECISION3
                
            JMP D1D3 
            
            D1D3:    ;DIA UNO DECISION 3 --------------- LA HERBORISTA --------------------------
                MOV checkpoint, '4'
                MOV largoCad, 40
                IMP_CENTRAL linea1_CK5DEC, linea2_CK5DEC, linea3_CK5DEC, linea4_CK5DEC, linea5_CK5DEC
                ; PEDIR OPCION                                                        
                
                IMP_COLOR_CURSOR 16, 28, msjOpcionPrincipal, 23, colorDestacado
                CURSOR 16, 53
                CALL AUMENTAR_RADIACION ; Si tarda mucho en decidir aumenta la radiación
                RASTREO_TECLA
                CALL DETENER_RADIACION  ; Detiene el aumento
                CALL ANALIZAR_RADIACION ; Analiza nivel de radiación

                MOV AH, RASTREO
                MOV AL, CARACTER
                     ;Primeras 4 opciones, LLEVAN A DONDE MISMO PERO LOS DIALOGOS SON DIFERENTES       
                CMP AH, 01H
                    JE VOLVER_INICIO
                CMP AL, 'A'
                    JE D1CKA
                CMP AL, 'B'
                    JE D1CKB   
                JMP D1D3 
             
             D1CKA: ;HISTORIA DECISION A ---------------- ACEPTAR TRATO
                MOV largoCad, 40
                IMP_CENTRAL linea1_CK5_A, linea2_CK5_A, linea3_CK5_A, linea4_CK5_A, linea5_CK5_A 
                CURSOR 16, 53
                RASTREO_TECLA
                ; RESTA 5 A COMIDA
                RESTAR_RECURSO rComida, 5
                CALL ACT_RECURSOS 
                MOV AH, RASTREO
                MOV AL, CARACTER
                CMP AH, 1CH
                JE D1D4                 
                JMP D1D4
             
             D1CKB:;HISTORIA DECISION B ----------------- NO ACEPTAR
                 MOV largoCad, 40
                IMP_CENTRAL linea1_CK5_B, linea2_CK5_B, linea3_CK5_B, linea4_CK5_B, linea5_CK5_B 
                CURSOR 16, 53
                RASTREO_TECLA 
                ;RESTA 5 A HABITANTES
                RESTAR_RECURSO rHab, 5
                CALL ACT_RECURSOS
                MOV AH, RASTREO
                MOV AL, CARACTER
                CMP AH, 1CH
                JE D1D4
                JMP D1D4 
                 
                 ;---------------------DECISION 4 DEL DIA 1 -------------------------------------
                 
                 
             D1D4:    ;DIA UNO DECISION 3 --------------- PATRULLAR --------------------------
                MOV checkpoint, '5'
                MOV largoCad, 40
                IMP_CENTRAL linea1_CK6DEC, linea2_CK6DEC, linea3_CK6DEC, linea4_CK6DEC, linea5_CK6DEC
                ; PEDIR OPCION                                                        
                
                IMP_COLOR_CURSOR 16, 28, msjOpcionPrincipal, 23, colorDestacado
                CURSOR 16, 53
                CALL AUMENTAR_RADIACION ; Si tarda mucho en decidir aumenta la radiación
                RASTREO_TECLA
                CALL DETENER_RADIACION  ; Detiene el aumento
                CALL ANALIZAR_RADIACION ; Analiza nivel de radiación

                MOV AH, RASTREO
                MOV AL, CARACTER
                     ;Primeras 4 opciones, LLEVAN A DONDE MISMO PERO LOS DIALOGOS SON DIFERENTES       
                CMP AH, 01H
                    JE VOLVER_INICIO
                CMP AL, 'A'
                    JE CK6A
                CMP AL, 'B'
                    JE CK6B
               CMP AL, 'C'
                    JE CK6C    
                JMP D1D4 
             
             CK6A: ;HISTORIA DECISION A  ----------------- IR SOLO
                MOV largoCad, 40
                IMP_CENTRAL linea1_CK6_A, linea2_CK6_A, linea3_CK6_A, linea4_CK6_A, linea5_CK6_A 
                CURSOR 16, 53
                RASTREO_TECLA
                ;SUMA 5 A COMIDA Y AGUA
                SUMAR_RECURSO rComida, 5
                SUMAR_RECURSO rAgua, 5
                CALL ACT_RECURSOS 
                MOV AH, RASTREO
                MOV AL, CARACTER
                CMP AH, 1CH
                JE D2P1                 
                JMP D2P1 ;DIA2 PREAMBULO 1
             
             CK6B:;HISTORIA DECISION B  -------------------- TURNOS
                 MOV largoCad, 40
                IMP_CENTRAL linea1_CK6_B, linea2_CK6_B, linea3_CK6_B, linea4_CK6_B, linea5_CK6_B 
                CURSOR 16, 53
                RASTREO_TECLA 
                MOV AH, RASTREO
                MOV AL, CARACTER
                CMP AH, 1CH
                JE D2P1
                 JMP D2P1 ;DEJALO IGUAL 
                 
                 
           CK6C:;HISTORIA DECISION B  ------------------- DUERMETE
                 MOV largoCad, 40
                IMP_CENTRAL linea1_CK6_C, linea2_CK6_C, linea3_CK6_C, linea4_CK6_C, linea5_CK6_C 
                CURSOR 16, 53
                RASTREO_TECLA 
                ;RESTALE 5 A AGUA Y COMIDA
                RESTAR_RECURSO rAgua, 5
                RESTAR_RECURSO rComida, 5
                CALL ACT_RECURSOS
                MOV AH, RASTREO
                MOV AL, CARACTER
                CMP AH, 1CH
                JE D2P1
                 JMP D2P1                                   

                ;----------------------------------FIN DIA 1 -----------------------------
                ;----------------------------------INICIO CHECKPOINT 2--------------------            
           D2P1:
            ; Historia DIA2  PREAMBULO 1                                        
            MOV largoCad, 40
            IMP_CENTRAL linea1_CK77, linea2_CK77, linea3_CK77, linea4_CK77, linea5_CK77 
            
            ; PEDIR OPCION
            IMP_COLOR_CURSOR 16, 28, msjOpcionPrincipal, 23, colorDestacado
            CURSOR 16, 53
            RASTREO_TECLA
            RECORRER_HISTORIAL regCK2
            MOV AH, RASTREO
            MOV AL, CARACTER
                        
            CMP AH, 01H
                JE VOLVER_INICIO
            CMP AH, 1CH
                JE D2D1  ;DIA2DECISION1
                
            JMP D2D1
            
            D2D1: ;HISTORIA DIA 2 DECISION 1------------------ VIVERO
                MOV checkpoint, '6'
                MOV largoCad, 40
                IMP_CENTRAL linea1_CK7DEC, linea2_CK7DEC, linea3_CK7DEC, linea4_CK7DEC, linea5_CK7DEC
                ; PEDIR OPCION                                                        
                
                IMP_COLOR_CURSOR 16, 28, msjOpcionPrincipal, 23, colorDestacado
                CURSOR 16, 53
                CALL AUMENTAR_RADIACION ; Si tarda mucho en decidir aumenta la radiación
                RASTREO_TECLA
                CALL DETENER_RADIACION  ; Detiene el aumento
                CALL ANALIZAR_RADIACION ; Analiza nivel de radiación

                MOV AH, RASTREO
                MOV AL, CARACTER
                     
                CMP AH, 01H
                    JE VOLVER_INICIO
                CMP AL, 'A'
                    JE D2CK7A
                CMP AL, 'B'
                    JE D2CK7B 
                JMP D2D1 
              
              D2CK7A: ;HISTORIA DECISION A   -------------- EXPLORAR VIVERO
                MOV largoCad, 40
                IMP_CENTRAL linea1_CK7_A, linea2_CK7_A, linea3_CK7_A, linea4_CK7_A, linea5_CK7_A  
                CURSOR 16, 53
                RASTREO_TECLA 
                ;SUMA 15 COMIDA Y RESTA 5 A AGUA
                SUMAR_RECURSO rComida, 15
                RESTAR_RECURSO rAgua, 5
                CALL ACT_RECURSOS
                
                MOV AH, RASTREO
                MOV AL, CARACTER
                CMP AH, 1CH
                JE D2DEC2
                
                JMP D2DEC2 ;DIA2 DECISION 2 (NO HAY PREAMBULO)
              
              D2CK7B:;HISTORIA DECISION B ------------------------------ ALV VIVERO
                MOV largoCad, 40
                IMP_CENTRAL linea1_CK7_B, linea2_CK7_B, linea3_CK7_B, linea4_CK7_B, linea5_CK7_B 
                CURSOR 16, 53
                RASTREO_TECLA 
                ;RESTA 1 HABITANTES
                RESTAR_RECURSO rHab, 1
                CALL ACT_RECURSOS
                
                MOV AH, RASTREO
                MOV AL, CARACTER
                CMP AH, 1CH
                JE D2DEC2                
                JMP D2DEC2 ;DIA2 DECISION 2 (NO HAY PREAMBULO) 
                
                   
                ;HISTORIA ------------------------- ENERGIA LIMPIA-----------
                D2DEC2: ;DIA 2, DECISION 2, NO PREAMBULO PORQUE SON MUCHAS LINEAS YA OYE
                    MOV checkpoint, '7'
                    MOV largoCad, 40
                    IMP_CENTRAL linea1_CK8DEC, linea2_CK8DEC, linea3_CK8DEC, linea4_CK8DEC, linea5_CK8DEC
                    ; PEDIR OPCION                                                        
                    
                    IMP_COLOR_CURSOR 16, 28, msjOpcionPrincipal, 23, colorDestacado
                    CURSOR 16, 53                    
                    CALL AUMENTAR_RADIACION ; Si tarda mucho en decidir aumenta la radiación
                    RASTREO_TECLA
                    CALL DETENER_RADIACION  ; Detiene el aumento
                    CALL ANALIZAR_RADIACION ; Analiza nivel de radiación
                    
                    MOV AH, RASTREO
                    MOV AL, CARACTER
                                
                    CMP AH, 01H
                        JE VOLVER_INICIO
                    CMP AL, 'A'
                        JE D2CK8A
                    CMP AL, 'B'
                        JE D2CK8B 
                    CMP AL, 'C'
                        JE D2CK8C 
                    JMP D2DEC2 
                  
                  D2CK8A: ;HISTORIA DECISION A---------- A FAVOR
                    MOV largoCad, 40
                    IMP_CENTRAL linea1_CK8_A, linea2_CK8_A, linea3_CK8_A, linea4_CK8_A, linea5_CK8_A 
                     CURSOR 16, 53
                     RASTREO_TECLA 
                     ;SUMA 5 A AGUA Y COMIDA
                     SUMAR_RECURSO rAgua, 5
                     SUMAR_RECURSO rComida, 5
                     CALL ACT_RECURSOS
                      
                     MOV AH, RASTREO
                     MOV AL, CARACTER
                     CMP AH, 1CH
                         JE D2DEC3
                    
                    JMP D2DEC3 ;DIA2 DECISION 3 (NO HAY PREAMBULO)
                  
                  D2CK8B:;HISTORIA DECISION B  --------------- EN CONTRA
                    MOV largoCad, 40
                    IMP_CENTRAL linea1_CK8_B, linea2_CK8_B, linea3_CK8_B, linea4_CK8_B, linea5_CK8_B 
                    CURSOR 16, 53
                    RASTREO_TECLA 
                    ;RESTA 5 A AGUA Y COMIDA
                    RESTAR_RECURSO rAgua, 5
                    RESTAR_RECURSO rComida, 5
                    CALL ACT_RECURSOS
                    
                    MOV AH, RASTREO
                    MOV AL, CARACTER
                    CMP AH, 1CH
                    JE D2DEC3
                    
                    JMP D2DEC3 ;DIA2 DECISION 3 (NO HAY PREAMBULO)
                    
                  D2CK8C:;HISTORIA DECISION C ----------------- NEUTRAL
                    MOV largoCad, 40
                    IMP_CENTRAL linea1_CK8_C, linea2_CK8_C, linea3_CK8_C, linea4_CK8_C, linea5_CK8_C 
                    CURSOR 16, 53
                    RASTREO_TECLA
                    MOV AH, RASTREO
                    MOV AL, CARACTER
                    CMP AH, 1CH
                    JE D2DEC3 
                        ;NADA
                        JMP D2DEC3 ;DIA2 DECISION 3 (NO HAY PREAMBULO)  
                                                                         
                                                                     
           ;------------------- METODO PARA DESCONTAMINAR----------------------        
            D2DEC3:  ;DIA2 DECISION3 LE QUITE 1 PORQUE 4 YA ERA MUCHO OYE
                MOV checkpoint, '8'
                MOV largoCad, 40
                IMP_CENTRAL linea1_CK9DEC, linea2_CK9DEC, linea3_CK9DEC, linea4_CK9DEC, linea5_CK9DEC
                ; PEDIR OPCION                                                        
                
                IMP_COLOR_CURSOR 16, 28, msjOpcionPrincipal, 23, colorDestacado
                CURSOR 16, 53
                
                CALL AUMENTAR_RADIACION ; Si tarda mucho en decidir aumenta la radiación
                RASTREO_TECLA
                CALL DETENER_RADIACION  ; Detiene el aumento
                CALL ANALIZAR_RADIACION ; Analiza nivel de radiación
                
                MOV AH, RASTREO
                MOV AL, CARACTER                            
                CMP AH, 01H
                    JE VOLVER_INICIO
                CMP AL, 'A'
                    JE D2CK9A
                CMP AL, 'B'
                    JE D2CK9B 
                JMP D2DEC3 ;SUPONGO QUE AQUI IRA EL BAD ENDING POR RADIACION 
              
              D2CK9A: ;HISTORIA DECISION A ------------- APOYAR
                MOV largoCad, 40
                IMP_CENTRAL linea1_CK9_A, linea2_CK9_A, linea3_CK9_A, linea4_CK9_A, linea5_CK9_A
                    CURSOR 16, 53
                    RASTREO_TECLA
                    ;SUMA 5 A AGUA Y COMIDA
                    SUMAR_RECURSO rAgua, 5
                    SUMAR_RECURSO rComida, 5
                    CALL ACT_RECURSOS
                    
                    MOV AH, RASTREO
                    MOV AL, CARACTER
                    CMP AH, 1CH
                    JE D2CIDI  
                    JMP D2CIDI 
              
              D2CK9B:;HISTORIA DECISION B  ----------------- NO APOYAR
                MOV largoCad, 40
                IMP_CENTRAL linea1_CK9_B, linea2_CK9_B, linea3_CK9_B, linea4_CK9_B, linea5_CK9_B
                    CURSOR 16, 53
                    RASTREO_TECLA
                    ;RESTA 5 A AGUA Y COMIDA
                    RESTAR_RECURSO rAgua, 5
                    RESTAR_RECURSO rComida, 5
                    CALL ACT_RECURSOS
                    
                    MOV AH, RASTREO
                    MOV AL, CARACTER
                    CMP AH, 1CH
                    JE D2CIDI                      
                    JMP D2CIDI ;DIA2 CIERRE DEL DIA (PA QUE VEAN QUE YA SE ACABO)
                
         D2CIDI:
            ; Historia DIA2  PREAMBULO 1                                        
            MOV largoCad, 40
            IMP_CENTRAL linea1_CK9_N, linea2_CK9_N, linea3_CK9_N, linea4_CK9_N, linea5_CK9_N 
            
             ; PEDIR OPCION
            IMP_COLOR_CURSOR 16, 28, msjOpcionPrincipal, 23, colorDestacado
            CURSOR 16, 53
            RASTREO_TECLA
            MOV AH, RASTREO
            MOV AL, CARACTER
                        
            CMP AH, 1CH
                JE D2P1
            JMP D2P1
              
             ;--------------------------------------- FIN DEL DIA 2--------------------------
             ;---------------------------------------INICIO DEL DIA 3--------------------------
             D3P1:
               ; Historia DIA3  PREAMBULO 1                                        
            MOV largoCad, 40
            IMP_CENTRAL linea1_CK10, linea2_CK10, linea3_CK10, linea4_CK10, linea5_CK10 
            
             ; PEDIR OPCION
            IMP_COLOR_CURSOR 16, 28, msjOpcionPrincipal, 23, colorDestacado
            CURSOR 16, 53
            RASTREO_TECLA
            RECORRER_HISTORIAL regCK2
            MOV AH, RASTREO
            MOV AL, CARACTER
                        
            CMP AH, 01H
                JE VOLVER_INICIO
            CMP AH, 1CH
                JE D2D1  ;DIA2DECISION1
                
            JMP D3D1
             
             ;-------------DECISION DEL DIA 3--------------------------------------------
             ;---------------------- ROBAR VIVERES
            D3D1: ;HISTORIA DIA 3 DECISION 1
                MOV checkpoint, '9'
                MOV largoCad, 40
                IMP_CENTRAL linea1_CK10DEC, linea1_CK10DEC, linea1_CK10DEC, linea1_CK10DEC, linea1_CK10DEC
                ; PEDIR OPCION                                                        
                
                IMP_COLOR_CURSOR 16, 28, msjOpcionPrincipal, 23, colorDestacado
                CURSOR 16, 53
                
                CALL AUMENTAR_RADIACION ; Si tarda mucho en decidir aumenta la radiación
                RASTREO_TECLA
                CALL DETENER_RADIACION  ; Detiene el aumento
                CALL ANALIZAR_RADIACION ; Analiza nivel de radiación
                
                MOV AH, RASTREO
                MOV AL, CARACTER
                     ;Primeras 4 opciones, LLEVAN A DONDE MISMO PERO LOS DIALOGOS SON DIFERENTES       
                CMP AH, 01H
                    JE VOLVER_INICIO
                CMP AL, 'A'
                    JE CK10A
                CMP AL, 'B'
                    JE CK10B 
                CMP AL, 'C'
                    JE CK10C 
                JMP D3D1 
              
              CK10A: ;HISTORIA DECISION A --------------------- VISTA GORDA
                MOV largoCad, 40
                IMP_CENTRAL linea1_CK10_A, linea2_CK10_A, linea3_CK10_A, linea4_CK10_A, linea5_CK10_A  
                CURSOR 16, 53
                RASTREO_TECLA 
                ;RESTA 10 A AGUA Y COMIDA
                RESTAR_RECURSO rAgua, 10
                RESTAR_RECURSO rComida, 10
                CALL ACT_RECURSOS
                MOV AH, RASTREO
                MOV AL, CARACTER
                CMP AH, 1CH
                JE D3D2
                JMP D3D2 
              
              CK10B:;HISTORIA DECISION B  --------------------- IMPEDIR ROBO
                MOV largoCad, 40
                IMP_CENTRAL linea1_CK10_B, linea3_CK10_B, linea3_CK10_B, linea4_CK10_B, linea5_CK10_B 
                CURSOR 16, 53
                RASTREO_TECLA 
                            MOV AH, RASTREO
            MOV AL, CARACTER
                CMP AH, 1CH
                JE D3D2
                ;NADA
                JMP D3D2 
                
                
              CK10C:;HISTORIA DECISION B ---------------------------- UNIRSE
                MOV largoCad, 40
                IMP_CENTRAL linea1_CK10_C, linea2_CK10_C, linea3_CK10_C, linea4_CK10_C, linea5_CK10_C 
                CURSOR 16, 53
                RASTREO_TECLA
                ;RESTA 15 A AGUA Y COMIDA
                RESTAR_RECURSO rAgua, 15
                RESTAR_RECURSO rComida, 15
                CALL ACT_RECURSOS 
                MOV AH, RASTREO
                MOV AL, CARACTER
                CMP AH, 1CH
                JE D3D2                
                JMP D3D2    
            
            D3D2: ;------------------------------------DIA 3 DECISION 2-------------------  
            ;------------------------------ JEFE CORRUPTO--------
                MOV checkpoint, 'A'
                MOV largoCad, 40
                IMP_CENTRAL linea1_CK11DEC, linea2_CK11DEC, linea3_CK11DEC, linea4_CK11DEC, linea5_CK11DEC
                ; PEDIR OPCION                                                        
                
                IMP_COLOR_CURSOR 16, 28, msjOpcionPrincipal, 23, colorDestacado
                CURSOR 16, 53
                CALL AUMENTAR_RADIACION ; Si tarda mucho en decidir aumenta la radiación
                RASTREO_TECLA
                CALL DETENER_RADIACION  ; Detiene el aumento
                CALL ANALIZAR_RADIACION ; Analiza nivel de radiación  
                
                MOV AH, RASTREO
                MOV AL, CARACTER
                            
                CMP AH, 01H
                    JE VOLVER_INICIO
                CMP AL, 'A'
                    JE CK11A
                CMP AL, 'B'
                    JE CK11B 
 
                JMP D3D2 
              
              CK11A: ;HISTORIA DECISION A ----------------ACEPTAR SOBORNO
                MOV largoCad, 40
                IMP_CENTRAL linea1_CK11_A, linea2_CK11_A, linea3_CK11_A, linea4_CK11_A, linea5_CK11_A  
                CURSOR 16, 53
                RASTREO_TECLA 
                ;RESTA 5 A AGUA Y COMIDA
                RESTAR_RECURSO rAgua, 5
                RESTAR_RECURSO rComida, 5
                CALL ACT_RECURSOS        
                
                MOV AH, RASTREO
                MOV AL, CARACTER
                CMP AH, 1CH
                JE D3D3
                JMP D3D3 
              
              CK11B:;HISTORIA DECISION B ------------------- EXPONERLO
                MOV largoCad, 40
                IMP_CENTRAL linea1_CK11_B, linea2_CK11_B, linea3_CK11_B, linea4_CK11_B, linea5_CK11_B 
                CURSOR 16, 53
                RASTREO_TECLA
                ;RESTA 1 a habitantes
                RESTAR_RECURSO rHab, 1
                CALL ACT_RECURSOS 
                
                MOV AH, RASTREO
                MOV AL, CARACTER
                CMP AH, 1CH
                JE D3D3
                JMP D3D3 
            
            ;-----------------------DIA 3 DECISION3 FUGA DE AGUA-------------------    
            D3D3:;--------------------------------
                MOV checkpoint, 'B'       
                MOV largoCad, 40
                IMP_CENTRAL linea1_CK12DEC, linea2_CK12DEC, linea3_CK12DEC, linea4_CK12DEC, linea5_CK12DEC
                ; PEDIR OPCION                                                        
                
                IMP_COLOR_CURSOR 16, 28, msjOpcionPrincipal, 23, colorDestacado
                CURSOR 16, 53
                
                CALL AUMENTAR_RADIACION ; Si tarda mucho en decidir aumenta la radiación
                RASTREO_TECLA
                CALL DETENER_RADIACION  ; Detiene el aumento
                CALL ANALIZAR_RADIACION ; Analiza nivel de radiación
                
                MOV AH, RASTREO
                MOV AL, CARACTER
                            
                CMP AH, 01H
                    JE VOLVER_INICIO
                CMP AL, 'A'
                    JE CK12A
                CMP AL, 'B'
                    JE CK12B 
 
                JMP D3D3 
              
              CK12A: ;HISTORIA DECISION A -------------------- CASTIGAR
                MOV largoCad, 40
                IMP_CENTRAL linea1_CK12_A, linea2_CK12_A, linea3_CK12_A, linea4_CK12_A, linea5_CK12_A  
                CURSOR 16, 53
                RASTREO_TECLA 
                            MOV AH, RASTREO
                MOV AL, CARACTER
                    CMP AH, 1CH
                    JE FIN
                    ;NADA
                    JMP FIN 
              
              CK12B:;HISTORIA DECISION B
                MOV largoCad, 40
                IMP_CENTRAL linea1_CK12_B, linea2_CK12_B, linea3_CK12_B, linea4_CK12_B, linea5_CK12_B 
                CURSOR 16, 53
                RASTREO_TECLA 
                MOV AH, RASTREO
                MOV AL, CARACTER
                CMP AH, 1CH
                JE FIN
                ;NADA
                JMP FIN  
         ;-----------------------------------------TERMINA EDICION DE PAU ----------------------------             
             
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
        ;CREAR_CARPETA rutaCarpeta
        ;JC C_ARC
        
        ;C_ARC:
        ; 2. Crear archivo "DatosJugador.txt"
        ;CREAR_ARCHIVO rutaDatosJugador, 32        
        ;MOV idDatosJugador, AX ; Recuperar id
        ;JC A_ARC
        
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
        ;CREAR_CARPETA rutaCarpeta
        ;JC C_ARC2
        
        ;C_ARC2:
        ; 2. Crear archivo "DatosPartida.txt"
        ;CREAR_ARCHIVO rutaDatosPartida, 32        
        ;MOV idDatosPartida, AX ; Recuperar id
        ;JC A_ARC2
        
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
        MOV AH, 0
        MOV AL, 1
        OUT DX, AL
        RET
    ENDP
    
    DETENER_RADIACION PROC    ; Apaga calefactor, simula frenar radiación
        MOV DX, 127
        MOV AX, 0
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
            IMP_COLOR_CURSOR 12, 3, estado, 9, colorNormal      ; Estado actual
            JMP FIN_ANRAD    
        RAD_MED:
            REEMPLAZAR_CADENA estado, estMed
            IMP_COLOR_CURSOR 12, 3, estado, 9, 0Eh      ; Estado actual
            JMP FIN_ANRAD
        RAD_PELIGRO:        
            REEMPLAZAR_CADENA estado, estPel
            IMP_COLOR_CURSOR 12, 3, estado, 9, 0Ch      ; Estado actual
            CALL LLAMAR_MUERTE
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
    
    ;--------------------------------------PANTALLA DE MUERTE UHHHHHHHHHH--------------------------------    
    PANTALLA_MUERTE PROC        
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
            CALL IMPRIMIROPCIONES_INICIO2
        
            MOV REN, 15
            PEDIRTECLA_INICIO2:
                CALL IMPRIMIROPCIONES_INICIO2                                        
                CURSOR REN, 27
                RASTREO_TECLA            
                MOV BL, REN
                CMP BL, 15
                    JE SUBRAYADO_INICIO2                      
                
            SUBRAYADO_INICIO2:
                IMP_COLOR_CURSOR 15, 28, msjSalirJuego, 15, 0F0H
            RASTREO_TECLA     
            JMP FIN                            
        RET
    ENDP        
    
    IMPRIMIROPCIONES_INICIO2 PROC
        IMP_COLOR_CURSOR 15, 28, msjSalirJuego, 15, 1EH
        RET
    ENDP
    
    SALTO_CHECKPOINT:
        MOV AL, checkpoint
        CMP AL, '1'
            JE CK1
        CMP AL, '2'
            JE CK2
        CMP AL, '3'
            JE D1D2
        CMP AL, '4'
            JE D1D3
        CMP AL, '5'
            JE D1D4
        CMP AL, '6'
            JE D2D1
        CMP AL, '7'
            JE D2DEC2
        CMP AL, '8'
            JE D2DEC3
        CMP AL, '9'
            JE D3D1
        CMP AL, 'A'
            JE D3D2
        CMP AL, 'B'
            JE D3D3      
           
END