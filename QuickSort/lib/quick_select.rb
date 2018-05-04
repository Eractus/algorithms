#Write an in-place instance method on the Array class that will find the 'kth' smallest element in 'O(n)' time. You will likely want to use a partition method similar to that of QuickSort! For a bous, how can we eliminate any extra space cost.
class Array
  def quick_select(array, k)
    left = 0
    right = self.length - 1

    loop do
      return self[left] if left == right
      pivot_idx = Array.partition(self, left, right-left+1)
    end

    if k - 1 == pivot_idx
      return self[k - 1]
    elsif k - 1 < pivot_idx
      right = pivot_idx - 1
    else
      left = pivot_idx + 1
    end
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
