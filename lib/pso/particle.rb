require 'mongoid'
require File.join(File.dirname(__FILE__),'best')
class Particle 
  include Mongoid::Document
  field :n_dimensions, type:Integer
  field :position, type:Array
  field :velocity, type:Array
  embeds_one :best
  embedded_in :pso

  def n_dimensions
    self[:n_dimensions]
  end

  def position
    self[:position]
  end

  def position=(new_position)
    self[:position] = new_position
  end

  def velocity
    self[:velocity]
  end

  def velocity=(new_velocity)
    self[:velocity] = new_velocity
  end
end

#Particle.delete_all
#p = Particle.create!(:n_dimensions => 1, :velocity => [1,1], :position => [1,1])
#p.create_best(:value => 1, :position => [1,1])
#puts p.to_json
