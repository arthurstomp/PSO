#!/Users/Stomp/.rvm/rubies/jruby-1.7.4/bin/ruby

require File.join(File.dirname(__FILE__),'../lib/pso')
require 'java'
$CLASSPATH << '/Users/Stomp/Development/Java/benchmark/java_version'

@fitness = JavaUtilities.get_proxy_class('F2').new

@dimensions = @fitness.get_dimension

Particle.min_position = @fitness.get_min
Particle.max_position = @fitness.get_max

Particle.max_velocity = 0.018
Particle.min_velocity = -Particle.max_velocity

puts @fitness.get_dimension

@pso = PSO.new(80,@dimensions,@fitness.method(:compute).to_proc)
300000.times do 
  @pso.explore!
end
puts @pso.g_best.value
puts @pso.g_best.position.to_s
