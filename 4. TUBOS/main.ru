Estructura NodoPila
    Cadena sustancia
    NodoPila proximo_nodo
Fin Estructura

FUNCION Apilar(NodoPila &tubo, Cadena sustancia)
    NodoPila nuevo_nodo
    nuevo_nodo.sustancia  = sustancia
    nuevo_nodo.proximo_nodo = tubo
    tubo = nuevo_nodo
FIN FUNCION

FUNCION Desapilar(NodoPila &tubo): Carta
    Cadena sustancia
    SI tubo != nulo 
        sustancia = tubo.sustancia
        tubo = tubo.proximo_nodo  
    SINO
        sustancia = ""
    
    retornar sustancia
FIN FUNCION

FUNCION intercambiar(Cadena &sustancia1, Cadena &sustancia2)
    Cadena auxiliar
    auxiliar = sustancia1
    sustancia1 = sustancia2
    sustancia2 = auxiliar
FIN FUNCION

FUNCION mezclar (Cadena[] farmacos)
    ENTERO j = 10
	PARA (Entero i = 30, i>=1, i--)
        j = numero_aleatorio(1, j)
        intercambiar(farmacos[i], farmacos[j])
    FIN PARA
FIN FUNCION
FUNCION distribuir_farmacos(Cadena farmacos[], NodoPila &tubos[])
    PARA(ENTERO i = 1; i <= 10; i++)
        PARA(ENTERO j = 1; j <= 3; j++)
            tubos[i].Apilar(farmacos[(i-1)*3 + j])
        FIN PARA
    FIN PARA
FIN FUNCION

FUNCION buscar_posicion_sustancia(NodoPila tubo, CADENA sustancia_busqueda):ENTERO
    NodoPila auxiliar
    ENTERO indice = -1
    ENTERO contador = 1
    MIENTRAS tubo.LARGO > 0
        sustancia = Desapilar(tubo)
        SI sustancia == sustancia_busqueda
            indice = contador
            ROMPER 
        FIN SI
        contador++
    FIN MIENTRAS
    retorna indice
FIN FUNCION

FUNCION obtener_sustancia(NodoPila tubo)
    CADENA auxiliar
    CADENA sustancia
    sustancia = Desapilar(tubo)
    auxiliar = sustancia
    Apilar(tubo, sustancia)
    retornar auxiliar
FIN FUNCION


FUNCION mover_sustancia(NodoPila tubos[], ENTERO posicion, ENTERO index_untubo, ENTERO index_otrotubo)
    CADENA sustancia1
    CADENA sustancia2    
    i= posicion - 1
    MIENTRAS (i!=0)
        PARA (j = 1; j <= 10; j++)
            SI (j != index_otrotubo Y j != index_untubo Y tubos[j].LARGO < 4)
                sustancia1 = Desapilar(tubos[index_otrotubo])
                Apilar(tubos[j], sustancia1)
            FIN SI
        FIN PARA
        i--
    FIN MIENTRAS
    sustancia2 = Desapilar(tubos[index_otrotubo])
    Apilar(tubos[index_untubo], sustancia)
FIN FUNCION

INICIO
    Cadena farmacos = ["rojo","azul","verde","amarillo","gris","rosa","blanco","negro","violeta","magenta",
    "rojo","azul","verde","amarillo","gris","rosa","blanco","negro","violeta","magenta","rojo","azul","verde",
    "amarillo","gris","rosa","blanco","negro","violeta","magenta"]
    
    NodoPila tubos[10]

    mezclar(farmacos)
    distribuir_farmacos(farmacos, tubos)
    
    sustancia1 = Desapilar(tubos[1])
    Apilar(tubos[10], sustancia1)
    sustancia2 = Desapilar(tubos[1])
    Apilar(tubos[9], sustancia2)

    PARA(ENTERO i = 1; i<= 10; i++)
        sustancia = obtener_sustancia(tubos[i])
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
    FIN PARA

    
    
    # PARA(ENTERO i = 0; i<= 10; i++)
    #     un_tubo = &tubos[i]
    #     SI un_tubo.LARGO == 0
    #         PARA(ENTERO j = 0; j <= 10; j++)
    #             otro_tubo = &tubos[j]
    #             SI i!=j Y otro_tubo.LARGO == 4
    #                 CADENA sustancia
    #                 sustancia = Desapilar(otro_tubo)
    #                 Apilar(un_tubo, sustancia)
                    
    #     SINO
    #         PARA(ENTERO j = 1; j <= 10; j++)
    #         otro_tubo = &tubos[j]
    #         SI i!=j Y otro_tubo.LARGO < 4
    #             CADENA sustancia
    #             sustancia = Desapilar(un_tubo)
    #             Apilar(otro_tubo, sustancia)    




FIN INICIO