require_relative "heap"

class Array
  def heap_sort!
    # MinHeap
    self.each_index do |idx|
      BinaryMinHeap.heapify_up(self, idx, self.length)
    end
    ((self.length-1).downto(1)).to_a.each do |idx|
      self[0],self[idx] = self[idx],self[0]
      BinaryMinHeap.heapify_down(self, idx, idx)
    end
    self.reverse!
    self
    # MaxHeap
    # prc = Proc.new { |num1, num2| num2 <=> num1 }
    #
    # pointer = 0
    #
    # while pointer < self.length
    #   BinaryMinHeap.heapify_up(self, pointer, &prc)
    #   pointer += 1
    # end
    #
    # while pointer >= 0
    #   self[0], self[pointer]
    #   pointer -= 1
    #   BinaryMinHeap.heapify_down(self, pointer, &prc)
    # end
    # self
  end
end
