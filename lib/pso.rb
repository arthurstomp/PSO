require File.join(File.dirname(__FILE__), 'pso/particle')
#Mongoid.load!('/Users/Stomp/Development/Ruby/pso/lib/mongoid.yml', :development)
require 'mongoid'
class PSO
  include Mongoid::Document
  embeds_one :g_best, :class_name => "Best" , inverse_of: :pso
  embeds_many :particles
  field :min_position, :type => Float, :default => -5.0
  field :max_position, :type => Float, :default => 5.0
  field :max_velocity, :type => Float, :default => 1.0
  field :min_velocity, :type => Float, :default => -1.0
  attr_accessor :fitness 
  def initialize(attrs = nil, options = nil)
    super
    self.fitness = options[:fitness]
    initialize_particles(attrs[:n_particles], attrs[:n_dimensions])
  end

  def initialize_particles(n_particles,n_dimensions)
    create_particles(n_particles, n_dimensions)
    evaluate_particles
  end

  def create_particles(n_particles, n_dimensions)
    n_particles.times do 
      self.particles << Particle.new(:n_dimensions => n_dimensions, :position => random_position(n_dimensions), :velocity => random_velocity(n_dimensions))
    end
  end

  def random_position(n_dimensions)
    random_position = Array.new(n_dimensions)
    n_dimensions.times do |i|
      position_i = range(0,self.max_position)
      random_position[i-1] = position_i
    end
    random_position
  end

  def random_velocity(n_dimensions)
    random_velocity = Array.new(n_dimensions)
    n_dimensions.times do |i|
      velocity_i = range(0,self.max_velocity)
      velocity_i *= rand > 0.5 ? 1 : -1
      random_velocity[i-1] = velocity_i
    end
    random_velocity
  end

  def explore!
    update_particles_position
    evaluate_particles
  end

  def evaluate_particles
    self.particles.each do |particle|
      fitness_value = self.fitness.call(particle.position)
      best = Best.new(:value => fitness_value,:position => particle.position.clone)
      particle.best = best.clone if particle.best.nil? or best.value <= particle.best.value
      self.g_best = best.clone if self.g_best.nil? or best.value <= self.g_best.value
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
      if new_position == self.min_position or new_position == self.max_position
        particle.velocity[dimension_index] = 0
      end
      particle.position[dimension_index] = new_position
    end
  end

  def new_position(position_i, velocity_i)
    new_position = position_i
    if position_i + velocity_i < self.min_position
      new_position = self.min_position
    elsif position_i + velocity_i > self.max_position
      new_position = self.max_position
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
    if former_velocity_i + v1 + v2 > self.max_velocity
      new_velocity = self.max_velocity
    elsif former_velocity_i + v1 + v2 < self.min_velocity 
      new_velocity = self.min_velocity
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

  def min_velocity
    self[:min_velocity]
  end

  def min_velocity=(new_min_velocity)
    self.update_attribute(:min_velocity, new_min_velocity)
  end

  def max_velocity
    self[:max_velocity]
  end

  def max_velocity=(new_max_velocity)
    self.update_attribute(:max_velocity, new_max_velocity)
  end

  def min_position
    self[:min_position] 
  end

  def min_position=(new_min_position)
    self.update_attribute(:min_position, new_min_position)
  end

  def max_position
    self[:max_position]
  end

  def max_position=(new_max_position)
    self.update_attribute(:max_position,new_max_position)
  end
end

#foo = Proc.new{
#  10
#}
#
#PSO.delete_all
#Particle.delete_all
#Best.delete_all
#p = PSO.create!({:n_dimensions => 2, :n_particles => 2}, {:fitness => foo})
#10.times{p.explore!}
#o = PSO.first
#o.fitness = foo
#o.explore!
#
#puts o.to_json
