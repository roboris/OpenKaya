require File.expand_path("system", File.dirname(__FILE__))
require File.expand_path("strategies/simplepoint", File.dirname(__FILE__))
require 'benchmark'

=begin

  To add a new rating system simulation:
    1. write the algorithm in a #{algorithms name}.rb inside "strategies"
    2. add corresponding require as seen for simple point at the top of this file
    3. call method run_simulation
  That's it!

=end

def sample_data_set
  set = []
  set << {:white_player => "pepe",:black_player => "carlos",:winner => "W"}
end

def assert(boolean)
  raise "Expected #{boolean} to be true" unless boolean
end

def run_simulation(strategy, data_set)
  system = System.new(strategy)

  time = Benchmark.measure {
                            data_set.each do |result|
                              system.add_result(result)
                            end
                           }
  system.results_to_file(time)

end

def read_data_set(filename)
  set = []
  File.open(filename, "r") do |infile|
    while (line = infile.gets)
      w = line.split(",")[0]
      b = line.split(",")[1]
      winner = line.split(",")[2]
      set << {:white_player => w, :black_player => b, :winner => winner.chomp}
    end
  end
  
return set
end

run_simulation(SimplePoint, read_data_set("data/sample_data.txt"))