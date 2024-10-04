=begin

# Create a singly linked list where an element is its own class that instantiates instances which contains data and a `next` field pointing to the next element in the list of elements.
  ▣ element may contain a range of data ie 1-10
  ▣ element should provide methods to reverse the linked list
  ▣ element should provide method to convert linked list to and array to array to linked list

  ▣ each element in a singly linked list is an object that 
  ▣ An element and simplelinkedlist class are nested within a larger LinkedList class

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ examples◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄


  ▣ element.datum
   ﹥ a datum instance method returns the first ele?
  ▣ element.tail?
  ﹥ returns true if truthy value
 ▣ element.next 
  ﹥returns the next el

  ▣ element2 = Element.new(2, element1)
    element can take more than one arg

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ DS ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄
  Input: Integer
  [1,2,3]
  Output: integer

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Algo ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

▣ create a element class
  ﹥ accept variable number of args
  ﹥ captures those arguments in an array
▣ define a datum im
  ﹥ retrieves the value from a node (sub_arr)
▣ Define a tail? im
  ﹥ returns true if truthy, false otherwise
▣ define a next im
  ﹥ access the next nodule (sub_arr)

▣ Create a simplelinkedlist class
  ﹥ initializes a list in form of array
  ﹥ Instantiates element instances into list

▣ Has the basic methods that arrays have access to
  ﹥ Custom methods include
    □ Peek
      ﹥ peek method retrieves size of head node if non entire array
      ﹥ returns nil if list is empty
    □ from_a()
      ﹥ insert specified arg into list
      ﹥ requires one argument 
    □ push
      ﹥ push receives values which are passed to an element instances and captured into a list as element instances
      ﹥ the order of elements is LIFO
        □ if one element is pushed return element
        □ if head contains more than one element
          ﹥ access initial element and capture in a new_tail lv
          ﹥ access new element and capture in new_head lv
          ﹥ perform swap
            ﹥ reasign old head with new head
            ﹥ access new heads next ele & place new tail
    □ reverse
      ﹥ capture current head

      ﹥ access the tail of current head & capture it
      ﹥ access second to last and set to nil

      ﹥ replace head with new_tail
      
      ﹥ head should now have one less element
      ﹥ repeat but replacing heads next ele with new tail
=end

class Element
  attr_accessor :next, :datum

  def initialize(datum, next_ele = nil)
    @datum = datum
    @next = next_ele
  end

  def tail?
    @next.nil?
  end
end

class SimpleLinkedList
  attr_reader :head

  def initialize
    @head = nil
  end

  def self.from_a(array)
    list = SimpleLinkedList.new
    return list unless array

    array.reverse_each { |ele| list.push(ele) }
    list
  end

  def to_a
    return [] if empty?
    result = []
    current = @head

    loop do
      result << current.datum
      current = current.next
      break if current.nil?
    end
    result
  end

  def reverse
    current = @head
    new_list = SimpleLinkedList.new

    loop do 
      new_list.push(current.datum)
      current = current.next
      break unless current
    end
    new_list
  end

  def push(data)
    new_element = Element.new(data, @head)
    @head = new_element
  end

  def size
    current = @head
    size = 0

    while current
      size += 1
      current = current.next
    end
    size
  end

  def empty?
    @head.nil?
  end

  def peek
    @head.datum if @head
  end

  def pop
    removed_head = @head
    new_head = @head.next
    @head = new_head

    removed_head.datum
  end

  private 

  attr_writer :head
end



