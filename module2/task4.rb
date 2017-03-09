result = {}

vowels = %w(a e y o u i)

('a'..'z').each.with_index(1){|v,i| result[v] = i if vowels.include? v }

puts result
