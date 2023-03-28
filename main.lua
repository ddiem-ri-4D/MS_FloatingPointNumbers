function get_buffer_writer(file_name)
    local file = io.open(file_name, "w")
    file:close()
    return io.open(file_name, "a")
end

buffered_writer = get_buffer_writer("./float/lua.txt")
a = 0x01000000  -- 2^24
b = 0x02000000  -- 2^25
print("a = ", a)
print("b = ", b)

start_time = os.time()
n = 0
for c = a, b do
    buffered_writer:write(string.format("c = %08d => %8.1f\n", c, c))
    buffered_writer:flush()

    if n == math.floor((c-a)*100/a) then
        n = n+1
        print(string.format("%d/100\n", n))
    end
end
stop_time = os.time()

print(stop_time - start_time)
buffered_writer:flush()
buffered_writer:close()
