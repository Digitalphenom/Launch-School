NAMES = File.read('encryption.md')

def rot13(encrypted_name)
  encrypted_name.each_char.reduce('') do |result, char|
    result += decrypt_names(char)
  end
end

def decrypt_names(char)
  case char
  when "a".."m", "A".."M" then (char.ord + 13).chr
  when "n".."z", "N".."Z" then (char.ord - 13).chr
  else
    char
  end
end

NAMES.split("\n").each do |name|
   puts rot13(name)
end
