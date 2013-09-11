#!/Users/Stomp/.rvm/rubies/ruby-2.0.0-p195/bin/ruby
require File.join(File.dirname(__FILE__),'../lib/pso')

sphere_proc = Proc.new do |position|
  sphere_return = 0
  position.each do |position_i|
    sphere_return += position_i ** 2
  end
  next sphere_return
end

@dimensions = 1000

Particle.min_position = -5
Particle.max_position = 5

@pso = PSO.new(10,@dimensions,sphere_proc)
1000.times do
  @pso.explore!
end
puts @pso.g_best.value
1000.times do
  @pso.explore!
end
puts @pso.g_best.value
