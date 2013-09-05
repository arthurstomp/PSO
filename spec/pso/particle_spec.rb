require File.join(File.dirname(__FILE__),'../spec_helper')
describe Particle do
  it 'should initialize' do
    expect{Particle.new(2)}.not_to raise_error
  end

  it 'should generate a random position' do
    particle = Particle.new(2)
    particle.random_position.should be_instance_of Array
    particle.random_position.size.should eq(2)
  end

  it 'should have the number of dimensions where it will fly' do
    p1 = Particle.new(2)
    p2 = Particle.new(2)
    p1.n_dimensions.should eq(2)
    p2.n_dimensions.should eq(2)
  end

  context 'position attribute' do
    before(:each) do 
      @particle = Particle.new(2)
    end
    it 'should have a position' do
      @particle.position.should be_instance_of Array
    end
    it 'should be able to change it position' do
      @particle.position = [1,0]
    end
  end

  context 'velocity attribute' do
    before(:each) do 
      @particle = Particle.new(2)
    end
    it 'should have a random velocity after initialization' do
      @particle.velocity.should_not be_nil
      @particle.velocity.size.should eq(@particle.n_dimensions)
    end
  end

end
