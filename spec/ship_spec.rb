require 'ship'

describe Ship do

  subject(:ship) { Ship.new(1, 2) }

  it 'is alive by default' do
    expect(ship).to be_alive
  end

  describe 'position' do
    it 'has an x and y coordinates' do
      ship = Ship.new(4, 5)
      expect(ship.position).to eq [4, 5]
    end
  end

  describe '#drown' do
    it 'tags the ship as not alive' do
      expect{ ship.drown }.to change{ ship.alive? }.to(false)
    end
  end

end
