class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length <= 1

    pivot = rand(array.length)
    array[0], array[pivot] = array[pivot], array[0]
    left = array.select {|el| el < pivot}
    middle = array.select {|el| el == pivot}
    right = array.select {|el| el > pivot}

    QuickSort.sort1(left)
    QuickSort.sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    prc ||= Proc.new { |num1, num2| num1 <=> num2 }
    return array if length <= 1
    pivot = partition(array, start, length, &prc)
    left_length = pivot - start
    right_length = length - (left_length) + 1
    sort2!(array, start, pivot - start, &prc)
    sort2!(array, pivot + 1, length - pivot - 1, &prc)
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |num1, num2| num1 <=> num2 }
    barrier = start
    i = start
    while i < (length + start)
      if i == barrier
        i += 1
        next
      end
      if prc.call(array[i], array[start]) <= 0
        array[barrier + 1], array[i] = array[i], array[barrier + 1]
        barrier += 1
      end
      i += 1
    end
    array[start], array[barrier] = array[barrier], array[start]
    barrier
  end
end
