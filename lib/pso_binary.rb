require File.join(File.dirname(__FILE__),'pso')

class PSO_Binary < PSO
  def s_function(velocity_i)
      1/(1+Math.exp(-velocity_i))
  end

  def new_position(position_i, velocity_i)
    s = s_function(velocity_i)
    if rand < s
      return 1
    else
      return 0
    end
  end
end
