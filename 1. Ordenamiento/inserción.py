def insertion_sort(arr):
    n = len(arr)
    cantidad = 0
    for i in range(1, n):
        key = arr[i]
        j = i - 1
        while j >= 0 and arr[j] > key:
            arr[j + 1] = arr[j]
            cantidad += 1
            j -= 1
        arr[j + 1] = key
    return cantidad

######################################################################

import random
import time

arr = [] # Completar con los valores de su muestra. Pueden automatizar la carga.
for i in range(100000):
    arr.append(random.randint(1, 10))

start = time.time()

cantidad = insertion_sort(arr)

end = time.time()

tiempo = (end-start) * 1000

print(tiempo)
print(cantidad)






