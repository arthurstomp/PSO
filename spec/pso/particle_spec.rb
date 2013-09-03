require File.join(File.dirname(__FILE__),'../spec_helper')
describe Particle do
  it 'should initialize' do
    expect{Particle.new}.not_to raise_error
  end
end
