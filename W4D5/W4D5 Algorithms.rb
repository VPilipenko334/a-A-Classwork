require 'benchmark'
require 'byebug'

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

# new_list = (1..10000).to_a.shuffle 

# puts "phase 2: #{Benchmark.measure{phase_2_my_min(new_list)}}" 

# puts "phase 1: #{Benchmark.measure{my_min(new_list)}}" 


def largest_contiguous_sum(arr) #78156297856218756829817657821 = n * n = n^2 * n = n^3
    #5, 3, -7]
    subs = []

    arr.each_with_index do |ele1,idx1| 
        (idx1+1...arr.length).each_with_index do |ele2, idx2| 
            subs << arr[idx1..idx2]
        end
    end
    #[[5],[5,3],[5,3,-7],[3,-7],[-7]]

    max = subs.first.sum #5

    subs.each do |sub|
        if sub.sum > max
            max = sub.sum
        end
    end
    max
end


# arr = [-5, -1, -3]

def phase_2_largest_contiguous_sum(arr)

    return [[]] if arr.empty?
    subs = arr.take(arr.count-1).phase_2_largest_contiguous_sum
    subs.concat(subs.map {|sub| sub + [last]})

    largest_sum = subs.first.sum 

    subs.each do |sub|
        current_sum = sub.sum 
        if current_sum > largest_sum
            largest_sum = current_sum
        end
    end

    largest_sum

end

arr = [5,3,-7]



def first_anagram?(word1,word2) 

    hash1 = Hash.new(0)
    hash2 = Hash.new(0)


    word1.each_char do |char|
        hash1[char] += 1
    end

    #########################

    word2.each_char do |char|
        hash2[char] += 1
    end
    hash1 == hash2

end

# puts first_anagram?("gizmo","sally")
# puts "#{Benchmark.measure{first_anagram?("gizmo", "sally")}}" 
# puts "#{Benchmark.measure{first_anagram?("elvis", "lives")}}" 

def second_anagram?(word1, word2) #elvis, lives
    
    word1.each_char do |char| #g #i 
        debugger
        if word2.split("").find_index(char) 
            idx = word2.split("").find_index(char) #["s", "a", "l", "l", "y"]
            word2.delete(word1[idx])
        end
    end

    return true if word2.empty? 

end 

# puts first_anagram?("gizmo","sally")
# puts first_anagram?("gizmowus","sallfday")
puts second_anagram?("elvis","lives")

# puts "#{Benchmark.measure{second_anagram?("gizmo", "sally")}}" 

# puts "#{Benchmark.measure{second_anagram?("elvis", "lives")}}" 

# puts "#{Benchmark.measure{second_anagram?("gizfkdshfkjsdhfjkdshfjkdshfjkdshmo", "salsdlkfhdsjkfdjksfhlkdshfklsly")}}" 