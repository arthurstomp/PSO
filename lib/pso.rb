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
      fitness_value = self.fitness.call(particle.position)
      best = Best.new(fitness_value,particle.position)
      particle.best = best if particle.best.nil? or best.value <= particle.best.value
      @g_best = best if self.g_best.nil? or best.value <= self.g_best.value
      puts "fitness = #{fitness_value} position = #{particle.position.to_s}"
      puts "g best = #{self.g_best.value} g best position = #{self.g_best.position.to_s}"
      gets
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
      particle.position[dimension_index] = new_position(position_i, particle.velocity[dimension_index])
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
    elsif former_velocity_i + v1 + v2 > Particle.min_velocity 
      new_velocity = Particle.min_velocity
    else
      new_velocity = former_velocity_i + v1 + v2
    end
    new_velocity
  end

  def random_factor
    r1 = rand(4.1)
    r2 = rand(4.1)
    begin
      r1 = rand(4.1)
      r2 = rand(4.1)
    end while r1 + r2 <= 4.1
    [r1,r2]
  end
  
end
