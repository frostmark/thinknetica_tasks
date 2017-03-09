cart = {}

loop do
  print 'Введите название товара, либо команду "стоп" чтобы выйти: '
  good_name = gets.chomp
  break if good_name.downcase == 'стоп'

  print 'Введите цену товара: '
  good_price = gets.chomp.to_f

  print 'Введите кол-во товара: '
  good_quantity = gets.chomp.to_f


  cart[good_name] = {
    good_price: good_price,
    good_quantity: good_quantity
  }
end

total_price = 0

cart.each do |k, v|
  sum = v[:good_price] * v[:good_quantity]
  puts "Название #{k}, цена за единицу #{v[:good_price]}, кол-во #{v[:good_quantity]} сумма: #{sum}"
  total_price += sum
end

puts "=" * 40

puts "Итого: #{total_price}"