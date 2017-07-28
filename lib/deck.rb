
class Deck

  attr_reader :cards

  def initialize
    @suits = ["Spades", "Clubs", "Hearts", "Diamonds"]
    @ranks = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King", "Ace"]
    @cards = []
    @suits.each do |suit|
      @ranks.each do |rank|
        @cards << Card.new(suit, rank)
      end
    end
  end

  def compare(card_a, card_b)
    card_a.value > card_b.value ? card_a : card_b
  end

  def fan
    @cards.each { |card| card }
  end

  # def shuffle
  #   @cards.shuffle!
  # end

  def fisher_yates_shuffle  # big O(n) -- faster than built in shuffle
    counter = @cards.length - 1
    while counter > 0
      # item selected from the unshuffled part of array
      random_index = rand(counter)
      # swap the items at those locations
      @cards[counter], @cards[random_index] = @cards[random_index], @cards[counter]
      # de-increment counter
      counter -= 1
    end
    @cards
  end

  def deal(players, hand_size)
    hand_size.times do |i|
      players.each do |player|
        player.hand << @cards.shift
      end
    end
  end

  def community # a deck no long stores the 'community' as an instance variable, that is the game's responsibility now
    5.times.collect{ @cards.shift }
  end
end
