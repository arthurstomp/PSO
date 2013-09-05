require File.join(File.dirname(__FILE__),'../spec_helper')
describe Particle do
  it 'should initialize' do
    expect{Particle.new}.not_to raise_error
  end

  it 'class should generate a random position' do
    Particle.random_position(2).should be_instance_of Array
    Particle.random_position(2).size.should eq(2)
  end

  context 'class attribute n_dimensions' do
    it 'should have the number of dimensions where it will fly' do
      Particle.n_dimensions.should be_instance_of Fixnum
      Particle.n_dimensions.should eq(2)
      p1 = Particle.new
      p2 = Particle.new
      p1.class.n_dimensions.should eq(2)
      p2.class.n_dimensions.should eq(2)
    end
    it 'should be able to set the number of dimensions of the class' do
      p1 = Particle.new
      p2 = Particle.new
      Particle.n_dimensions = 3
      Particle.n_dimensions.should eq(3)
      p1.class.n_dimensions.should eq(3)
      p2.class.n_dimensions.should eq(3)
    end
  end

  context 'position attribute' do
    before(:each) do 
      @particle = Particle.new
    end
    it 'should have a position' do
      @particle.position.should be_instance_of Array
    end
    it 'should be able to change it position' do
      @particle.position = [1,0,0]
    end
  end

  context 'velocity attribute' do
    before(:each) do 
      @particle = Particle.new
    end
    it 'should have a random velocity after initialization' do
      @particle.velocity.should_not be_nil
      @particle.velocity.size.should eq(Particle.n_dimensions)
    end
  end

end
