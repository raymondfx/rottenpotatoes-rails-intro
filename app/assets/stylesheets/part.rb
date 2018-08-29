def sum arr
  # YOUR CODE HERE
          s1 = 0
        	arr.each {|a| s1+= a}
          return s1
end
#ar = [1,2,3,4,-5,5,-100]
#puts sum ar
#---------------------------------#
def max_2_sum arr
  # YOUR CODE HERE
          if arr.empty?
             return 0 
          end
          if arr.length == 1
            return arr[0] 
          end
          a = arr.sort
          a[-2] + a[-1]
end
#ar = [12,1,2,-3,7,2,-6,11]
#puts max_2_sum ar
#---------------------------------#
def sum_to_n? arr, n
  # YOUR CODE HERE
  unless arr.length > 1
    return false
  end
   h=Hash.new
   arr.each{|a|
      if h.key? a 
          return true else h[n-a] = n end}
      return false
end