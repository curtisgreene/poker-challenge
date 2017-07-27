class Player

  attr_reader :name, :hand

  def initialize(name)
    @name = name
    @hand = []
  end

  def to_s
    "#{@name}"
  end

end
