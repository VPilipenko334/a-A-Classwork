require 'benchmark'

def my_min(list)
    new_list = list.dup 

    sorted = false 

    until sorted 
        sorted = true 

        (0...new_list.length - 1).each do |i|
            if new_list[i] > new_list[i + 1]
                new_list[i], new_list[i + 1] = new_list[i + 1], new_list[i]
                sorted = false 
            end
        end
    end 

    new_list.first 
end 

def phase_2_my_min(list)

    min = list.first 

    list.each do |ele|
        if ele < min 
            min = ele 
        end
    end 
    min 
end 

new_list = (1..10000).to_a.shuffle 

puts "phase 2: #{Benchmark.measure{phase_2_my_min(new_list)}}" 

puts "phase 1: #{Benchmark.measure{my_min(new_list)}}" 


