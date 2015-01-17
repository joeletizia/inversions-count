require 'pry'

class InversionCounter

  def self.sort_and_count(array)
    array_length = array.length
    return [array, 0] if array_length == 1

    sorted_left, left_inversion_count = sort_and_count(array[0...array_length/2])
    sorted_right, right_inversion_count = sort_and_count(array[array_length/2...array_length])

    sorted_merge, split_inversions = merge_and_count_split(sorted_left, sorted_right)

    total_inversions = split_inversions + right_inversion_count + left_inversion_count
    [sorted_merge, total_inversions]
  end

  private

  def self.merge_and_count_split(left, right)
    i, j, inversion_count = [0, 0, 0]

    result_array = []

    while(i < left.length || j < right.length)
      if right[j].nil? || left[i] && left[i] < right[j]
        result_array << left[i]
        i += 1
      else
        result_array << right[j]
        j += 1
        inversion_count += left.length - i
      end
    end

    [result_array, inversion_count]
  end
end


class MergeSort
  def self.sort(array)
    return array if array.length == 1

    array_length = array.length
    left = sort(array[0...array_length/2])
    right = sort(array[array_length/2...array_length])

    merge(left,right)
  end

  private

  def self.merge(left, right)
    i, j = [0, 0]

    result_array = []

    while(i < left.length || j < right.length)
      if left[i] && left[i] < right[j]
        result_array << left[i]
        i += 1
      else
        result_array << right[j]
        j += 1
      end
    end

    result_array
  end
end


test_array = [1,3,5,2,4,6]

puts "Correct!" if MergeSort.sort(test_array) == [1,2,3,4,5,6]
puts "Correct!" if InversionCounter.sort_and_count(test_array) == [[1,2,3,4,5,6], 3]

array = []
file_content = File.open("./IntegerArray.txt", "r").each_line do |line|
  array << line.to_i
end

puts InversionCounter.sort_and_count(array)[1]


