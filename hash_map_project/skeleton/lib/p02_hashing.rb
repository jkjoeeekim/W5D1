class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    # self.object_id.hash
    self.join('0').to_i.hash
  end
end

class String
  def hash
    alpha = [*'a'..'z', *'A'..'Z', *'0'..'9']
    code = self.chars.map! { |char| alpha.index(char) }
    code.join.to_i.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    code = []
    alpha = [*'a'..'z', *'A'..'Z', *'0'..'9']
    sorted_keys = keys.sort
    sorted_values = values.sort
    sorted_keys.each do |key|
      code << [key].map { |ele| alpha.index(ele) }.join
    end
    sorted_values.each do |value|
      code << [value].map { |ele| alpha.index(ele) }.join
    end
    code.hash
  end
end
