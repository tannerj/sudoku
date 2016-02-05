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
end
end
end
