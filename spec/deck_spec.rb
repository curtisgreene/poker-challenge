require 'require_all'
require_all 'lib'

RSpec.describe Deck do
  it 'has 52 cards' do
    deck = Deck.new
    expect(deck.cards.length).to eq(52)
  end


  it 'deal 5 cards for the #community' do
    deck = Deck.new
    community = deck.community
    expect(community.length).to eq(5)
  end

  # it 'can be shuffled' do 


end
