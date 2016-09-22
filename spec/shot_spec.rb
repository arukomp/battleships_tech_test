require 'shot'

describe Shot do

  let(:ship) { double('ship', :position => [1, 2], :drown => true) }
  let(:board) { double('board', :ships => [ship]) }
  subject(:shot) { Shot.new(board, [1,2]) }

  describe '#miss?' do
    it 'returns false if the ship has been hit' do
      expect(shot).to_not be_miss
    end
    it 'returns true if no ship has been hit' do
      new_shot = Shot.new(board, [2, 6])
      expect(new_shot).to be_miss
    end
  end

  it 'should drown the ship if hit' do
    expect(ship).to receive(:drown)
    Shot.new(board, [1, 2])
  end

end
