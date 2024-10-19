def shell_sort(arr):
    cantidad = 0
    n = len(arr)
    gap = n // 2  

    while gap > 0:
        for i in range(gap, n):
            key = arr[i]
            j = i

            while j >= gap and arr[j - gap] > key:
                arr[j] = arr[j - gap]
                cantidad += 1
                j -= gap
            arr[j] = key
        gap //= 2  
    return cantidad
import time
import random

arr = [] # Completar con los valores de su muestra. Pueden automatizar la carga.
for i in range(10000):
    arr.append(random.randint(1, 100))

start = time.time()
cantidad = shell_sort(arr)
end = time.time()

tiempo = (end-start) * 1000

print(f"tiempo:{tiempo}")
print(f"cantidad:{cantidad}")