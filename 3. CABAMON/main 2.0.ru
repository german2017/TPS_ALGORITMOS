Estructura Carta
    CADENA nombre
    ENTERO velocidad
    ENTERO fuerza
    CADENA elemento
    ENTERO peso
    ENTERO altura // En cm
Fin Estructura

Estructura NodoPila
    Carta carta
    NodoPila proximo_nodo
Fin Estructura

INICIO
    CADENA matriz_elementos[5][2]={{"fuego","aire"}{"electricidad","agua"},{"aire","tierra"},{"agua","fuego"},{"tierra","electricidad"}}
    // Carta mazo[250] EL MAZO NO DEBERIA SER UNA PILA??? porque sino nunca sacamos la carta del mazo
    NodoPila pila_jugador1
    NodoPila pila_jugador2
    NodoPila pila_mesa
    
    CADENA atributo
    CADENA ganador_ronda
    CADENA bandera
    
    mazo = obtener_mazo()//desde archivo
    mezclar(&mazo)
    repartir(&mazo, pila_jugador1, pila_jugador2)

    PARA(ENTERO i = 1; i <= 250 O (pila_jugador1.LARGO == 0 O pila_jugador2.LARGO == 0); i++)
    //TODO ESTO PODRIA IR A UNA FUNCION, ver si vale la
    //pena seguir modularizaando
        bandera = FALSO
        
        atributo = sortearAtributo()
        
        carta_jugador_1 = Desapilar(pila_jugador1)
        carta_jugador_2 = Desapilar(pila_jugador2)

        SI atributo == "elemento"
            elemento_jugador_1 = carta_jugador_1.elemento
            elemento_jugador_2 = carta_jugador_2.elemento
            
            a_quien_le_gana = buscar_elemento_quien_gana(elemento_jugador_1, CADENA matriz_elementos)

            SI elemento_jugador_2 == a_quien_le_gana // Gano el elemento del jugador 1
                pila_robo = &pila_jugador2  //refencio la pila robo a la pila de donde tengo que sacar dos cartas          
                bandera = VERDADERO
            FIN SI
            SI bandera != VERDADERO
                a_quien_le_gana = buscar_elemento_quien_gana(elemento_jugador_2, CADENA matriz_elementos)
                SI elemento_jugador_1 == a_quien_le_gana // Gano el elemento del jugador 2
                    pila_robo = &pila_jugador1
                FIN SI
                bandera = VERDADERO
            FIN SI
            SI bandera == VERDADERO //Si alguno gano por elemento
                //2 cartas en juego
                robo1 = Desapilar(pila_robo)
                robo2 = Desapilar(pila_robo)
                //le  robo 2 al 2
                SI pila_mesa.LARGO > 0
                    sumar_pilas(pila_robo, pila_mesa)
                FIN SI
                recoger_cartas(pila_robo, carta_jugador_1, carta_jugador_2)
                recoger_cartas(pila_robo, robo1, robo2)
            SINO//SI NO GANO NINGUNO
                imprimir "Hubo empate en elemento. Nadie gana"
            
        SINO
            valor_jugador_1 = obtener_valor(carta_jugador_1, atributo)
            valor_jugador_2 = obtener_valor(carta_jugador_2, atributo)
            //SE PUEDE ACHICAR
            SI valor_jugador_1 > valor_jugador_2
                SI pila_mesa.LARGO > 0
                    sumar_pilas(pila_jugador1, pila_mesa)
                FIN SI
                recoger_cartas(pila_jugador1, carta_jugador_1, carta_jugador_2)            
            SINO 
                SI valor_jugador_1 < valor_jugador_2
                    SI pila_mesa.LARGO > 0
                        sumar_pilas(pila_jugador2, pila_mesa)
                    FIN SI
                    recoger_cartas(pila_jugador2, carta_jugador_2, carta_jugador_1)
                SINO
                Apilar(pila_mesa, carta_jugador_1)
                Apilar(pila_mesa, carta_jugador_2)
            FIN SI
        FIN SI
    FIN PARA
    verificar_ganador(pila_jugador1, pila_jugador2)


FIN

FUNCION buscar_elemento_quien_gana(CADENA elemento_jugador, CADENA matriz_elementos)
    PARA(ENTERO i = 1; i <= 5; i++)
        SI elemento_jugador == matriz_elementos[i][1]
            a_quien_le_gana = matriz_elementos[i][2]
            ROMPER
        FIN SI
    FIN PARA
    retornar a_quien_le_gana
FIN FUNCION

FUNCION sumar_pilas(pila_jugador, pila_mesa)
    aux = mover_pila(pila_jugador1)  
    MIENTRAS pila_mesa.LARGO > 0
        c = Desapilar(pila_mesa)
        Apilar(pila_jugador1, c)
    FIN MIENTRAS
    MIENTRAS aux.LARGO > 0
        c = Desapilar(aux)
        Apilar(pila_jugador1, c)
    FIN MIENTRAS



FUNCION mover_pila(&pila_jugador)
    NodoPila pila_auxiliar
    MIENTRAS pila_jugador.LARGO > 0
        carta_aux = Desapilar(pila_jugador)
        Apilar(pila_auxiliar, carta_aux)
    FIN MIENTRAS
    retornar pila_auxiliar
FIN FUNCION


FUNCION recoger_cartas(&pila_jugador, carta_1, carta_2)
    NodoPila pila_auxiliar
    Carta carta_aux
    pila_auxiliar = mover_pila(pila_jugador)
    Apilar(pila_jugador, carta_1)
    Apilar(pila_jugador, carta_2)
    pila_jugador = mover_pila(pila_auxiliar)
    FIN MIENTRAS
FIN FUNCION


FUNCION obtener_valor_atributo(Carta carta, CADENA atributo)
    ENTERO valor
    SI atributo == "velocidad"
        valor = carta.velocidad
    SINO SI atributo == "fuerza"
        valor = carta.fuerza
    SINO SI atributo == "peso"
        valor = carta.peso
    SINO SI atributo == "altura"
        valor = carta.altura
    FIN SI
    retornar valor
FIN FUNCION


FUNCION sortearAtributo(): CADENA
    ENTERO random
    CADENA atributo_seleccionado
    CADENA atributos = ["velocidad","fuerza","elemento","peso","altura"]
    random = ALEATORIO(1,5)
    atributo_seleccionado = atributos[random]

    retornar atributo_seleccionado
FIN FUNCION

FUNCION Apilar(NodoPila &pila_jugador, Carta una_carta)
    NodoPila nuevo_nodo
    nuevo_nodo.carta = una_carta
    nuevo_nodo.proximo_nodo = pila_jugador
    pila_jugador = nuevo_nodo
FIN FUNCION

FUNCION Desapilar(NodoPila &pila_jugador): Carta
    Carta carta_jugada
    SI pila_jugador != nulo 
        carta_jugada = pila_jugador.carta
        pila_jugador = pila_jugador.proximo_nodo  
    SINO
        carta_jugada = nulo
    
    return carta_jugada
FIN FUNCION

FUNCION intercambiar(Carta &una_carta, Carta &otra_carta)
    Carta auxiliar
    auxiliar = una_carta
    una_carta = otra_carta
    otra_carta = auxiliar
FIN FUNCION

//Función mezclar cartas
FUNCION mezclar (Carta[] mazo)
    ENTERO j = 10
	PARA (Entero i = 250, i>=1, i--)
        j = numero_aleatorio(1, j)
        intercambiar(mazo[i], mazo[j])
    FIN PARA
FIN FUNCION

//Función repartir cartas
FUNCION repartir (Carta mazo[], NodoPila pila_jugador1, NodoPila pila_jugador2)
	PARA (i=1; i <= 250; i++)
        SI i % 2 == 0
            Apilar(pila_jugador1, mazo[i]) 
        SINO
            Apilar(pila_jugador2, mazo[i])
        FIN SI    	
    FIN PARA
FIN FUNCION

//Función ganador del juego
FUNCION verificar_ganador(pila_jugador_1, pila_jugador_2)
    SI pila_jugador_1.LARGO > pila_jugador_2.LARGO:
        imprimir("Gano Jugador 1 con", pila_jugador_1.LARGO , "cartas")
    SINO  pila_jugador_1.LARGO < pila_jugador_2.LARGO:
        Imprimir("Gano Jugador 2 con", pila_jugador_2.LARGO, "cartas")
    SINO
        Imprimir("Es empate")
        FIN SI
FIN FUNCION

FUNCION obtener_mazo()

    Carta una_carta
    Carta mazo[250]


    Entero i = 1
    archivo = AbrirArchivo("cabamon.txt", "LECTURA")
    Mientras NO FinArchivo(archivo)
        linea = LeerLinea(archivo)
        una_carta.nombre = linea[1]
        una_carta.velocidad = ENTERO(linea[2])
        una_carta.fuerza = ENTERO(linea[3])
        una_carta.elemento = linea[4]
        una_carta.peso = ENTERO(linea[5])
        una_carta.altura = ENTERO(linea[6])
        mazo[i] = una_carta
        i++
    FinMientras

    CerrarArchivo(archivo)

    retornar mazo
FIN FUNCION
