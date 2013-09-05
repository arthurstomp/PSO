require File.join(File.dirname(__FILE__), 'spec_helper')

describe PSO do
  it 'should initialize' do
    n_particles = 100
    n_dimensions = 2
    fitness = Proc.new {|position|
      sum = 0
      position.each do |position_i|
        sum += position_i
      end
      sum
    }
    expect{PSO.new(n_particles, n_dimensions, fitness)}.not_to raise_error
  end

  context 'particles attribute' do
    before(:each) do
      @n_particles = 100
      @n_dimensions = 2
      @fitness = Proc.new {|position|
        sum = 0
        position.each do |position_i|
          sum += position_i
        end
        sum
      }
      @pso = PSO.new(@n_particles, @n_dimensions, @fitness)
    end
    it 'should have an array of particles' do
      @pso.particles.should be_instance_of Array
    end
    it 'should create n particles' do
      particles = @pso.create_particles(@n_particles)
      particles.should be_instance_of Array
      particles.size.should eq(@n_particles)
    end
    it 'should have set the right number of dimensions to every particles' do
      particles = @pso.create_particles(@n_particles)
      particles.each do |particle|
        particle.position.size.should eq(@n_dimensions)
      end
    end
    it 'should set particles attribute at initialization' do
      @pso.particles.should be_instance_of Array
      @pso.particles.size.should eq(@n_particles)
      @pso.particles.each do |particle|
        particle.should be_instance_of Particle
      end
    end
  end
  
  context 'evaluating particles' do
    before(:each) do
      @n_particles = 10
      @n_dimensions = 2
      @fitness = Proc.new {|position|
        sum = 0
        position.each do |position_i|
          sum += position_i
        end
        sum
      }
      @pso = PSO.new(@n_particles, @n_dimensions, @fitness)
    end
    it 'should set the best of every particle when create them' do
      @pso.particles.each do |particle|
        particle.best.should be_instance_of Best
      end
    end

    it 'should sum the value of the positions and set it as the best value' do
      @pso.particles.each do |particle|
        checksum = 0
        particle.position.each do |position_i|
          checksum += position_i
        end
        particle.best.value.should eq(checksum)
        particle.best.position.should eq(particle.position)
      end
    end
  end

  context 'Global best' do
    before(:each) do
      @n_particles = 10
      @n_dimensions = 2
      @fitness = Proc.new {|position|
        sum = 0
        position.each do |position_i|
          sum += position_i
        end
        sum
      }
      @pso = PSO.new(@n_particles, @n_dimensions, @fitness)
    end
    it 'should have a global best' do
      @pso.g_best.should_not be_nil
      @pso.g_best.should be_instance_of Best
    end
  end
end
