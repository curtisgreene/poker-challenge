class Game

  def initialize(num_of_players = 5, hand_size = 2)
    @players = num_of_players.times.collect{ |i| Player.new("Player #{i + 1}") } # the game is responsible for making players
    @hand_size = hand_size
    @deck = Deck.new
  end


  def find_pairs(players, community)
    players.each do |player|
      matching_cards = player.hand.select do |card| # just selects from the players hand
        community.collect(&:rank).include?(card.rank)
      end
      pairs = matching_cards.map do |card| # this card is in players hand
        community_match = community.find do |community_card|
          community_card.value == card.value
        end
        [card, community_match]
      end
      if pairs.length > 0
        puts "#{player} has these pairs: #{pairs.join(", ")}"   # what card in the palyers hand matches the community
      end
    end
  end

  def holding_pair(player)
    
  end

  def play
    @deck.shuffle
    @deck.deal(@players, @hand_size)
    @players.each do |player|
      puts "#{player} has: #{player.hand.join(", ")}"
    end
    community = @deck.community
    puts "Community cards are: #{community.join(", ")}"
    # community_values = community.collect(&:rank)
    find_pairs(@players, community)
  end

end
