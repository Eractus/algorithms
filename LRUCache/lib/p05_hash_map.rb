require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable

  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    resize! if @count == num_buckets
    if self.include?(key)
      bucket(key).update(key, val)
    else
      bucket(key).append(key, val)
      @count += 1
    end
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    if self.include?(key)
      removed_key = bucket(key).remove(key)
      @count -= 1
      return removed_key
    end
  end

  def each
    @store.each do |bucket|
      bucket.each do |llist|
        yield [llist.key, llist.val]
      end
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    prev_store = @store
    @count = 0
    @store = Array.new(num_buckets * 2) { LinkedList.new }

    prev_store.each do |arr|
      arr.each do |llist|
        self.set(llist.key, llist.val)
      end
    end
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    @store[key.hash % num_buckets]
  end
end
