#!/Users/Stomp/.rvm/rubies/jruby-1.7.4/bin/ruby

require File.join(File.dirname(__FILE__),'../lib/pso')
require 'java'
$CLASSPATH << '/Users/Stomp/Development/Java/benchmark/java_version'

@VTR1 = 1e-2
@VTR2 = 1e-6
@VTR3 = 1e-10

@total_runs = 25

def successful_rate(vtr)
  
end

@fitness = JavaUtilities.get_proxy_class('F1').new

@dimensions = @fitness.get_dimension

Particle.min_position = @fitness.get_min
Particle.max_position = @fitness.get_max

Particle.max_velocity = 20.0
Particle.min_velocity = -20.0

puts @fitness.get_dimension

@pso = PSO.new(50,@dimensions,@fitness.method(:compute).to_proc)
3000000.times do 
  @pso.explore!
end
puts @pso.g_best.value
puts @pso.g_best.position.to_s
