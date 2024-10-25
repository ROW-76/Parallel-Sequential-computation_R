from multiprocessing import (Pool)
import multiprocessing
import time
# Define a custom function:timeconsumingfun
def timeconsumingfun(x):
    time.sleep(5)
    return x
workers= 4
if __name__ == "__main__":
    # Computing Serial
    n = int(input("n: "))
    #Calculating the time consumed for serial
    start_time_0 = time.perf_counter()
    for i in range(n):
        timeconsumingfun(i)
    time_serial = time.perf_counter() - start_time_0
    print("Serial:", time_serial)

    #computing Parallel
    start_time_1= time.perf_counter()
    pool = multiprocessing.Pool(workers)  # Creating a pool of worker processes
    results = pool.map(timeconsumingfun, range(n))
    time_parallel = time.perf_counter() - start_time_1
    print("Parallel:", time_parallel)

    # Calculate speedup
    speedup = time_serial / time_parallel
    print("Speedup:", speedup)
    efficiency = speedup / workers *100
    print('Efficiency:', efficiency)