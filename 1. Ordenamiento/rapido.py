def quick_sort(arr):
    cantidad_intercambios = [0]  # Usamos una lista para poder modificar el valor dentro de las funciones
    quick_sort_helper(arr, 0, len(arr) - 1, cantidad_intercambios)
    return cantidad_intercambios[0]

def quick_sort_helper(arr, low, high, cantidad_intercambios):
    if low < high:
        pivot_index = partition(arr, low, high, cantidad_intercambios)

        quick_sort_helper(arr, low, pivot_index - 1, cantidad_intercambios)
        quick_sort_helper(arr, pivot_index + 1, high, cantidad_intercambios)

def partition(arr, low, high, cantidad_intercambios):
    pivot = arr[high]
    i = low - 1

    for j in range(low, high):
        if arr[j] < pivot:
            i += 1
            arr[i], arr[j] = arr[j], arr[i]  # Intercambio
            cantidad_intercambios[0] += 1  # Incrementa el contador

    arr[i + 1], arr[high] = arr[high], arr[i + 1]  # Intercambio del pivote
    cantidad_intercambios[0] += 1  # Incrementa el contador
    return i + 1

################################################
import random
import time

arr = []  # Completar con los valores de su muestra. Pueden automatizar la carga.
for i in range(100000):
    arr.append(random.randint(1, 100))

start = time.time()
cantidad_intercambios = quick_sort(arr)

end = time.time()
tiempo = (end - start) * 1000  # Tiempo en milisegundos
print("Tiempo de ejecución:", tiempo, "ms")
print("Cantidad de intercambios:", cantidad_intercambios)

# print("Arreglo ordenado por quick sort:", arr)
