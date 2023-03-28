import os
import time

def get_buffer_writer(file_name):
    file = open(file_name, "w")
    file.close()
    return open(file_name, "a")

if __name__ == '__main__':
    buffered_writer = get_buffer_writer("./float/python.txt")
    a = 0b00000001_00000000_00000000_00000000  # 2^24
    b = 0b00000010_00000000_00000000_00000000  # 2^25
    print("a = ", a)
    print("b = ", b)

    start_time = int(round(time.time() * 1000))
    n = 0
    for c in range(a, b+1):
        buffered_writer.write(f"c = {c:08d} => {float(c):8.1f}\n")
        buffered_writer.flush()

        if n == int(((c-a)*100/a)):
            n += 1
            print(f"{n}/100\n")
    stop_time = int(round(time.time() * 1000))

    print((stop_time - start_time))
    buffered_writer.flush()
    buffered_writer.close()
