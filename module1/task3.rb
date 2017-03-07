sides_triangle = []

(1..3).each do |x|
  print "Введите #{x} сторону треугольника: "
  sides_triangle << gets.chomp.to_f
end

sides_triangle.sort!.map!{|x| x*x}

if sides_triangle[0] == sides_triangle[1] && sides_triangle[1] == sides_triangle[2]
  puts "Треугольник равносторонний"
end

if sides_triangle[0] == sides_triangle[1] || sides_triangle[1] == sides_triangle[2] || sides_triangle[0] == sides_triangle[2]
  puts "Треугольник равнобедренный"
end

if sides_triangle[2] == sides_triangle[0..1].inject(&:+)
  puts "Треугольник прямоугольный"
end
