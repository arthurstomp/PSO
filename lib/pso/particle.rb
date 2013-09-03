require File.join(File.dirname(__FILE__),'best')
class Particle 
  @@min = -5.0
  @@max = 5.0
  @@n_dimensions = 2

  attr_accessor :position
  def initialize
    self.position = self.class.random_position(2)
  end

  def self.random_position(n_dimensions)
    random_position = Array.new(n_dimensions)
    n_dimensions.times do |i|
      position_i = rand(@@max)
      position_i *= rand > 0.5 ? 1 : -1
      random_position[i-1] = position_i
    end
    random_position
  end
  
  def self.n_dimensions
    @@n_dimensions
  end
  def self.n_dimensions=(new_n_dimensions)
    @@n_dimensions = new_n_dimensions
  end
end
