INICIO

ESTRUCTURA Pagina
	ENTERO numPagina
	CADENA letras[]
FIN ESTRUCTURA

ESTRUCTURA Letra
	TipoLetra tipoLetra
	CADENA caracter
FIN ESTRUCTURA

ESTRUCTURA TipoLetra
	CADENA fuente
	CADENA colorLetra
	CADENA colorFondo
FIN ESTRUCTURA


ESTRUCTURA Revista
	PAGINA paginas []
	ENTERO cantPaginas
	CADENA nombre
	TipoLetra tipoLetra
FIN ESTRUCTURA

ESTRUCTURA Punto1
	CADENA nombreRevista
	ENTERO numPagina
FIN ESTRUCTURA

ESTRUCTURA Venta
	CADENA nombreRevista
	CADENA comprador
FIN ESTRUCTURA

ESTRUCTURA Sospechoso
	CADENA nombre
	CADENA revistas = ["","","","","","","",""]
	ENTERO coincidencia
FIN ESTRUCTURA

ESTRUCTURA NodoSospechoso
	Sospechoso sospechoso
	NodoSospechoso siguiente
FIN ESTRUCTURA
NodoSospechoso listaSospechosos = NULO

ESTRUCTURA NodoCola
	Punto1 punto1
	NodoCola siguiente
FIN ESTRUCTURA


NodoCola nodo_frontal, nodo_trasero

//Se muestran ejemplos de datos de las estructuras. Se trabaja con el supuesto de que se cuenta con la lista de Revistas y Ventas.
TipoLetra tipoLetra = {fuente: "fuente1",colorLetra:"negro",colorFondo:"celeste"}
Letra letras[] = [{tipoLetra:tipoLetra,caracter:'G'},...] 
Pagina pagina[] = {numeroPagina:1,letras:['G','o','l']}
Revista revistas[] = [{Paginas:[pagina],cantPaginas:1,nombre:"Revista Futbol", tipoLetra:tipoLetra},...}]
Venta ventas[] = [{nombreRevista: "Revista Musica", comprador: "Juan Perez"},{nombreRevista: "Revista Futbol", comprador: "Martin Palermo"},...]



IdentificarRevistas(letras,revistas)

IdentificarSospechosos(ventas)

MostrarSospechosos(listaSospechosos)



////////////////////////////////////////////////FUNCIONES RESOLUCION PUNTO1///////////////////////////////////////

FUNCION IdentificarRevistas(letras,revistas)

	PARA (i=1, i<=letras.largo, i++) 
		PARA (j=1, j<=revistas.largo, j++) 
			PUNTO1 punto1
			punto1 = BuscarRevista(revista[j],letras[i])
			SI (punto1 != nulo)
				AgregarPunto1(punto1)//encolar
				j=revistas.largo+1			
			FIN SI
		FIN PARA
	FIN PARA



FUNCION BuscarRevista(revista,letra): Punto1
	PUNTO1 punto1 

	PARA (i=1, i<=revista.cantPaginas, i++) 

		SI (BuscarLetra(revista.paginas[i].letras,revista.tipoLetra,letra))
			punto1.nombreRevista = revista.nombre
			punto1.numPagina = revista.paginas[i].numPagina
			RETONAR punto1
		FIN SI

	FIN PARA
	RETORNAR NULO;


FUNCION BuscarLetra(letrasPagina[],tipoLetra,letra):BOOLEANO
	
	PARA (i=1, i<=letrasPagina.largo, i++) 
	
		SI(letrasPagina[i] == letra.caracter)

			SI(tipoLetra.fuente == letra.tipoLetra.fuente)

				SI(tipoLetra.colorLetra == letra.tipoLetra.colorLetra)

					SI(tipoLetra.colorFondo == letra.tipoLetra.colorFondo )

						RETORNAR true
					FIN SI
				FIN SI
			FIN SI
		FIN SI
	FIN PARA
	
	RETORNAR false

FUNCION AgregarPunto1(punto1) //Encolar
	NodoCola nuevo_nodo
	nuevo_nodo.punto1 = punto1
	nuevo_nodo.siguiente = nulo
 	SI (nodo_frontal == nulo)
		nodo_frontal = nuevo_nodo
		nodo_trasero = nuevo_nodo
	SINO
		nodo_frontal.siguiente = nuevo_nodo
		nodo_trasero = nuevo_nodo
	FIN SI

FUNCION ObtenerPunto1(): Punto1 //Desencolar
	Punto1 punto1;
	SI (nodo_frontal != Nulo)
		punto1 = nodo_frontal.punto1
		nodo_frontal = nodo_frontal.siguiente
		RETORNAR punto1
	SINO
		RETORNAR nulo
	FIN SI



///////////////////////////////////////////////////FIN FUNCIONES RESOLUCION PUNTO1///////////////////////////////////////

////////////////////////////////////////////////FUNCIONES RESOLUCION PUNTO2///////////////////////////////////////

FUNCION IdentificarSospechosos(ventas)

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

	HACER
		SI (nodo_actual.sospechoso.nombre == nombreSospechoso)
			
			RETORNAR true
		FIN SI

	MIENTRAS (nodo_actual !=nulo)
	
	RETORNAR false


FUNCION AgregarRevistaComprada(listaSospechosos,venta)
	
	NodoSospechoso nodo_actual = listaSospechosos
	BOOLEANO existe=false
	HACER
		SI (nodo_actual.sospechoso.nombre == venta.comprador)
			PARA(i=1; i <= 8 ;i++)
				SI(nodo_actual.sospechoso.revistas[i]==venta.nombreRevista)
					existe = true
					i=9
				FIN SI
			FIN PARA
			SI(existe==false)
				PARA(j=1; j <= 8 ;j++)
					SI(nodo_actual.sospechoso.revistas[j]=="")
						nodo_actual.sospechoso.revistas[j] = venta.nombreRevista
						nodo_actual.sospechoso.coincidencia++
						j=9
					FIN SI
				FIN PARA	
			FIN SI
		FIN SI

	MIENTRAS (nodo_actual !=nulo Y existe==false)



FUNCION AgregarSospechoso(listaSospechosos,venta)
	Sospechoso nuevoSospechoso
	nuevoSospechoso.nombre = venta.comprador
	nuevoSospechoso.revistas[0] = venta.nombreRevista
	nuevoSospechoso.coincidencia = 1

	NodoSospechoso nodo_nuevo
	nodo_nuevo.sospechoso = nuevoSospechoso

	nuevo_nodo.siguiente = listaSospechosos
	listaSospechosos = nodo_nuevo

FUNCION MostrarSospechosos(listaSospechosos)

	NodoSospechoso nodo_actual = listaSospechosos
	ENTERO num = 1
	HACER
		SI(nodo_actual.sospechoso.coincidencia == 8)
			
			IMPRIMIR ("Sospechoso numero " + num + ": " + nodo_actual.sospechoso.nombre)
			num++
		FIN SI
		
	MIENTRAS (nodo_actual !=nulo)



////////////////////////////////////////////////FIN FUNCIONES RESOLUCION PUNTO2///////////////////////////////////////

FIN