class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = Array.new
    @prc = prc || Proc.new {|num1, num2| num1 <=> num2}
  end

  def count
    @store.count
  end

  def extract
    raise "no element to extract" if count == 0

    # @store[0],@store[count - 1] = @store[count - 1],@store[0]
    # extracted = @store.pop
    # BinaryMinHeap.heapify_down(@store, 0, count)
    # extracted

    val = @store[0]
    if count > 1
      @store[0] = @store.pop
      self.class.heapify_down(@store, 0, &prc)
    else
      @store.pop
    end
    val
  end

  def peek
    raise "no element to peek" if count == 0
    @store[0]
  end

  def push(val)
    @store.push(val)
    BinaryMinHeap.heapify_up(@store, count-1, count)
  end

  public
  def self.child_indices(len, parent_index)
    # child_indices = []
    # child_index_1 = 2 * parent_index + 1
    # child_indices << child_index_1 if child_index_1 < len
    # child_index_2 = 2 * parent_index + 2
    # child_indices << child_index_2 if child_index_2 < len
    # child_indices

    [2 * parent_index + 1, 2 * parent_index + 2].select do |idx|
      idx < len
    end
  end

  def self.parent_index(child_index)
    if child_index > 0
      (child_index - 1) / 2
    else
      raise ("root has no parent")
    end
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    # Grab the child indices
    # Collect the child values
    # Confirm that they obey the heap property
    # If not, find which child is smaller
    # Peform the swap between parent and smaller child
    # Heapify down again
    prc ||= Proc.new {|num1, num2| num1 <=> num2}

    #iteractive
    array.each_index do |idx|
      parent_idx = idx
      child_indices = child_indices(len, parent_idx)
      smaller_idx = child_indices[0]
      child_indices.each do |idx|
        if prc.call(array[idx], array[smaller_idx]) <= 0
          smaller_idx = idx
        end
      end
      break if smaller_idx.nil?
      if prc.call(array[parent_idx], array[smaller_idx]) == 1
        array[parent_idx],array[smaller_idx] = array[smaller_idx],array[parent_idx]
      end
    end
    return array

    # recursive
    l_child_idx, r_child_idx = child_indices(len, parent_idx)
    parent_val = array[parent_idx]
    children = []
    children << array[l_child_idx] if l_child_idx
    children << array[r_child_idx] if r_child_idx

    return array if children.all? { |child| prc.call(parent_val, child) <= 0 }

    swap_idx = nil
    if children.length == 1
      swap_idx = l_child_idx
    else
      swap_idx = prc.call(children[0], children[1]) == -1 ? l_child_idx : r_child_idx
    end

    array[parent_idx], array[swap_idx] = array[swap_idx], parent_val
    heapify_down(array, swap_idx, len, &prc)
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    # Parent index helper function to grab parent value, compare parent to the child
    # Parent is less than the child: return the array
    # Otherwise? Swap parent and values at their indices
    # Heapify up again, child idx is now parent idx

    prc ||= Proc.new {|num1, num2| num1 <=> num2}

    # iterative
    # (child_idx.downto(1)).to_a.each do |idx|
    #   parent_index = BinaryMinHeap.parent_index(idx)
    #   if prc.call(array[parent_index], array[idx]) == 1
    #     array[parent_index],array[idx] = array[idx],array[parent_index]
    #   end
    # end
    # return array

    # recursive
    return array if child_idx == 0

    parent_idx = parent_index(child_idx)
    child_val, parent_val = array[child_idx], array[parent_idx]

    if prc.call(child_val, parent_val) >= 0
      return array
    else
      array[child_idx], array[parent_idx] = array[parent_idx], array[child_idx]
      heapify_up(array, parent_idx, len, &prc)
    end
  end
end
