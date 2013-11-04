require 'mongoid'
#Mongoid.load!('/Users/Stomp/Development/Ruby/pso/lib/mongoid.yml', :development)
require File.join(File.dirname(__FILE__),'best')
class Particle 
  include Mongoid::Document
  field :n_dimensions, type:Integer
  field :position, type:Array
  field :velocity, type:Array
  embeds_one :best

  def n_dimensions
    self[:n_dimensions]
  end

  def position
    self[:position]
  end

  def position=(new_position)
    self.update_attribute(:position, new_position)
  end

  def velocity
    self[:velocity]
  end

  def velocity=(new_velocity)
    self.update_attribute(:velocity, new_velocity)
  end

end
