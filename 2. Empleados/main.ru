Estructura Empleado
    CADENA nombre
    FLOTANTE sueldo_anual
    ENTERO matriz_datos[3][12] # Matriz para horas, valor y sueldo mensual
FinEstructura

INICIO
    Empleado lista_empleados[30] # Lista de empleados
    CADENA nomina[30]
    Entero cantidad
    cantidad = 30
    
    #1. Obtiene nómina de empleados
    nomina = obtener_nomina("nomina.txt")

    #Pedir datos de los empleados y cargar la lista
    cargar_datos_empleados(nomina, cantidad, lista_empleados)

    #2. Calcular sueldo anual de cada empleado
    calcular_sueldo_anual(lista_empleados, cantidad)

    #3. Suma de sueldos mensuales
    calcular_total_sueldos_mensuales(lista_empleados, cantidad)

    #4. Máximo sueldo de cada mes
    calcular_maximo_sueldo_mensual(lista_empleados, cantidad)

    #5. Porcentaje que representa cada sueldo sobre el total de un mes específico
    calcular_porcentaje_sueldo(lista_empleados, cantidad, 5)

    #6. Empleado que cobró el menor sueldo en el primer semestre
    calcular_menor_sueldo_semestre(lista_empleados, cantidad)

    #7. Cantidad de meses en los que se pagó más de 4 millones
    calcular_cantidad_meses_mayor_4millones(lista_empleados, cantidad)

    #8. Guardar sueldos anuales en archivo ordenados
    guardar_sueldos(lista_empleados, cantidad)
FIN 

FUNCION obtener_nomina(CADENA path): CADENA[]
    Cadena nombres[30]
    Entero i = 1
    ARCHIVO archivo_lectura
    CADENA nombre
    archivo_lectura = AbrirArchivo(path, "LECTURA")
    MIENTRAS NO FinArchivo(archivo_lectura)
        nombre = LeerLinea(archivo_lectura)
        nombres[i] = nombre
        i++
    FIN MIENTRAS

    CerrarArchivo(archivo_lectura)

    RETORNAR nombres
FIN FUNCION

FUNCION cargar_datos_empleados(CADENA nomina[], ENTERO cantidad, Empleado lista_empleados[])
    PARA(ENTERO i = 1; i <= cantidad; i++)
        # Crear un nuevo empleado y asignar nombre
        lista_empleados[i].nombre = nomina[i]
        lista_empleados[i].sueldo_anual = 0

        Escribir "Carga de datos para el empleado: ", lista_empleados[i].nombre

        #Pedir datos por mes
        PARA(ENTERO  j = 1; j <= 12; j++)
            Escribir "Mes ", j
            Imprimir("Ingrese la cantidad de horas")
            Leer horas
            Imprimir("Ingrese el valor por hora")
            Leer valor
            sueldo = horas * valor
            lista_empleados[i].matriz_datos[1][j] = horas
            lista_empleados[i].matriz_datos[2][j] = valor
            lista_empleados[i].matriz_datos[3][j] = sueldo
        FIN PARA
    FIN PARA
FIN FUNCION

FUNCION calcular_sueldo_anual(Empleado lista_empleados[], ENTERO cantidad)
    PARA(ENTERO  i = 1 ; i <= cantidad; i++)
        Escribir lista_empleados[i].nombre
        PARA(ENTERO  j = 1; j <= 12; j++)
            lista_empleados[i].sueldo_anual = lista_empleados[i].sueldo_anual + lista_empleados[i].matriz_datos[3][j]
            Escribir lista_empleados[i].sueldo_anual, "\t"
        FIN PARA
        Escribir ""
    FIN PARA
FIN FUNCION

FUNCION calcular_total_sueldos_mensuales(Empleado lista_empleados[], ENTERO cantidad)
    FLOTANTE suma_anual
    suma_anual = 0
    PARA(ENTERO  i = 1 ; i <= cantidad; i++)

        PARA(ENTERO j = 1; j <= 12; j++)
            suma_anual = suma_anual + lista_empleados[i].matriz_datos[3][j]
        FIN PARA

        Escribir "El sueldo anual de: ", lista_empleados[i].nombre, " es: ", suma_anual

    FIN PARA
FIN FUNCION

FUNCION calcular_maximo_sueldo_mensual(Empleado lista_empleados[], ENTERO cantidad)
    FLOTANTE maximo_sueldo 
    PARA(ENTERO mes = 1; mes <=  12; mes++)
        maximo_sueldo = 0
        PARA(ENTERO i = 1; i <= cantidad; i++)
            SI lista_empleados[i].matriz_datos[3][mes] > maximo_sueldo Entonces
                maximo_sueldo = lista_empleados[i].matriz_datos[3][mes]
            FIN SI
        FIN PARA

        Escribir "Máximo sueldo para el mes ", mes, ": ", maximo_sueldo
    FIN PARA
FIN FUNCION

FUNCION calcular_porcentaje_sueldo(Empleado lista_empleados[], ENTERO cantidad, ENTERO que_mes)
    FLOTANTE total, porcentaje
    total = 0

    PARA(ENTERO i = 1; i <= cantidad; i++)
        total = total + lista_empleados[i].matriz_datos[3][que_mes]
    FIN PARA

    PARA(ENTERO i = 1; i <= cantidad; i++)
        porcentaje = (lista_empleados[i].matriz_datos[3][que_mes] / total) * 100
        Escribir "El sueldo de ", lista_empleados[i].nombre, " representa el ", porcentaje, "% del mes ", que_mes
    FIN PARA
FIN FUNCION

FUNCION calcular_menor_sueldo_semestre(Empleado lista_empleados[], ENTERO cantidad)
    FLOTANTE minimo
    minimo = lista_empleados[1].matriz_datos[3][1]

    PARA(ENTERO i = 1; i <= cantidad; i++)
        PARA(ENTERO j = 1; j <= 6; j++)
            SI lista_empleados[i].matriz_datos[3][j] < minimo Entonces
                minimo = lista_empleados[i].matriz_datos[3][j]
            FIN SI
        FIN PARA
    FIN PARA

    Escribir "El sueldo mínimo es: ", minimo
    Escribir "Los empleados que tienen el sueldo mínimo son:"

    PARA(ENTERO i = 1; i <= cantidad; i++)
        c j = 1; j <= 6; j++)
            SI lista_empleados[i].matriz_datos[3][j] = minimo Entonces
                Escribir lista_empleados[i].nombre
            FIN SI
        FIN PARA
    FIN PARA
FIN FUNCION

FUNCION calcular_cantidad_meses_mayor_4millones(Empleado lista_empleados[], ENTERO cantidad)
    ENTERO contador
    contador = 0

    PARA(ENTERO mes = 1; mes <=  12; mes++)
        FLOTANTE suma_sueldos
        suma_sueldos = 0

        PARA(ENTERO i = 1; i <= cantidad; i++)
            suma_sueldos = suma_sueldos + lista_empleados[i].matriz_datos[3][mes]
        FIN PARA


        SI suma_sueldos > 4000000 Entonces
            contador = contador + 1
        FIN SI
    FIN PARA

    Escribir "La cantidad de meses donde se pagaron más de 4 millones es: ", contador
FIN FUNCION

FUNCION guardar_sueldos(Empleado lista_empleados[], ENTERO cantidad)
    ordenar_lista(lista_empleados, cantidad)

    archivo = Abrir("liquidacion.txt", ESCRIBIR)
    PARA(ENTERO i = 1; i <= cantidad; i++)
        EscribirLinea(archivo, lista_empleados[i].nombre, ": $", lista_empleados[i].sueldo_anual)
    FIN PARA
    CerrarArchivo(archivo)
FIN FUNCION

FUNCION ordenar_lista(Empleado lista_empleados[], ENTERO cantidad)
    Empleado temp
    PARA(ENTERO i = 1; i <= cantidad; i++)
        PARA(ENTERO j = 1; j <= cantidad - ; j++)
            SI lista_empleados[i].sueldo_anual > lista_empleados[j].sueldo_anual Entonces
                temp = lista_empleados[j]
                lista_empleados[j] = lista_empleados[j+1]
                lista_empleados[j+1] = temp
            FIN SI
        FIN PARA
    FIN PARA
FIN FUNCION

