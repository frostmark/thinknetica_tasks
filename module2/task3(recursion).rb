# ограничение: работает до 9360 элемента(stack level too deep) 

def fibonacci(to, numbers=[0,1])
  length_numbers = numbers.length
  return numbers if length_numbers >= to
  numbers << numbers[length_numbers - 1] + numbers[length_numbers - 2]
  fibonacci(to, numbers)
end

p fibonacci(100)