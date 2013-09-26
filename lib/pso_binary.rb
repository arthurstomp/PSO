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

  def random_position(n_dimensions)
    random_position = Array.new(n_dimensions)
    n_dimensions.times do |i|
      random_position[i-1] = rand > 0.5 ? 0 : 1
    end
    random_position
  end

  def evaluate_particles
    self.particles.each do |particle|
      fitness_value = self.fitness.call(particle.position)
      best = Best.new(fitness_value,particle.position.clone)
      if particle.best.nil? 
        particle.best = best
      end
      if best.value >= particle.best.value
        particle.best = best
      end
      if self.g_best.nil?
        self.g_best = best
      end
      if best.value >= self.g_best.value 
        self.g_best = best
      end
    end
  end

end
