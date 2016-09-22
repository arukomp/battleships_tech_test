require 'board'

describe Board do

  subject(:board) { Board.new }
  let(:ship) { double('ship', :alive? => true) }
  let(:dead_ship) { double('dead_ship', :alive? => false) }

  describe 'initialization' do
    it 'has a maximum number of ships' do
      expect(board.max_ships).to eq Board::MAX_NUM_OF_SHIPS
    end
    it 'can set a different amount of max ships' do
      board = Board.new(10)
      expect(board.max_ships).to eq 10
    end
  end

  describe '#full?' do
    it 'returns false if the board is not full yet' do
      expect(board).to_not be_full
    end
    it 'returns true if the board already has a maximum amount of ships' do
      allow(board).to receive(:ships).and_return([ship, ship, ship, ship, ship])
      expect(board).to be_full
    end
  end

  describe '#ships' do
    it 'returns an empty array by default' do
      expect(board.ships).to eq []
    end
    it 'does not allow somebody else modify it' do
      ships = board.ships
      ships = "something"
      expect(board.ships).to eq []
    end
  end

  describe '#finished?' do
    it 'returns true if all the ships on the board are dead' do
      allow(board).to receive(:ships).and_return([dead_ship, dead_ship])
      expect(board).to be_finished
    end
    it 'returns false if there still are some alive ships on the board' do
      allow(board).to receive(:ships).and_return([dead_ship, ship])
      expect(board).to_not be_finished
    end
  end

  describe '#place_ship' do
    let(:position) { [2, 1] }
    it 'creates a new ship and places it at the specified position' do
      board.place_ship(position)
      expect(board.ships[0].position).to eq position
    end
    it 'does not allow placing a ship if the board is already full' do
      allow(board).to receive(:full?).and_return(true)
      expect{ board.place_ship(position) }.to_not change{ board.ships }
    end
    it 'does not allow placing a ship out of bounds (10x10)' do
      err_msg = "Ship must be placed within the board's boundaries."
      expect{ board.place_ship([11,2]) }.to raise_error err_msg
      expect{ board.place_ship([-2, -4]) }.to raise_error err_msg
    end
    it 'does not allow placing a ship where another ship already exists' do
      allow(ship).to receive(:position).and_return([1, 2])
      allow(board).to receive(:ships).and_return([ship])
      expect{ board.place_ship([1, 2]) }.to raise_error("Another ship is already at this position.")
    end
  end

end
