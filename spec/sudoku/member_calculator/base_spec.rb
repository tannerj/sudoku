require 'spec_helper'

module Sudoku
module MemberCalculator
RSpec.describe Base do
  describe '#calc_members' do
    let(:base) { Base.new }
    it 'should raise NotImplememntedError' do
    expect { base.calc_members }.to raise_error(NotImplementedError)
    end
  end

  describe '#set_square_container' do
    let(:base) { Base.new }
    let(:square) { ::Sudoku::Square.new( id: 1 ) }
    it 'should raise NotImplementedError' do
      expect { base.set_square_container( square ) }.to raise_error(NotImplementedError)
    end
  end
end
end
end
