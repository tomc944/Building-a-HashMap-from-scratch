require 'byebug'

class Link
  attr_accessor :key, :val, :next

  def initialize(key = nil, val = nil, nxt = nil)
    @key, @val, @next = key, val, nxt
  end

  def to_s
    "#{@key}, #{@val}"
  end
end

class LinkedList
  include Enumerable
  attr_reader :head

  def initialize
    @head = Link.new
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    return nil if empty?
    current_link = first

    until current_link.next.nil?
      current_link = current_link.next
    end

    current_link
  end

  def empty?
    first.nil?
  end

  def get(key)
    return nil unless include?(key)
    self[key].val
  end

  def include?(key)
    self[key].nil? ? false : true
  end

  def insert(key, val)
    if empty?
      @head.next = Link.new(key, val)
    else
      last.next = Link.new(key, val)
    end

  end

  def remove(key)
    if first.key == key
      @head.next = first.next
      return
    end

    current = select { |link| link.key == key}.first
    previous = select {|link| link.next == current}.first

    previous.next = current.next

  end

  def each(&block)
    current_link = first
    until current_link.nil?
      block.call(current_link)
      current_link = current_link.next
    end
  end

  def each_with_index(&block)
    current_link = first
    until current_link.nil?
      index = current_link.key
      block.call(current_link, index)
      current_link = current_link.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
