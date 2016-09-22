require 'app'

describe BattleshipsApp do

  subject(:app) { BattleshipsApp.new }

  describe '#start' do

    before do
      allow(app).to receive(:game_loop).and_return(true)
    end

    it 'prints the welcome message' do
      expect{ app.start }.to output(/#{BattleshipsApp::WELCOME_MESSAGE}/).to_stdout
    end

    it 'calls the game_loop method' do
      expect(app).to receive(:game_loop)
      app.start
    end

  end

  describe '#game_loop' do

    describe 'when the game is new' do
      it 'calls the ship_placement_loop because there are no ships placed yet' do
        expect(app).to receive(:ship_placement_loop)
        app.game_loop
      end
    end

    describe 'when the players are ready' do
      let(:game) { double('game', :game_over? => false, :switch_players => true, :winner => nil) }
      before do
        allow(app).to receive(:get_player_name).and_return('Player 1')
        allow(app).to receive(:loop).and_yield
        allow(app).to receive(:game).and_return(game)
        allow(app).to receive(:players_ready?).and_return(true)
      end
      it 'prints "HIT" message when the turn result was successful' do
        allow(app).to receive(:next_turn_result).and_return(true)
        message = /HIT! You get to go again!/
        expect{ app.game_loop }.to output(message).to_stdout
      end
      it 'prints "Miss" message when the turn result was unsuccessful' do
        allow(app).to receive(:next_turn_result).and_return(false)
        message = /Miss... Better luck next turn./
        expect{ app.game_loop }.to output(message).to_stdout
      end
    end

  end

end
