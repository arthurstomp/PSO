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
      particles = @pso.create_particles(@n_particles, @n_dimensions)
      particles.should be_instance_of Array
      particles.size.should eq(@n_particles)
    end
    it 'should have set the right number of dimensions to every particles' do
      particles = @pso.create_particles(@n_particles, @n_dimensions)
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
        sum = Float::INFINITY
        position.each do |position_i|
          sum -= position_i
        end
        sum
      }
      @pso = PSO.new(@n_particles, @n_dimensions, @fitness)
    end
    it 'should set the best of every particle when create them' do
      g_best = nil
      @pso.particles.each do |particle|
        particle.best.should be_instance_of Best
        g_best = particle.best.clone if g_best.nil? or g_best.value <= particle.best.value
      end
      @pso.g_best.value.should eq(g_best.value)
      @pso.g_best.position.should eq(g_best.position)
    end

    it 'should sum the value of the positions and set it as the best value' do
      @pso.particles.each do |particle|
        checksum = Float::INFINITY
        particle.position.each do |position_i|
          checksum -= position_i
        end
        particle.best.value.should eq(checksum)
        particle.best.position.should eq(particle.position)
      end
    end
  end

  it 'should have a global best' do
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
    @pso.g_best.should_not be_nil
    @pso.g_best.should be_instance_of Best
  end

  context 'particle exploration' do
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
    it 'exploration should change the velocity of a particle' do
      particle1_former_velocity = @pso.particles[0].velocity.clone
      @pso.change_particle_velocity(@pso.particles[0])
      @pso.particles[0].velocity.should_not eq(particle1_former_velocity)
      
    end
    it 'particle exploration should change particles position' do
      particles_former_positions = []
      @pso.particles.each do |particle|
        particles_former_positions << particle.position.clone
      end
      @pso.explore!
      @pso.particles.each do |particle|
        particle_index = @pso.particles.index(particle)
        particle.position.should_not eq(particles_former_positions[particle_index]) if particle.position != @pso.g_best.position
      end
    end
    it 'exploration should aim for the best position' do
      former_g_best = @pso.g_best.clone
      @pso.explore!
      @pso.g_best.value.should <= former_g_best.value
    end
  end
end
