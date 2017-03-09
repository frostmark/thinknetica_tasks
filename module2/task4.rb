result = {}

vowels = %w(a e y o u i)

('a'..'z').to_a.each.with_index(1){|v,i| result[i] = v if vowels.include? v }

puts result
