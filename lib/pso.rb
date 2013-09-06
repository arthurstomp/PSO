require File.join(File.dirname(__FILE__), 'pso/particle')
class PSO
  attr_reader :particles, :fitness, :g_best
  def initialize(n_particles,n_dimensions,fitness)
    @fitness = fitness
    initialize_particles(n_particles,n_dimensions)
  end

  def initialize_particles(n_particles,n_dimensions)
    @particles = create_particles(n_particles, n_dimensions)
    evaluate_particles
  end

  def create_particles(n_particles, n_dimensions)
    particles = []
    n_particles.times do 
      particles << Particle.new(n_dimensions)
    end
    particles
  end

  def explore!
    update_particles_position
    evaluate_particles
  end

  def evaluate_particles
    self.particles.each do |particle|
      best = Best.new(self.fitness.call(particle.position),particle.position)
      particle.best = best if particle.best.nil? or best.value >= particle.best.value
      @g_best = best if self.g_best.nil? or best.value >= self.g_best.value
    end
  end

  def update_particles_position
    update_particles_velocity
    self.particles.each do |particle|
      change_particle_position(particle)
    end
  end

  def change_particle_position(particle)
    particle.position.map! do |position_i|
      dimension_index = particle.position.index(position_i)
      if position_i + particle.velocity[dimension_index] < Particle.min_position
        position_i = Particle.min_position
      elsif position_i + particle.velocity[dimension_index] > Particle.max_position
        position_i = Particle.max_position
      else
        position_i += particle.velocity[dimension_index]
      end
    end
  end

  def update_particles_velocity
    self.particles.each do |particle|
      change_particle_velocity(particle)
    end
  end

  def change_particle_velocity(particle)
    particle.velocity.map! do |velocity_i|
      dimension_index = particle.velocity.index(velocity_i)
      new_velocity = velocity_i
      new_velocity += random_factor * (particle.best.position[dimension_index] - particle.position[dimension_index]) +
        random_factor * (self.g_best.position[dimension_index] - particle.position[dimension_index])
      if new_velocity < Particle.min_velocity
        new_velocity = Particle.min_velocity
      elsif new_velocity > Particle.max_velocity
        new_velocity = Particle.max_velocity
      end
      velocity_i = new_velocity
    end
  end

  def random_factor
    rand(0..1000)*1000.0
  end
  
end
