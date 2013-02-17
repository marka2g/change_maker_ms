
class CoinSet < Array
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

  def remove_factors_of_others!
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
cs = [11, 9, 8, 5, 4, 1]
cs.reject! do |coin_to_reject|
puts("<@>" * 6)
 puts "coin_to_reject = #{coin_to_reject} in coins_set array -> #{cs}"
 cs.any? do |coin_to_test_against|
   puts "coin_to_test_against = #{coin_to_test_against}"
   if coin_to_reject < coin_to_test_against
     puts "coin_to_reject = #{coin_to_reject} is less than coin_to_test_against = #{coin_to_test_against}"
     coin_to_test_against % coin_to_reject == 0
     puts "coin_to_test_against % coin_to_reject == #{coin_to_test_against % coin_to_reject}"
     puts("<@>" * 6)
   end
 end
end