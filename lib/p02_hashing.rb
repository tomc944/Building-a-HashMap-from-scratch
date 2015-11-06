class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    if empty?
      return 685041758907420958468234058492758902375.hash
    end
    sum = 0
    each_with_index do |value, index|
      current = value % (index + 1)
      sum += current.hash
    end
    sum
  end
end

class String
  def hash
    ascii_nums = self.split("").map do |char|
      char.ord
    end
    ascii_nums.hash

  end
end

class Hash
  def hash
    if empty?
      return 7890371589037590137571309857358490277.hash
    end
    sum = 0
    self.each do |key, value|
      current = key.hash + value.hash
      sum += current
    end
    sum
  end
end
