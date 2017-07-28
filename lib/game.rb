require 'pry'
class Game

  @pairs = []

  def initialize(num_of_players = 5, hand_size = 2)
    @players = num_of_players.times.collect{ |i| Player.new("Player #{i + 1}") } # the game is responsible for making players
    @hand_size = hand_size
    @deck = Deck.new
  end


  def find_pairs(players, community)
    players.each do |player|
      holding_pair(player)
      matching_cards = player.hand.select do |card| # just selects from the players hand
        community.collect(&:rank).include?(card.rank)
      end
      pairs = matching_cards.map do |card| # this card is in players hand
        player.pairs << card
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

  def community_pairs(community)
    community_hash = community.group_by(&:rank)
    community_hash.delete_if { | key, value | value.length < 2 }
    community_pairs =  community_hash.values
    legible_pairs = community_pairs.collect { |pair_array| "(#{pair_array[0]}, #{pair_array[1]})" }
    if legible_pairs.length == 0
      nil
    else
      puts "Community pairs are: #{legible_pairs.join(", ")}"
    end
  end

  def holding_pair(player)
    hand_hash = player.hand.group_by(&:rank)
    hand_hash.delete_if { | key, value | value.length < 2 }
    hand_pairs =  hand_hash.values
    legible_pairs = hand_pairs.collect { |pair_array|
    player.pairs << pair_array[0]
    "(#{pair_array[0]}, #{pair_array[1]})" }
    if legible_pairs.length == 0
      nil
    else
      puts "#{player.name} holds these pairs: #{legible_pairs.join(", ")}"
    end
  end

  def find_winner
    players_highest_pair =  @players.each_with_object({}) { |player, hash| hash[player.name] = player.pairs.max_by { |card| card.value } }
    players_highest_pair.delete_if { |player_name, card| !card }
    highest_card =  players_highest_pair.values.max_by { |card| card.value }
    winning_hand = players_highest_pair.select { |player_name, card| card.value == highest_card.value }
    if winning_hand.length == 0
      boring_art
      puts "🤷 No one wins, please be better 🤷"
    elsif winning_hand.length == 1
      winner_art
      puts "🎉🎉🎉 #{winning_hand.keys[0]} wins with a pair of #{winning_hand.values[0].rank}s! 🎉🎉🎉"
    else
      tie_art
      puts "✌️ #{winning_hand.keys.join(" & ")} tied with pairs of #{winning_hand.values[0].rank}s! ✌️"
    end
  end

  def play
    decorate
    opening_art
    decorate
    sleep(2.5) # pause for dramatic effect
    @deck.fisher_yates_shuffle
    @deck.deal(@players, @hand_size)
    @players.each do |player|
      puts "#{player} has: #{player.hand.join(", ")}"
    end
    decorate
    community = @deck.community
    puts "Community cards are: #{community.join(", ")}"
    decorate
    community_pairs(community)
    # community_values = community.collect(&:rank)
    find_pairs(@players, community)
    find_winner
    decorate
  end

end
