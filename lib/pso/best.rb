require 'mongoid'
class Best
  include Mongoid::Document
  embedded_in :particle
  field :value, type:Integer
  field :position, type:Array
  attr_reader :value, :position
  def value
    self[:value]
  end
  def position
    self[:position]
  end
end
