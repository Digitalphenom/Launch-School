# Further exploration
def compute(arg)
  return yield(arg) if block_given?
  'Does not compute.'
end

p compute(5) { |num| num * 10 }
pr = proc { 25 * 10 }
p compute(pr) { |proc| proc.call }
p compute(25)