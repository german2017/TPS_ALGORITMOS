def bubble_sort(arr):
    cantidad = 0    
    n = len(arr)
    for i in range(n):
        for j in range(0, n-1):
            if arr[j] > arr[j+1]:
                cantidad += 1
                arr[j], arr[j+1] = arr[j+1], arr[j]

    return cantidad

import random
import time
arr = []  # Completar con los valores de su muestra. Pueden automatizar la carga.

for i in range(100000):
    arr.append(random.randint(1, 10))

start = time.time()
cantidad = bubble_sort(arr)
end = time.time()
tiempo = (end-start) * 1000

print(tiempo)
print(cantidad)


