require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @length = 0
    @capacity = 8
    @store = StaticArray.new(@capacity)
  end

  # O(1)
  def [](index)
    if @store[index] != nil
      @store[index]
    else
      raise ("index out of bounds")
    end
  end

  # O(1)
  def []=(index, value)
    if @capacity > index
      @store[index] = value
    else
      raise ("index out of bounds")
    end
  end

  # O(1)
  def pop
    if @length == 0
      raise ("index out of bounds")
    else
      @store[@length] = nil
      @length -= 1
    end
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    if @length < @capacity
      @store[@length] = val
      @length += 1
    else
      self.resize!
    end
  end

  # O(n): has to shift over all the elements.
  def shift
    if @length == 0
      raise ("index out of bounds")
    else
      @store[0] = nil
      @length.times do |i|
        @store[i] = @store[i+1]
      end
      @length -= 1
    end
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    @length.downto(0) do |i|
      @store[i+1] = @store[i]
    end
    @store[0] = val
    @length += 1
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    if @length == @capacity
      @capacity = @capacity * 2
      @new_store = StaticArray.new(@capacity)
      @length.times do |i|
        @new_store[i] = @store[i]
      end
    end
  end
end
