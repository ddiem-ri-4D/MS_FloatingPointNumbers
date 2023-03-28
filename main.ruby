def get_buffer_writer(file_name)
  file = File.new(file_name, 'w')
  file.truncate(0) if file
  file
end

buffered_writer = get_buffer_writer('./float/java.txt')
a = 0b00000001_00000000_00000000_00000000 # 2^24
b = 0b00000010_00000000_00000000_00000000 # 2^25
puts "a = #{a}"
puts "b = #{b}"

start_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)
n = 0
(a..b).each do |c|
  buffered_writer.write(sprintf("c = %08d => %8.1f\n", c, c.to_f))
  buffered_writer.flush

  if n == ((c-a)*100/a).to_i
    n+=1
    puts sprintf("%d/100\n", n)
  end
end
stop_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)

puts ((stop_time - start_time) * 1000).round(2)
buffered_writer.flush
buffered_writer.close
