require 'battleships'

describe Battleships do

  subject(:game) { Battleships.new }
  let(:unfinished_board) { double('board', :finished? => false) }
  let(:finished_board) { double('board', :finished? => true) }

  it 'has 2 players' do
    expect(game.player1).to be_a Player
    expect(game.player2).to be_a Player
  end

  describe 'current_player' do
    it 'keeps track of the current player' do
      expect(game.current_player).to be_a Player
    end
  end

  describe '#game_over?' do
    it 'returns false if both players have unfinished boards' do
      allow(game.player1).to receive(:board).and_return(unfinished_board)
      allow(game.player2).to receive(:board).and_return(unfinished_board)
      expect(game).to_not be_game_over
    end
    it 'returns true if one of the boards is finished' do
      allow(game.player2).to receive(:board).and_return(finished_board)
      expect(game).to be_game_over
    end
  end

  describe '#switch_players' do
    it 'switches the players from 1 to 2' do
      expect{ game.switch_players }.to change{ game.current_player }.to(game.player2)
    end
    it 'switchs the players from 2 to 1' do
      game.switch_players
      game.switch_players
      expect(game.current_player).to eq game.player1
    end
  end

  describe '#opponent' do
    it 'returns player2 if current_player is player1' do
      expect(game.opponent).to eq game.player2
    end
    it 'returns player1 if current_player is player2' do
      game.switch_players
      expect(game.opponent).to eq game.player1
    end
  end

  describe '#winner' do
    before do
      allow(game.player1).to receive(:board).and_return(unfinished_board)
      allow(game.player2).to receive(:board).and_return(unfinished_board)
    end
    it 'returns nil if the game is not over yet' do
      allow(game).to receive(:game_over?).and_return(false)
      expect(game.winner).to eq nil
    end
    it 'returns player1 if player2\'s board is finished' do
      allow(game.player2).to receive(:board).and_return(finished_board)
      expect(game.winner).to eq game.player1
    end
    it 'returns player2 if player1\'s board is finished' do
      allow(game.player1).to receive(:board).and_return(finished_board)
      expect(game.winner).to eq game.player2
    end
  end

end
