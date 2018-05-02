require_relative 'p05_hash_map'

def can_string_be_palindrome?(string)
  hash = Hash.new(0)
  counter = 0
  string.chars.each do |char|
    hash[char] += 1
  end
  hash.each_value do |value|
    if value.odd?
      counter += 1
    end
  end
  return false if counter > 1
  true
end
