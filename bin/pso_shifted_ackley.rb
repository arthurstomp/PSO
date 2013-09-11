#!/Users/Stomp/.rvm/rubies/jruby-1.7.4/bin/ruby

require File.join(File.dirname(__FILE__),'../lib/pso')
require 'java'
$CLASSPATH << '/Users/Stomp/Development/Java/benchmark/java_version'

@fitness = JavaUtilities.get_proxy_class('F1').new

@dimensions = @fitness.get_dimension

Particle.max_position = @fitness.get_max
Particle.min_position = @fitness.get_min

Particle.max_velocity = 20.0
Particle.min_velocity = -Particle.max_velocity

puts "Benchmark dimension = #{@dimensions}"

@pso = PSO.new(80,@dimensions,@fitness.method(:compute).to_proc)
300.times do 
  @pso.explore!
end
puts @pso.g_best.value
puts @pso.g_best.position.to_s
