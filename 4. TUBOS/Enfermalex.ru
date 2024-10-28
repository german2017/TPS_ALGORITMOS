Estructura NodoPila
    CADENA sustancia
    NodoPila proximo_nodo
Fin Estructura

FUNCION Apilar(NodoPila &tubo, CADENA sustancia)
    NodoPila nuevo_nodo
    nuevo_nodo.sustancia  = sustancia
    nuevo_nodo.proximo_nodo = tubo
    tubo = nuevo_nodo
FIN FUNCION

FUNCION Desapilar(NodoPila &tubo): Carta
    CADENA sustancia
    SI tubo != NULO
        sustancia = tubo.sustancia
        tubo = tubo.proximo_nodo  
    SINO
        sustancia = ""
    
    RETORNAR sustancia
FIN FUNCION

FUNCION intercambiar(CADENA &sustancia1, CADENA &sustancia2)
    '''
    Intercambia el valor de una variable a la otra
    Recibe: dos sustancias o medidas
    No devuelve nada
    '''
    CADENA auxiliar
    auxiliar = sustancia1
    sustancia1 = sustancia2
    sustancia2 = auxiliar
FIN FUNCION

FUNCION mezclar(CADENA &farmacos[])
    '''
    Mezcla las medidas dentro del vector farmacos
    Recibe: el vector de 30 farmacos
    No devuelve nada
    '''
    ENTERO j = 10
	PARA (ENTERO i = 30, i>=1, i--)
        j = numero_aleatorio(1, i)
        intercambiar(farmacos[i], farmacos[j])
    FIN PARA
FIN FUNCION

FUNCION distribuir_farmacos(CADENA farmacos[], NodoPila &tubos[])
    '''
    Reparte los 30 elementos de la cadena farmacos en los 10 tubos
    Recibe: vector de 30 farmacos, vector de 10 tubos
    No devuelve nada
    '''
    PARA(ENTERO i = 1; i <= 10; i++)
        PARA(ENTERO j = 1; j <= 3; j++)
            tubos[i].Apilar(farmacos[(i-1)*3 + j]) #fórmula para recorrer los 30 elementos
        FIN PARA
    FIN PARA
FIN FUNCION

FUNCION buscar_posicion_sustancia(NodoPila tubo, CADENA sustancia_busqueda)
    '''
    Busca la primera coincidencia de la sustancia indicada dentro del tubo
    Recibe: tubo donde se busca, sustancia buscada
    Devuelve: indice de la primera coincidencia
    '''
    NodoPila auxiliar
    ENTERO indice = -1
    ENTERO contador = 1
    CADENA sustancia = ""
    MIENTRAS tubo.LARGO > 0
        sustancia = Desapilar(tubo)
        SI sustancia == sustancia_busqueda
            indice = contador
            Apilar(auxiliar, sustancia)	
            ROMPER 
        FIN SI
        contador++
        Apilar(auxiliar, sustancia)	
    FIN MIENTRAS
    MIENTRAS auxiliar.LARGO != 0
        sustancia = desapilar(auxiliar)
        Apilar(tubo, sustancia)
    FIN  MIENTRAS 

    RETORNAR indice
FIN FUNCION

FUNCION obtener_sustancia(NodoPila tubo)
    '''
    Busca la primera coincidencia de la sustancia indicada dentro del tubo
    Recibe: tubo donde se busca, sustancia buscada
    Devuelve: indice de la primera coincidencia
    '''
    CADENA auxiliar
    CADENA sustancia
    sustancia = Desapilar(tubo)
    auxiliar = sustancia
    Apilar(tubo, sustancia)
    RETORNAR auxiliar
FIN FUNCION


FUNCION mover_sustancia(NodoPila tubos[], ENTERO posicion, ENTERO index_untubo, ENTERO index_otrotubo)//tubos, 4, 2,2
    CADENA sustancia1
    CADENA sustancia2    
    i= posicion - 1//3
    MIENTRAS (i!=0)
        PARA (ENTERO j = 1; j <= 10; j++)
            SI (j != index_otrotubo Y j != index_untubo Y tubos[j].LARGO < 4)
                sustancia1 = Desapilar(tubos[index_otrotubo])
                Apilar(tubos[j], sustancia1)
                ROMPER
            FIN SI
        FIN PARA
        i--
    FIN MIENTRAS
    sustancia2 = Desapilar(tubos[index_otrotubo])
    Apilar(tubos[index_untubo], sustancia2)
FIN FUNCION

FUNCION preparar_tubo(NodoPila tubos[], ENTERO i)
    largo = tubos[i].LARGO
    CADENA sustancia_aux
    Si largo != 0
        mover_sustancia(tubos, largo, i, i)
    SINO
        PARA(ENTERO j = 0; j <= 10; j++)
            otro_tubo = &tubos[j]
            SI i!=j Y otro_tubo.LARGO == 4
                sustancia_aux = Desapilar(otro_tubo)
                Apilar(tubos[i], sustancia_aux)
                ROMPER
            FIN SI
        FIN PARA
FIN FUNCION

FUNCION buscar_farmacos(NodoPila tubos[], ENTERO i, CADENA sustancia)
    ENTERO indice = -1
    PARA(ENTERO x = 1; x <= 2; x++)
        PARA(ENTERO j = 1; j <= 10; j++)
            SI i!=j
                indice = buscar_posicion_sustancia(tubos[j], sustancia)
                SI indice != -1
                    mover_sustancia(tubos, indice, i, j)
                    ROMPER
                FIN SI
            FIN SI
        FIN PARA
    FIN PARA    
FIN FUNCION

INICIO
    CADENA farmacos = ["rojo","azul","verde","amarillo","gris","rosa","blanco","negro","violeta","magenta",
    "rojo","azul","verde","amarillo","gris","rosa","blanco","negro","violeta","magenta","rojo","azul","verde",
    "amarillo","gris","rosa","blanco","negro","violeta","magenta"]
        
    NodoPila tubos[10]

    mezclar(farmacos)
    distribuir_farmacos(farmacos, tubos)
    
    PARA(ENTERO i = 1; i<= 10; i++)
        preparar_tubo(tubos, i)
        sustancia = obtener_sustancia(tubos[i])
        buscar_farmacos(tubos, i, sustancia)
    FIN PARA

    IMPRIMIR("Tubos Ordenados")

FIN INICIO