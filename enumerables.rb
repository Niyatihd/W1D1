require 'byebug'

class Array
  def my_each(&prc)
    i = 0
    while i < self.length
      prc.call(self[i])
      i += 1 
    end 

    self 
  end 

  def my_select(&prc)
    new_array = []
    self.my_each { |num| new_array << num if prc.call(num) }
    new_array
  end

  def my_reject(&prc)
    new_array = self.my_select(&prc)
    self - new_array
  end
  # def my_reject(&prc)
  #   new_array = []
  #   self.my_each { |num| new_array << num if !prc.call(num) }
  #   new_array
  # end

  def my_any?(&prc)
    self.my_each { |num| return true if prc.call(num) }
    false
  end

  def my_all?(&prc)
    self.my_each { |num| return false if prc.call(num) }
    true
  end
  
  def my_flatten
    @a_different_array = Array.new 
    # byebug 
    self.my_each do |ele|
      if ele.is_a?(Array)
        @a_different_array += ele.my_flatten
      else
        @a_different_array << ele
      end
    end

    @a_different_array
  end

  def my_zip(*args) 
    new_arr = Array.new(self.length) { Array.new(args.length+1) } 
    
    i = 0 
    self.my_each do |ele| 
      new_arr[i][0] = ele 
      i += 1 
    end 

    args.each_with_index do |arg, idx| # => idx = 0 
      j = 0 # => j = 0 
      arg.my_each do |ele| 
        if j < self.length 
          new_arr[j][idx+1] = ele # => new_arr[0][1] 
          j += 1 
        end 
      end 
    end 

    new_arr 
  end 

  def my_rotate(shift = 1)
    shift_idx = shift % self.length
    back = self[0...shift_idx]
    front = self[shift_idx..-1]
    front + back
  end

  def my_join(separator='') 
    new_str = ''
    
    i = 0
    self.my_each do |ele| 
      i == self.length - 1 ? new_str += ele : new_str += ele + separator 
      i += 1 
    end 

    new_str
  end 

  def my_reverse 
    new_array = []
    (self.length-1).downto(0) { |idx| new_array << self[idx] }
    new_array 
  end 
end

# array = [1,2,3,4,5]
# p array.my_each { |num| num * num }

# p array.my_select { |num| num > 2 }

# p array.my_reject { |num| num > 2 }

# p array.my_any? { |num| num > 2 }

# p array.my_all? { |num| num > 2 }

# p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten

a = [ 4, 5, 6 ]
b = [ 7, 8, 9 ]

p [1,2,3].my_zip(a, b) 
p a.my_zip([1,2], [8])
p [1, 2].my_zip(a, b)

c = [10, 11, 12]
d = [13, 14, 15]
p [1, 2].my_zip(a, b, c, d) 

# a = [ "a", "b", "c", "d" ]
# p a.my_rotate         #=> ["b", "c", "d", "a"]
# p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
# p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
# p a.my_rotate(15)     #=> ["d", "a", "b", "c"]

# a = [ "a", "b", "c", "d" ]
# p a.my_join         # => "abcd"
# p a.my_join("$")    # => "a$b$c$d"

# p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
# p [ 1 ].my_reverse               #=> [1]