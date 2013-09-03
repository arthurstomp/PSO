require File.join(File.dirname(__FILE__),'../spec_helper')
describe Best do
  it 'should initialize' do
    expect{Best.new(10,[1,0,0])}.not_to raise_error
  end
  it 'should have a value' do
    value = 10
    position = [1,0,0]
    Best.new(value,position).value.should eq(value)
  end
  it 'should have a position' do
    value = 10
    position = [1,0,0]
    Best.new(value,position).position.should eq(position)
  end
end
