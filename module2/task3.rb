def fibonacci(to, numbers=[0,1])
  loop do
    length_numbers = numbers.length
    break numbers if length_numbers >= to
    numbers << numbers[length_numbers - 1] + numbers[length_numbers - 2]
  end
  numbers
end

p fibonacci(100000)