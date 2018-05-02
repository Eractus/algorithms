class MaxIntSet
  def initialize(max)
    @length = max
    @store = Array.new(@length)
  end

  def insert(num)
    if is_valid?(num) == true
      @store[num] = true
    else
      raise ("Out of bounds")
    end
  end

  def remove(num)
    if is_valid?(num) == true
      @store[num] = false
    else
      raise ("Out of bounds")
    end
  end

  def include?(num)
    if is_valid?(num) == true
      if @store[num] == true
        return true
      else
        return false
      end
    else
      raise ("Out of bounds")
    end
  end

  private

  def is_valid?(num)
    if num >= 0 && num < @length
      return true
    else
      return false
    end
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num].push(num)
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if @count == num_buckets
      resize!
    end
    self[num].push(num)
    @count += 1
  end

  def remove(num)
    self[num].delete(num)
    @count -= 1
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_buckets = num_buckets() * 2
    @new_store = Array.new(new_buckets) { Array.new }
    @store.each do |arr|
      arr.each do |int|
        @new_store[int % new_buckets].push(int)
      end
    end
    @store = @new_store
  end
end
