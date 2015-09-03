class Object
  # https://hackage.haskell.org/package/base-4.8.1.0/docs/Data-List.html#v:unfoldr
  # 1.unfold do |x|
  #   [x*x, x+1] if x < 10
  # end
  # => [1, 4, 9, 16, 25, 36, 49, 64, 81]
  def unfold(&block)
    mab = block.call(self)
    if mab.nil?
      []
    else
      a,b = mab
      [a] + b.unfold(&block)
    end
  end
end
