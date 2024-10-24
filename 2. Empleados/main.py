from ClassEmpleado import *
class Empleado:
    def __init__(self, nombre):
        self.nombre = nombre
        self.sueldo_anual = 0
        matriz = []
        for i in range(3):
            fila = [0] * 12 # 12 meses
            matriz += [fila]
        self.matriz_datos = matriz 
        
def obtener_nomina():
    nombres = []

    archivo = open("2. Empleados\\nomina.txt", "r")
    for line in archivo:
        nombres.append(line)
    
    return nombres

def cargar_datos_empleados_hardcodeo(empleados):
    e1 = Empleado(empleados[0])
    e2 = Empleado(empleados[1])
    e3 = Empleado(empleados[2])
    e4 = Empleado(empleados[3])
    e5 = Empleado(empleados[4])
    e6 = Empleado(empleados[5])

    lista_empleados = [e1, e2, e3, e4, e5, e6]
    return lista_empleados

def cargar_datos_empleados(nomina, cantidad):
    lista_empleados: list["Empleado"] = []
    for i in range(cantidad):
        un_empleado = Empleado(nomina[i])
        print(f"Carga de datos para el empleado: {un_empleado.nombre}")
        for j in range(12):
            print(f"Mes {j+1}:")
            horas = int(input("Ingrese la cantidad de horas trabajadas: "))
            valor = float(input("Ingrese el valor hora: "))
            sueldo = horas * valor
            un_empleado.matriz_datos[0][j] = horas
            un_empleado.matriz_datos[1][j] = valor
            un_empleado.matriz_datos[2][j] = sueldo

        lista_empleados.append(un_empleado)
        
    return lista_empleados

def calcular_sueldo_anual(lista_empleados: list["Empleado"]):
    for e in range(len(lista_empleados)):
        empleado: "Empleado" = lista_empleados[e]
        print(empleado.nombre)
        for i in range(len(lista_empleados)):
            for j in range(12):
                empleado.sueldo_anual += empleado.matriz_datos[i][j] 
                print(f"{round(empleado.sueldo_anual,2)}\t", end="")
            print()

def calcular_total_sueldos_mensuales(lista_empleados: list["Empleado"]):
    for i in range(len(lista_empleados)):
        empleado = lista_empleados[i]
        suma_anual = 0
        for j in range(12):
            suma_anual += empleado.matriz_datos[2][j]
        print(f"El sueldo anual de : {empleado.nombre} es: {suma_anual}")

def calcular_maximo_sueldo_mensual(lista_empleados: list["Empleado"]):
    for i in range(12):#MES
        maximo_sueldo = 0
        for j in range(len(lista_empleados)):#EMPLEADO
            empleado = lista_empleados[j]
            if empleado.matriz_datos[2][i] > maximo_sueldo:
                maximo_sueldo = empleado.matriz_datos[2][i]


        print(f"maximo sueldo para el mes {i+1}: {maximo_sueldo}")

def calcular_porcentaje_sueldo(lista_empleados: list["Empleado"], que_mes):
    total = 0
    suma = 0
    porcentaje = 0
    for i in range(len(lista_empleados)):
        empleado = lista_empleados[i]
        total += empleado.matriz_datos[2][que_mes-1]
    
    for i in range(len(lista_empleados)):
        empleado = lista_empleados[i]
        porcentaje = (empleado.matriz_datos[2][que_mes-1]/total)*100
        suma += porcentaje
        print(f"El sueldo de {empleado.nombre} representa el {porcentaje}% de los sueldos del mes {que_mes-1}")

def calcular_menor_sueldo_semestre(lista_empleados: list["Empleado"]):
    minimo = lista_empleados[0].matriz_datos[2][0]

    for e in range(len(lista_empleados)):
        empleado = lista_empleados[e]
        for i in range(6):#SEMESTRE
            sueldo_mensual = empleado.matriz_datos[2][i]
            if sueldo_mensual < minimo:
                minimo = sueldo_mensual
    print(f"El sueldo minimo es: {minimo}")
    print("Los empleados que tienen el sueldo minimo son:")
    for e in range(len(lista_empleados)):
        empleado = lista_empleados[e]
        for i in range(6):#SEMESTRE
            sueldo_mensual = empleado.matriz_datos[2][i]
            if sueldo_mensual == minimo:
                print(f"{empleado.nombre}")

def calcular_cantidad_meses_mayor_4millones(lista_empleados: list["Empleado"]):
    contador = 0
    for i in range(12): #mes
        suma_sueldos = 0
        for e in range(len(lista_empleados)): #empleado
            empleado = lista_empleados[e]      
            suma_sueldos += empleado.matriz_datos[2][i]
        if suma_sueldos > 4000000:
            contador += 1

    print(f"La cantidad de meses en donde se pago 4000000 o mas es: {contador}")

def ordenar_lista(lista_empleados: list["Empleado"]):#BURBUJEO CONVENCIONAL
    for i in range(len(lista_empleados)-1):
        for j in range(i+1, len(lista_empleados)):
            if lista_empleados[i].sueldo_anual > lista_empleados[j].sueldo_anual:
                empleado = lista_empleados[i]
                lista_empleados[i] = lista_empleados[j]
                lista_empleados[j] = empleado

def guardar_sueldos(lista_empleados: list["Empleado"]):
    ordenar_lista(lista_empleados)

    archivo = open("liquidacion.txt", "w")
    for e in range(len(lista_empleados)):
        empleado = lista_empleados[e]
        archivo.write(f"{empleado.nombre}: ${empleado.sueldo_anual}\n")
    archivo.close()

####################################################################

# 1. Obtiene nomina de empleados
nomina = obtener_nomina()
# 1. Pedir al usuario para cada empleado: cantidad de hs por mes, valor y calcular el sueldo mensual.
# lista_empleados: list['Empleado'] = cargar_datos_empleados_hardcodeo(empleados)

lista_empleados: list["Empleado"] = cargar_datos_empleados(nomina, 30)
# 2.Sueldo anual de cada empleado:
calcular_sueldo_anual(lista_empleados)

# 3. Suma de sueldos mensuales:
calcular_total_sueldos_mensuales(lista_empleados)

# 4. Maximo sueldo de cada mes
calcular_maximo_sueldo_mensual(lista_empleados)

# 5. Porcentaje que represaenta cada sueldo sobre el total de un mes especifico
calcular_porcentaje_sueldo(lista_empleados, 5)

# 6. Nombre del empleado que haya cobrado el menor sueldo en el primer semestre
calcular_menor_sueldo_semestre(lista_empleados)

# 7. Cantidad de meses en los que se haya pagado menos de $4 Millones en total de sueldos.
calcular_cantidad_meses_mayor_4millones(lista_empleados)

# 8. Guardar en el archivo liquidación.txt todos los sueldos anuales en forma ascendente.
guardar_sueldos(lista_empleados)