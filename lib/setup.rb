require "/Users/Stomp/Development/Ruby/nrp/nrp"
require 'mongoid'
require File.join(File.dirname(__FILE__), 'pso')
require File.join(File.dirname(__FILE__), 'pso_binary')
#require File.join(File.dirname(__FILE__), 'pso_binary_type1')
require File.join(File.dirname(__FILE__), 'pso_type1')

Mongoid.load!('/Users/Stomp/Development/Ruby/pso/lib/mongoid.yml', :test)

@max_v = 4.0
@min_v = -4.0

@n_particles = 200

@n_iterations = 200

@nrp_test_path = "/Users/Stomp/Development/Ruby/nrp/nrp-tests/"

def time
  start_time = Time.now
  yield
  end_time = Time.now
  end_time - start_time
end

class Array
  def average
    self.inject{|sum,el| sum + el}.to_f / self.size
  end
end

def average(n_runs,result_file_path)
  bests = Array.new(0)

  n_runs.times do |i|
    bests[i] = yield
  end

  puts "best = #{bests.max}"
  puts "bests = #{bests.to_s}"
  puts "bests average = #{bests.average}"

  if @result_file.nil? or @result_file.closed?
    @result_file = File.open(result_file_path,"a")
  end

  @result_file.puts "best = #{bests.max}"
  @result_file.puts "bests = #{bests.to_s}"
  @result_file.puts "bests average = #{bests.average}"
end
