require 'player'

describe Player do

  subject(:player) { Player.new }
  let(:player2) { Player.new }

  it 'has a board' do
    expect(player.board).to be_a Board
  end
  it 'has a history of moves' do
    expect(player.history).to eq []
  end

  describe '#ready?' do
    it 'returns false if the board isn\'t full yet (not ready)' do
      expect(player).to_not be_ready
    end
    it 'returns true if the board is filled with ships (ready to play)' do
      allow(player.board).to receive(:full?).and_return(true)
      expect(player).to be_ready
    end
  end

  describe '#shoot' do

    let(:ship) { double('ship', :position => [1, 2], :drown => true) }
    let(:board) { double('board', :ships => [ship]) }
    before { allow(player2).to receive(:board).and_return(board) }

    it 'adds the shot to the history' do
      expect{ player.shoot(player2, [1, 2]) }.to change{ player.history }
    end
    it 'returns true if the shot was successful' do
      expect(player.shoot(player2, [1, 2])).to eq true
    end
    it 'returns false if the shot was a miss' do
      expect(player.shoot(player2, [2, 2])).to eq false
    end
    it 'does not allow shooting outside of the boundaries' do
      err_msg = "Cannot shoot outside the boundaries."
      expect{ player.shoot(player2, [11, 2]) }.to raise_error err_msg
      expect{ player.shoot(player2, [-2, -4]) }.to raise_error err_msg
    end

  end

end
