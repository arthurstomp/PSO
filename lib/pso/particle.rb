require File.join(File.dirname(__FILE__),'best')
class Particle 
  @@min_position = -5.0
  @@max_position = 5.0
  @@min_velocity = -0.05
  @@max_velocity = 0.05

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
      position_i = rand(@@max_position)
      position_i *= rand > 0.5 ? 1 : -1
      random_position[i-1] = position_i
    end
    random_position
  end

  def random_velocity
    random_velocity = Array.new(self.n_dimensions)
    @n_dimensions.times do |i|
      velocity_i = rand(0..@@max_velocity*100)/100
      velocity_i *= rand > 0.5 ? 1 : -1
      random_velocity[i-1] = velocity_i
    end
    random_velocity
  end

  def self.min_velocity
    @@min_velocity
  end

  def self.max_velocity
    @@max_velocity
  end

  def self.max_position
    @@max_position
  end

  def self.min_position
    @@min_position
  end
  
end
