ESTRUCTURA Pagina
	ENTERO numero_pagina
	CADENA letras[]
FIN ESTRUCTURA

ESTRUCTURA Letra
	TipoLetra tipo_letra
	CADENA caracter
FIN ESTRUCTURA

ESTRUCTURA TipoLetra
	CADENA fuente
	CADENA color_letra
	CADENA color_fondo
FIN ESTRUCTURA

ESTRUCTURA Revista
	PAGINA[] paginas
	ENTERO cantidad_paginas
	CADENA nombre
FIN ESTRUCTURA

# ESTRUCTURA Punto1
# 	CADENA nombre_revista
# 	ENTER numero_pagina
# FIN ESTRUCTURA

ESTRUCTURA Venta
CADENA nombre_revista
CADENA comprador
FIN ESTRUCTURA	

ESTRUCTURA Sospechoso
CADENA nombre
CADENA revistas[8] #= ["","","","","","","",""]
FIN ESTRUCTURA	

ESTRUCTURA NodoSospechoso
Sospechoso sospechoso
NodoSospechoso siguiente
FIN ESTRUCTURA	

ESTRUCTURA NodoRevista//cola
	Revista una_revista
	NodoRevista siguiente
FIN ESTRUCTURA


NodoSospechoso listaSospechosos = NULO

INICIO
	TipoLetra tipo_letra []
	Letra letras_nota[]
	Revista lista_revistas[]
	Ventas lista_ventas[]
	#Obtenemos todos los tipos de letras desde un archivo. 
	#Cada una tiene el siguiente formato: {fuenteTexto = "fuente1", colorLetra = "negro", colorFondo = "celeste"}
	tipos = obtener_tipos_letras("fuentes.txt") 
	
	#Obtenemos las letras de la nota
	letras_nota = obtener_letras_nota()

	# revista: {Paginas:[pagina],cantPaginas:1,nombre:"Revista Futbol", tipoLetra:tipoLetra}
	# pagina : {numeroPagina = 1,letras={letra1, letra2, letra3}}
	# letra : {TipoLetra} 
	lista_revistas = obtener_revistas_publicadas()

	#venta : {nombreRevista: "Revista Musica", comprador: "Juan Perez"}
	lista_ventas = obtener_ventas("ventas.txt")

	ResolucionPunto1(letras_nota, lista_revistas)




FIN



NodoRevista nodo_frontal, nodo_trasero

FUNCION encolar_revista(Revista una_revista) //Encolar
	NodoRevista nuevo_nodo
	nuevo_nodo.una_revista = una_revista
	nuevo_nodo.siguiente = NULO
	SI (nodo_frontal == NULO)
		nodo_frontal = nuevo_nodo
		nodo_trasero = nuevo_nodo
	SINO
		nodo_frontal.siguiente = nuevo_nodo
		nodo_trasero = nuevo_nodo
	FIN SI
FIN FUNCION


# ////////////////////////////////////////////////FUNCIONES RESOLUCION PUNTO1///////////////////////////////////////

FUNCION ResolucionPunto1(Letra letras_nota[], Revista revistas[]): Revista[] 
	Revista revistas_coincidencia[]
	Revista una_revista
	PARA (i=1, i <= letras_nota.largo, i++) 
		PARA (j=1, j <= revistas.largo, j++) 

			una_revista = BuscarRevista(revista[j],letras[i])

			SI (una_revista != nulo)
				encolar_revista(una_revista)//encolar
				ROMPER			
			FIN SI	
		FIN PARA	
	FIN PARA	
FIN FUNCION

FUNCION BuscarRevista(revista,letra): Revista	
	Revista revista_encontrada
	revista_encontrada = NULO

	PARA (i=1, i<=revista.cantPaginas, i++) 

		SI (BuscarLetra(revista.paginas[i].letras, letra))
			revista_encontrada = revista[i]
			ROMPER
		FIN SI	
	FIN PARA	
			
	RETORNAR revista_encontrada;

FIN FUNCION

FUNCION BuscarLetra(letrasPagina,letra):BOOLEANO	
	BOOLEANO encontro
	encontro = FALSO
	PARA (i=1, i <= letrasPagina.largo, i++) 
		SI(letrasPagina[i] == letra.caracter)
			SI(letrasPagina[i].tipo_letra.fuente == letra.tipoLetra.fuente)
				SI(letrasPagina[i].tipo_letra.colorLetra == letra.tipoLetra.colorLetra)
					SI(letrasPagina[i].tipo_letra.colorFondo == letra.tipoLetra.colorFondo)
						encontro = VERDADERO
					FIN SI	
				FIN SI	
			FIN SI	
		FIN SI	
	FIN PARA	
	
	RETORNAR encontro
FIN FUNCION
# /////////////////////////////////////////////////// ENCOLAR Y DESENCOLAR PUNTO1 ////////////////////////////////////////
	

FUNCION desencolar_revista(): Revista //Desencolar
	Revista una_revista
	una_revista = NULO
	SI (nodo_frontal != NULO)
		una_revista = nodo_frontal.una_revista
		nodo_frontal = nodo_frontal.siguiente
	FIN SI

	RETORNAR una_revista
FIN FUNCION


	////////////////////////////////////////////////// FIN ENCOLAR Y DESENCOLAR PUNTO1 ///////////////////////////////////////////


///////////////////////////////////////////////////FIN FUNCIONES RESOLUCION PUNTO1///////////////////////////////////////

////////////////////////////////////////////////FUNCIONES RESOLUCION PUNTO2///////////////////////////////////////

FUNCION ResolucionPunto2(ventas)

	HACER
		Punto1 punto1 = ObtenerPunto1()//desencolar

		SI(punto1 != nulo)
		
			PARA (z=0, z<ventas.largo, z++) 

				SI(ventas[z].nombreRevista == punto1.nombreRevista)
			
					SI(existeSospechoso(listaSospechosos,ventas[z].comprador))

						AgregarRevistaComprada(listaSospechosos,ventas[z])
					SINO
						AgregarSospechoso(listaSospechosos,ventas[z])
				FIN SI

			FIN PARA
		FIN SI

	MIENTRAS (punto1 != nulo)



FUNCION existeSospechoso(listaSospechosos,nombreSospechoso):BOOLEANO

	NodoSospechoso nodo_actual = listaSospechosos
	SI(listaSospechosos==NULO)
		RETORNAR false
	FIN SI

	HACER
		SI (nodo_actual.sospechoso.nombre == nombreSospechoso)
			
			RETORNAR true
		FIN SI
		
		nodo_actual = nodo_actual.siguiente
	MIENTRAS (nodo_actual.siguiente !=nulo)
	
	RETORNAR false


FUNCION AgregarRevistaComprada(listaSospechosos,venta)
	
	NodoSospechoso nodo_actual = listaSospechosos
	BOOLEANO encontrado=false
	HACER
		SI (nodo_actual.sospechoso.nombre == venta.comprador)
			encontrado =true		
		FIN SI
		SI (encontrado==false)
			nodo_actual = nodo_actual.siguiente
		FIN SI
	MIENTRAS (encontrado==false)


	BOOLEANO existe = false
	PARA(i=1; i <= 8 ;i++)
		SI(nodo_actual.sospechoso.revistas[i]==venta.nombreRevista)
			existe = true
			ROMPER
		FIN SI
	FIN PARA
	SI(existe==false)
		PARA(j=1; j <= 8 ;j++)
			SI(nodo_actual.sospechoso.revistas[j]=="")
				nodo_actual.sospechoso.revistas[j] = venta.nombreRevista
			FIN SI
		FIN PARA	
	FIN SI



FUNCION AgregarSospechoso(listaSospechosos,venta)
	Sospechoso nuevoSospechoso
	nuevoSospechoso.nombre = venta.comprador
	nuevoSospechoso.revistas[0] = venta.nombreRevista

	NodoSospechoso nodo_nuevo
	nodo_nuevo.sospechoso = nuevoSospechoso

	nuevo_nodo.siguiente = listaSospechosos
	listaSospechosos = nodo_nuevo

////////////////////////////////////////////////FIN FUNCIONES RESOLUCION PUNTO2///////////////////////////////////////
