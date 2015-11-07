require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    return if include?(key)
    resize! if num_buckets <= count

    index = key.hash % num_buckets
    @store[index] << key
    @count += 1
  end

  def include?(key)
    index = key.hash % num_buckets
    @store[index].include?(key)
  end

  def remove(key)
    return unless include?(key)
    index = key.hash % num_buckets
    @store[index].delete(key)
    @count -= 1
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    temp_store = @store.flatten(1)
    @store = Array.new(num_buckets * 2) { Array.new }

    temp_store.each do |value|
      index = value.hash % num_buckets
      @store[index] << value
    end
  end
end
