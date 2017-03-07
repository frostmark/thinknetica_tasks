print "A: "
a = gets.chomp.to_f

print "B: "
b = gets.chomp.to_f

print "C: "
c = gets.chomp.to_f

d = b ** 2 - (4 * a * c)

if d > 0
  
  d_sqrt = Math.sqrt(d)
  x_1 = (-b + d_sqrt) / (2 * a)
  x_2 = (-b - d_sqrt) / (2 * a)

  puts "Дискриминант #{d}. Два корня: #{x_1} и #{x_2}"
end

if d == 0
  x_1 = -b / 2 * a

  puts "Дискриминант #{d}. Один корень: #{x_1}" 
end

if d < 0 
  puts "Корней нет"
end