require_relative 'heap'

def k_largest_elements(array, k)
  array.each_index do |idx|
    BinaryMinHeap.heapify_up(array, idx, array.length)
  end
  ((array.length-1).downto(1)).to_a.each do |idx|
    array[0],array[idx] = array[idx],array[0]
    BinaryMinHeap.heapify_down(array, idx, idx)
  end
  array.reverse!
  ans = []
  k.times do |el|
    num = array.pop
    ans.unshift(num)
  end
  ans
end
