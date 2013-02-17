
class CoinSet < Array
  extend Drawer

  def initialize(coin_set = [])
    coin_set = [coin_set].flatten
    super(coin_set.dup)
  end

  def sort_largest_to_smallest!
    sort! { |coin_a, coin_b| coin_b <=> coin_a }
  end

  def sort_largest_to_smallest
    sort { |coin_a, coin_b| coin_b <=> coin_a }
  end

  def remove_items_larger_than_amount!(threshold)
    reject! { |coin| coin > threshold }
  end

  def remove_items_larger_than_amount(threshold)
    reject { |coin| coin > threshold }
  end

  def remove_factors_of_each_other!
    reject! do |coin_to_reject|
      any? do |coin_to_test_against|
        if coin_to_reject < coin_to_test_against
          coin_to_test_against % coin_to_reject == 0
        end
      end
    end
  end

  def sum
    inject(0, :+)
  end

  def +(other_set)
    CoinSet.new(super(other_set))
  end
end


# modulo ony works when first num is larger that second,
# otherwise, no remainder
# cs = [11, 10, 9, 8, 6, 5, 4, 2, 1]
# cs.reject! do |coin_to_reject|
#   cs.any? do |coin_to_test_against|
#     if coin_to_reject < coin_to_test_against
#       coin_to_test_against % coin_to_reject == 0
#     end
#   end
# end
# puts "coin_set now = #{cs}" => [11, 10, 9, 8, 6]

# this algo below doesn't return the mutated coin set.
# extend Drawer
# cs = [11, 10, 9, 8, 6, 5, 4, 2, 1]
# cs.reject! do |coin_to_reject|
#  draw("the coin set now = #{cs}")
#  draw("<@>"* 6)
#  draw("<in reject! block>")
#  draw("coin_to_reject = #{coin_to_reject} in coins_set array -> #{cs}")
#  cs.any? do |coin_to_test_against|
#    draw("<in any? block>")
#    draw(" coin_to_reject = #{coin_to_reject} |||| coin_to_test_against = #{coin_to_test_against} ")
#    draw("is #{coin_to_reject} less than #{coin_to_test_against}?")
#    draw("No, MOVE ON!!!") if coin_to_reject >= coin_to_test_against
#    if coin_to_reject < coin_to_test_against
#      draw("yes")
#      draw("so, coin_to_test_against(#{coin_to_test_against}) % coin_to_reject(#{coin_to_reject}) = #{coin_to_test_against % coin_to_reject}")
#      draw("coin_to_test_against % coin_to_reject does not == 0, it equals #{coin_to_test_against % coin_to_reject} MOVE ON!!!") if coin_to_test_against % coin_to_reject != 0
#      draw("#{coin_to_test_against} % #{coin_to_reject} does = 0, remove #{coin_to_reject} from list!!!") if coin_to_test_against % coin_to_reject == 0
#      coin_to_test_against % coin_to_reject == 0
#    end
#  end
#  draw("<number in coin set = #{cs.count} >")
#  draw("<@>" * 12)
# end

