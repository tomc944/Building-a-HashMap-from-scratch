class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    sum = 0
    each_with_index do |value, index|
      current = value.hash ^ (index + 1)
      sum += current
    end
    sum ^ 685041758907420958468234058492758902375
  end
end

class String
  def hash
    ascii_nums = self.split("").map do |char|
      char.ord
    end
    ascii_nums.hash ^ 7894025742905874392850432890583457

  end
end

class Hash
  def hash
    sum = 0
    self.each do |key, value|
      current = key.hash ^ value.hash
      sum += current
    end
    sum ^ 7890371589037590137571309857358490277
  end
end
