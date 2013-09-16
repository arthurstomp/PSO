#!/Users/Stomp/.rvm/rubies/ruby-2.0.0-p195/bin/ruby

require File.join(File.dirname(__FILE__),'../lib/pso')

@fitness = Proc.new do |position|
  result = 0
  position.each_with_index do |v,i|
    result += 10**6**(i-1/position.size-1)*v**2
  end
  next result
end

Particle.max_position = 100.0
Particle.min_position = -Particle.max_position

Particle.max_velocity = 50
Particle.min_velocity = -Particle.max_velocity

@dimensions = 7
@n_iterations = 300

puts "Number of Dimensions = #{@dimensions}"
puts "Max velocity = #{Particle.max_velocity} Min velocity = #{Particle.min_velocity}"
puts "Number of Iterations = #{@n_iterations}"

@pso = PSO.new(100,@dimensions,@fitness)
@n_iterations.times do
  @pso.explore!
end

puts "Global optimum = #{@pso.g_best.value}"
puts "Global optimum position = #{@pso.g_best.position.to_s}"

