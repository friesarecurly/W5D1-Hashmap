class MaxIntSet
    attr_reader :max, :store
    def initialize(max)
        @max = max
        @store = Array.new(max, false)
    end

    def insert(num)
        raise "Out of bounds" if num < 0 || num > max-1
        @store[num] = true
    end

    def remove(num)
        raise "Out of Bounds" if num < 0 || num > max-1
        @store[num] = false
    end

    def include?(num)
        raise "Out of Bounds" if num < 0 || num > max-1
        @store[num]
    end

end


class IntSet
  attr_reader :max 

  def initialize(max)
    @max = max
    @store = Array.new(max) {Array.new}
  end
  
  def [](num)
    idx = num % @store.length
    @store[idx]
  end

  def insert(num)
    self[num] << num
  end


  def include?(num)
    self[num].include?(num)
  end

  def remove(num)
    self[num].delete(num) if self.include?(num)
  end
end

class ResizingIntSet < IntSet
  def num_buckets
      @store.length
  end

  def count
      @store.flatten.count
  end

  def insert(num)
    return if self.include?(num)  
    self.resize! if @store.length == count + 1
    self[num] << num
  end

  def resize!
      elements = @store.flatten
      @store = Array.new(@store.length * 2) {Array.new}
      elements.each {|ele| insert(ele)}
  end
end
