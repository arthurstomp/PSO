#!/Users/Stomp/.rvm/rubies/ruby-2.0.0-p195/bin/ruby

require File.join(File.dirname(__FILE__),'../lib/pso')

@fitness = Proc.new do |position|
  result = 0
  position.each_with_index do |v,i|
    result += 0
  end
  next result
end

Particle.max_position = 100.0
Particle.min_position = -Particle.max_position

Particle.max_velocity = 50
Particle.min_velocity = -Particle.max_velocity

@dimensions = 9

puts "Dimension = #{@dimensions}"

@pso = PSO.new(50,@dimensions,@fitness)
3000.times do
  @pso.explore!
end

puts @pso.g_best.value
puts @pso.g_best.position.to_s

