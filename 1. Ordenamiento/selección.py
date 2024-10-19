def selection_sort(arr):
    n = len(arr)
    cantidad_intercambios = 0  # Inicializamos el contador de intercambios
    for i in range(n):
        min_idx = i
        for j in range(i+1, n):
            if arr[j] < arr[min_idx]:
                min_idx = j
        # Si el índice del mínimo no es igual a `i`, hacemos el intercambio
        if min_idx != i:
            arr[i], arr[min_idx] = arr[min_idx], arr[i]
            cantidad_intercambios += 1  # Incrementamos el contador

    return cantidad_intercambios  # Retornamos la cantidad de intercambios


import time
import random

arr = [] # Completar con los valores de su muestra. Pueden automatizar la carga.
for i in range(10000):
    arr.append(random.randint(1, 100))

start = time.time()
cantidad = selection_sort(arr)
end = time.time()

tiempo = (end-start) * 1000

print(f"tiempo:{tiempo}")
print(f"cantidad:{cantidad}")

