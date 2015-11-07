require 'byebug'
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
    # debugger
    if include?(key)
      delete(key)
    end
    
    resize! if num_buckets < count

    bucket(key).insert(key, val)
    @count += 1
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    bucket(key).remove(key)
    @count -= 1
  end

  def each(&block)
    @store.each do |buckets|
      buckets.each do |link|
        block.call(link.key, link.val)
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
    temp_store = @store
    @store = Array.new(num_buckets * 2) { LinkedList.new }

    @count = 0
    temp_store.each do |bucket|
      bucket.each do |link|
        set(link.key, link.val)
      end
    end


  end

  def get_index(value)
    index = value.hash % num_buckets
  end

  def bucket(key)
    @store[get_index(key)]
    # optional but useful; return the bucket corresponding to `key`
  end
end
