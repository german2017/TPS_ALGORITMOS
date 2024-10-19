def merge_sort(arr):
    cantidad = 0
    if len(arr) > 1:
        mid = len(arr) // 2
        left_half = arr[:mid]
        right_half = arr[mid:]

        cantidad += merge_sort(left_half)
        cantidad += merge_sort(right_half)

        i = j = k = 0

        # Combinar las dos mitades
        while i < len(left_half) and j < len(right_half):
            if left_half[i] < right_half[j]:
                arr[k] = left_half[i]
                i += 1
            else:
                arr[k] = right_half[j]
                j += 1
            k += 1
            cantidad += 1  # Contamos cada vez que copiamos un valor

        # Copiar los elementos restantes del subarreglo izquierdo, si los hay
        while i < len(left_half):
            arr[k] = left_half[i]
            i += 1
            k += 1
            cantidad += 1  # Contamos cada vez que copiamos un valor

        # Copiar los elementos restantes del subarreglo derecho, si los hay
        while j < len(right_half):
            arr[k] = right_half[j]
            j += 1
            k += 1
            cantidad += 1  # Contamos cada vez que copiamos un valor

    return cantidad

################################################
import random
import time

arr = []  # Completar con los valores de su muestra. Pueden automatizar la carga.
for i in range(1000000):
    arr.append(random.randint(1, 100))  # Cambié a valores más variados para pruebas

start = time.time()
cantidad = merge_sort(arr)

end = time.time()
tiempo = (end - start) * 1000  # Tiempo en milisegundos
print("Tiempo de ejecución:", tiempo, "ms")
print("Cantidad de 'intercambios':", cantidad)
print(len(arr))

# print("Arreglo ordenado por merge sort:", arr)
