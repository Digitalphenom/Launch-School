=begin

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ 𝓟roblem ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

  Write a simple linked list implementation represented as a singly linked list.

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Examples ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

0 == list.size

should be true list.empty?

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Algorithm ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

 ▣ define size method
  □ method should return size of list
    ﹥ a list is composed of nodes that contain a data and a reference to the next node. Therefore we must count all nodes in the list to get the total size.
      ﹥ where are nodes stored within a list?
      ﹥ a list can only be accessed from the front (head) and traversed linearly. head retrieves the first node so you can begin counting from head until there are no more nodes
        □ determine if theres a chained node
          ﹥ access head => next. If nil? One node
          ﹥ if not nil, add to count and continue until nil.
          ﹥ if head is nil, list is empty return 0

 ▣ Define push method
  □ add node to list from the beginning of list
   [1, 2, 3] => (3,2,1)
   node is captured in head iv
   ﹥ if list is empty
    ﹥ create element object and add to head
      - element object should contain a datum & next (node)
    ﹥ if list is not empty
        ﹥ access the last node and add element to next reference
          ﹥ 



   ﹥ retrive values from end
        

=end

class Element
  attr_reader :datum, :next

  def initialize(datum, next_value = nil)
    @datum = datum
    @next = next_value
  end

  def tail?
    @next.nil?
  end

  attr_writer :next
end

class SimpleLinkedList
  attr_reader :head

  def initialize
    @head = nil
  end

  def size
    count = 0
    return count unless @head 
    count = 1
    current_head = @head

    until current_head.next.nil?
      count += 1
      current_head = current_head.next
    end
    count
  end
  
  def empty?
    size.zero? 
  end

  def push(element)
    current_head = @head
    new_element = Element.new(element)

    if current_head.nil?
      self.head = new_element
    else
      new_tail = current_head
      self.head = new_element
      self.head.next = new_tail
    end
    new_element.datum
  end

  def pop
    current_head = @head

    if current_head.next.nil?
      self.head = nil
    else
      new_head = current_head.next
      self.head = new_head
    end
    current_head.datum
  end

  def peek
    head.nil? ? nil : @head.datum
  end

  def self.from_a(arr)
    list = SimpleLinkedList.new
    return list if arr.nil?

    arr.reverse_each do |ele|
      list.push(ele)
    end
    list
  end

  def to_a
    array = []
    return array if empty?
    current_head = @head

    until current_head.next.nil?
      array << current_head.datum
      current_head = current_head.next
    end
    array << current_head.datum
  end
  
  def reverse
    current_head = @head
    new_list = SimpleLinkedList.new
    
    until current_head.next.nil?
      new_list.push(current_head.datum)
      current_head = current_head.next
    end
    new_list.push(current_head.datum)
    new_list
  end

  private

  attr_writer :head

end