require File.join(File.dirname(__FILE__), 'pso/particle')
class PSO
  attr_accessor :g_best
  attr_reader :particles, :fitness 
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
      fitness_value = self.fitness.call(particle.position)
      best = Best.new(fitness_value,particle.position.clone)
      if particle.best.nil? 
        particle.best = best
      end
      if best.value <= particle.best.value
        particle.best = best
      end
      if self.g_best.nil?
        self.g_best = best
      end
      if best.value <= self.g_best.value 
        self.g_best = best
      end
    end
  end

  def update_particles_position
    update_particles_velocity
    self.particles.each do |particle|
      change_particle_position(particle)
    end
  end

  def change_particle_position(particle)
    particle.position.each_with_index do |position_i, dimension_index|
      new_position = new_position(position_i, particle.velocity[dimension_index])
      if new_position == Particle.min_position or new_position == Particle.max_position
        particle.velocity[dimension_index] = 0
      end
      particle.position[dimension_index] = new_position
    end
  end

  def new_position(position_i, velocity_i)
    new_position = position_i
    if position_i + velocity_i < Particle.min_position
      new_position = Particle.min_position
    elsif position_i + velocity_i > Particle.max_position
      new_position = Particle.max_position
    else
      new_position += velocity_i
    end
    new_position
  end

  def update_particles_velocity
    self.particles.each do |particle|
      change_particle_velocity(particle)
    end
  end

  def change_particle_velocity(particle)
    particle.velocity.each_with_index do |velocity_i,dimension_index|
      p_best_position_i = particle.best.position[dimension_index]
      p_position_i = particle.position[dimension_index]
      g_best_position_i = self.g_best.position[dimension_index]
      particle.velocity[dimension_index] = new_velocity(velocity_i, p_best_position_i, p_position_i, g_best_position_i)
    end
  end

  def new_velocity(former_velocity_i, p_best_position_i, p_position_i, g_best_position_i)
    new_velocity = former_velocity_i
    phi = random_factor
    v1 = phi[0] * (p_best_position_i - p_position_i)
    v2 = phi[1] * (g_best_position_i - p_position_i)
    if former_velocity_i + v1 + v2 > Particle.max_velocity
      new_velocity = Particle.max_velocity
    elsif former_velocity_i + v1 + v2 < Particle.min_velocity 
      new_velocity = Particle.min_velocity
    else
      new_velocity = former_velocity_i + v1 + v2
    end
    new_velocity
  end

  def random_factor
    r1 = range(0.0,4.1)
    r2 = range(0.0,4.1)
    begin
      r1 = range(0.0,4.1)
      r2 = range(0.0,4.1)
    end while r1 + r2 <= 4.1
    [r1,r2]
  end

  def range (min, max)
    rand * (max-min) + min
  end
  
end
