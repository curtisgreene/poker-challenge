require 'require_all'
require_all 'lib'

RSpec.describe Card do

  it 'with a face knows its value' do
    card = Card.new("Spades", "Ace")
    expect(card.value).to eq(14)
  end

  it 'should know its rank by number' do
    card = Card.new("Hearts", "3")
    expect(card.value).to eq(3)
  end

end
