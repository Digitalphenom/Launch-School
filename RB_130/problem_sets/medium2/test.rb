# It looks like the first step is to understand what method converts a given arguments to its octal equivalent.

# The `method` method takes a method symbol argument and returns a Method Object which is associated with the specific method passed as an argument. If we invoke to_proc on that object we get a lambda
# #<Proc:0x00007f15a0537a48 (lambda)>
# The question then is what is a lambda and what does it do?

# Without going into rabbit holes from what I know a lambda is a type of proc which is tied to a specific method. In this case its the custom method we've defined which is converted into a (Method Object). This has the effect of wrapping the functionality of our method into a (Method Object). If we then invoke to_proc on it we get a lambda/proc. Passing that lambda/proc as an argument to a method and prepending it with & ruby converts it into a block. The block then implicitly takes form of an expanded block passed to a method.

# * note the step of converting the method object into a lambda is not necessary. 


def convert_to_base(n)
  n.to_s(8).to_i
end

base8_lambda = method(:convert_to_base)
p base8_lambda

p [8, 10, 12, 14, 16, 33].map(&base8_lambda)


def convert_to_base_8(n)
  n.to_s(8).to_i
end

# ->

Proc.new { |n| n.to_s(8).to_i }
#when we use & to convert our Proc to a block, it expands out to...

# ->
[8, 10, 12, 14, 16, 33].map { |n| n.to_s(8).to_i }




