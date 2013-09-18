require File.join(File.dirname(__FILE__),'best')
class Particle 
  @@min_position = -5.0
  @@max_position = 5.0
  @@max_velocity = 1.0
  @@min_velocity = -@@max_velocity

  attr_reader :n_dimensions
  attr_accessor :position, :best, :velocity

  def initialize(n_dimensions)
    @n_dimensions = n_dimensions
    self.position = random_position
    self.velocity = random_velocity
  end

  def random_position
    random_position = Array.new(self.n_dimensions)
    n_dimensions.times do |i|
      position_i = range(0,@@max_position)
      random_position[i-1] = position_i
    end
    random_position
  end

  def random_velocity
    random_velocity = Array.new(self.n_dimensions)
    @n_dimensions.times do |i|
      velocity_i = range(0,@@max_velocity)
      velocity_i *= rand > 0.5 ? 1 : -1
      random_velocity[i-1] = velocity_i
    end
    random_velocity
  end

  def range (min, max)
    rand * (max-min) + min
  end

  def self.min_velocity
    @@min_velocity
  end

  def self.min_velocity=(new_min_velocity)
    @@min_velocity = new_min_velocity
  end

  def self.max_velocity
    @@max_velocity
  end

  def self.max_velocity=(new_max_velocity)
    @@max_velocity = new_max_velocity
  end

  def self.min_position
    @@min_position
  end

  def self.min_position=(new_min_position)
    @@min_position = new_min_position
  end

  def self.max_position
    @@max_position
  end

  def self.max_position=(new_max_position)
    @@max_position = new_max_position
  end
  
end
