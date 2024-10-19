import random
class Empleado:
    def __init__(self, nombre):
        self.nombre = nombre
        self.sueldo_anual = 0
        matriz = []
        for i in range(3):
            fila = [0] * 12 # 12 meses
            matriz += [fila]
        self.matriz_datos = matriz 

        # for j in range(6):
        #     self.matriz_datos[0][j] = random.randint(10,20)
        # for j in range(6):
        #     self.matriz_datos[1][j] = random.randint(1000,5000)
        # for j in range(6):
        #     self.matriz_datos[2][j] = self.matriz_datos[0][j] * self.matriz_datos[1][j]
        #     self.sueldo_anual += self.matriz_datos[2][j]
        
