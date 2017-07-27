class Card

  attr_reader :suit, :rank

  def initialize(suit, rank)
    @suit = suit
    @rank = rank
  end

  def to_s
    "#{@rank} of #{@suit}"
  end

  def value
    case @rank
    when "Ace"
      14
    when "King"
      13
    when "Queen"
      12
    when "Jack"
      11
    else
      @rank.to_i
    end
  end

end
