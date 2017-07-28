class Player

  attr_reader :name, :hand
  attr_accessor :pairs

  def initialize(name)
    @name = name
    @hand = []
    @pairs = []
  end

  def to_s
    "#{@name}"
  end

end
