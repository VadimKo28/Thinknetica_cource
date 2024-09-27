words = "а".."я"

vowels_words = ["а", "у", "о", "и", "э", "ы", "я", "ю", "е", "ё"]

result_hash = {}

words.each_with_index do |word, index|
  result_hash[word] = index + 1 if vowels_words.include?(word)
end

puts result_hash