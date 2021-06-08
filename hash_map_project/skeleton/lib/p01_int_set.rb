class MaxIntSet
  attr_reader :store, :max

  def initialize(max)
    @store = Array.new(max, false)
    @max = max
  end

  def insert(num)
    raise 'Out of bounds' if num > max || num < 0

    store[num] = true
  end

  def remove(num)
    store[num] = false
  end

  def include?(num)
    store[num] == true
  end

  private

  def is_valid?(num); end

  def validate!(num); end
end

class IntSet
  attr_reader :num_buckets

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { [] }
    @num_buckets = num_buckets
  end

  def insert(num)
    self[num].push(num) unless self[num].include?(num)
  end

  def remove(num)
    self[num].delete(num) if self[num].include?(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count, :prev_num_buckets

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { [] }
    @prev_num_buckets = num_buckets / 2
    @count = 0
  end

  def insert(num)
    unless include?(num)
      self[num].push(num)
      @count += 1
    end

    resize! if count > num_buckets
  end

  def remove(num)
    if include?(num)
      self[num].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    prev_store = @store
    @store = Array.new(num_buckets * 2) { [] }
    @count = 0

    prev_store.each do |bucket|
      bucket.each do |ele|
        insert(ele)
      end
    end
  end
end
