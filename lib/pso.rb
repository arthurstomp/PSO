require File.join(File.dirname(__FILE__), 'pso/particle')
class PSO
  attr_reader :particles, :fitness, :g_best
  def initialize(n_particles,n_dimensions,fitness)
    @fitness = fitness
    initialize_particles(n_particles,n_dimensions)
  end

  def initialize_particles(n_particles,n_dimensions)
    set_particles_number_of_dimensions(n_dimensions)
    @particles = create_particles(n_particles)
    evaluate_particles
  end

  def create_particles(n_particles)
    particles = []
    n_particles.times do 
      particles << Particle.new
    end
    particles
  end

  def evaluate_particles
    self.particles.each do |particle|
      best = Best.new(self.fitness.call(particle.position),particle.position)
      particle.best = best if particle.best.nil? or best.value >= particle.best.value
      @g_best = best if @_best.nil? or best.value >= particle.best.value
    end
  end

  def set_particles_number_of_dimensions(n_dimensions)
    Particle.n_dimensions = n_dimensions
  end
  
end
