require File.join(File.dirname(__FILE__),'best')
class Particle 
  @@min_position = -5.0
  @@max_position = 5.0
  @@min_velocity = -0.05
  @@max_velocity = 0.05
  @@n_dimensions = 2

  attr_accessor :position, :best, :velocity
  def initialize
    self.position = self.class.random_position(self.class.n_dimensions)
    self.velocity = self.class.random_velocity
  end

  def self.random_position(n_dimensions)
    random_position = Array.new(n_dimensions)
    n_dimensions.times do |i|
      position_i = rand(@@max_position)
      position_i *= rand > 0.5 ? 1 : -1
      random_position[i-1] = position_i
    end
    random_position
  end

  def self.random_velocity
    random_velocity = Array.new(@@n_dimensions)
    @@n_dimensions.times do |i|
      velocity_i = rand(@@n_dimensions)
      velocity_i *= rand > 0.5 ? 1 : -1
      random_velocity[i-1] = velocity_i
    end
    random_velocity
  end
  
  def self.n_dimensions
    @@n_dimensions
  end
  def self.n_dimensions=(new_n_dimensions)
    @@n_dimensions = new_n_dimensions
  end
end
