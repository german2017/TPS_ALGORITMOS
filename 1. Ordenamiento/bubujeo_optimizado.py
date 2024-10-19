def bubble_sort_opt(arr):
    n = len(arr)
    cantidad = 0
    for i in range(n):
        for j in range(0, n-i-1):
            if arr[j] > arr[j+1]:
                cantidad += 1
                arr[j], arr[j+1] = arr[j+1], arr[j]
    return cantidad

import time
import random

arr = [] # Completar con los valores de su muestra. Pueden automatizar la carga.
for i in range(100):
    arr.append(random.randint(1, 100))

start = time.time()
cantidad = bubble_sort_opt(arr)
end = time.time()
tiempo = (end-start) * 1000

print(tiempo)
print(cantidad)


