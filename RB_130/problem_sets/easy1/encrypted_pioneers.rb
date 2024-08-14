names = File.read('encryption.md')

def decrypt_names(names)
  arr_names = names.split("\n")
  hsh = {}
  alpha = (("a")..("z")).to_a

  alpha.map.with_index(1) { |char, i| hsh[char] = i }

    decyphered = arr_names.map do |name|
    name.chars.map do |char|
      next char if char.match?(/\W/)
      next_position = hsh[char.downcase] + 13

      next_char = hsh.key(next_position % 26)
      next_char
    end.join.split.map(&:capitalize)
  end
  decyphered.map { |sub_arr| sub_arr.join(' ')}
end

decrypt_names(names)

=begin
#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ 𝓟roblem ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄
# Decypher each name using the ROT13 algorithm
# The ROT13 algorithm replaces a letter with the 13th letter after it.

# the main difficulty of this problem is swinging around back to the start.
# One way to approach this is using modulo arithmetic revolutions % collection size.

# □ Empty spaces arent counted as part of the 13 skips only alphachars
 
#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Examples ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

#nqn ybirynpr
#"(a)bcdefghijklm(n)opqrstuvwxyz"
# a
#"abc(d)efghijklmnop(q)rstuvwxyz"
# d

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ DT ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

# Input of File md converted into an array of string names seperated by subarray of string names
# convert into inner chars
# Alpha chars string
# {} # convert into hash of alpha positions
# result string

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ ALgorithm ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

# ▣ Convert input file into array of sub-array names
    #["name", name, name]
  ▣ Access each name and downcase
  ▣ Convert alpha chars into hash of alpha char key & position value
    {a => 1, b => 2, c => 3}

  ▣ Access each name char and retrieve its equivalient alpha position
    alpha[b] => 2 
    □ Add 13 to current position to retrieve the 13 char from the stated  position capture that into a next_position variable
  ▣ retrieve next char value by passing next_positoin to hash
    hsh.key[next_position]
    □ capture that in a next_char variable
  ▣ Swap Chars
    □ access name sub-array
    □ replace next_char with current char


=end














