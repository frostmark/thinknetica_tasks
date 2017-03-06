print 'Введите свое имя: '
name = gets.chomp

print 'Введите свой рост(см): '
height = gets.chomp.to_i

ideal_weight = height - 110

if ideal_weight < 0
  puts "\n#{name}, ваш вес уже оптимальный"
else
  puts "\n#{name}, ваш идеальный вес равен #{ideal_weight} кг."
end