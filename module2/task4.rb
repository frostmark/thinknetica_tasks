result = {}

(('a'..'z').to_a - %w(a e y o u i)).each_with_index{|v, i| result[i+1] = v }

print result
