MONTHS = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

while true do
  print "Месяц: "
  month = gets.chomp.to_i
  unless month.between?(1, 12)
    puts "Доступны значения от 1 до 12"
    next
  end

  print "День: "
  day = gets.chomp.to_i

  unless day.between?(1, MONTHS[month - 1])
    puts "Такого дня нет"
    next
  end

  print "Год: "
  year = gets.chomp.to_i
  if year < 1
    puts "Год должен быть больше 1"
    next
  end

  break
end

def leap?(year)
  year % 400 == 0 || (year % 4 == 0 && year % 100 != 0)
end

def day_of_year(day, month, year)
  return day if month ==  1 # if January

  MONTHS[1] = 29 if leap? year # patch February if year leap

  MONTHS.take(month - 1).reduce(:+) + day
end

p day_of_year(day, month, year) # day_of_year(13, 31, 2000) => 366