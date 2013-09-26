require File.join(File.dirname(__FILE__),'best')
class Particle 

  attr_reader :n_dimensions
  attr_accessor :position, :best, :velocity

  def initialize(n_dimensions, random_position, random_velocity)
    @n_dimensions = n_dimensions
    self.position = random_position
    self.velocity = random_velocity
  end

end
