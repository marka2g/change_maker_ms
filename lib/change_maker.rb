require "lib/drawer"
require "lib/coin_set"

class ChangeMaker
  extend Drawer

  class << self
    def showing_output?; true; end

    def greedily(amount, coins = [25, 10, 5, 1])
draw("")
draw("Solving for #{amount} with set #{coins.to_s}")
      coins.sort!.reverse!
      coins.map do |coin|
draw("coin: #{coin.to_s}")
        number_to_use = amount / coin
draw("number_to_use : #{number_to_use.to_s}")
        amount %= coin
draw("amount : #{amount.to_s}")
        # set_of_this_coin = Array.new(number_to_use, coin)
        set_of_this_coin = Array.new(number_to_use)
draw("set_of_this_coin before fill: #{set_of_this_coin}")
        set_of_this_coin.fill(coin)
draw("set_of_this_coin after fill: #{set_of_this_coin}")
      end.flatten
    end

    def dynamically!(amount, coins = [25, 10, 5, 1])
binding.pry
draw("")
draw("Solving for #{amount} with set #{coins.to_s}")
      coin_set = CoinSet.new(coins)
draw("coin set before sort = #{coin_set}")
      coin_set.sort_largest_to_smallest!
draw("Sorted: #{coin_set.to_s}")

      coin_set.remove_items_larger_than_amount!(amount)
draw("Only coins smaller than #{amount}: #{coin_set.to_s}")

      coin_set.remove_factors_of_each_other!
draw("Removed factors of others: #{coin_set.to_s}")

      potential_solutions = coin_set.map do |coin|
# binding.pry
draw("Using #{coin} to make change for #{amount}")
        potential_solution = CoinSet.new(coin)
        potential_solution += dynamically!(amount - coin, coins)
        potential_solution.sort_largest_to_smallest!
      end

      potential_solutions.uniq!
      potential_solutions.reject! { |coin_set| coin_set.sum != amount }

      #
      potential_solutions.sort_by!(&:size)

draw("\nPotential Solutions: #{potential_solutions.to_s}", true)

      selected_solution = potential_solutions.first || CoinSet.new

draw("Selecting solution #{selected_solution.to_s}\n\n", true)
      selected_solution
    end
  end
end

  #   def dynamically(amount, coins = [25, 10, 5, 1])
  #     coin_set = CoinSet.new(coins)
  #     coin_set.sort_largest_to_smallest!
  #     coin_set.remove_items_larger_than_amount!(amount)
  #     coin_set.remove_factors_of_each_other!

  #     potential_solutions = coin_set.map do |coin|
  #       potential_solution = CoinSet.new(coin)
  #       potential_solution += dynamically(amount - coin, coins)
  #       potential_solution.sort_largest_to_smallest!
  #     end

  #     potential_solutions.uniq!
  #     potential_solutions.reject! { |coin_set| coin_set.sum != amount }
  #     potential_solutions.sort_by!(&:size)
  #     selected_solution = potential_solutions.first || CoinSet.new
  #     selected_solution
  #   end
  # end


## simple recursion
# def factorial(n)
#   if n > 1
#     puts "n = #{n}"
#     return factorial(n - 1) * n
#   else
#     puts "value of n in else/return: #{n}"
#     return 1
#   end
# end

# factorial(4) => 24

## recursion with data structure that tracks the recursion level
# def allFactorials(n)
#   results = Array.new( [n == 0 ? 1 : n] )
#   puts "BEFORE RECURSE - n = #{n} ||| results[level] = #{results[level]}"
#   doAllFactorials(n, results, 0)
#   puts "AFTER RECURSE - n = #{n} ||| results = #{results}"
#   return results
# end

# def doAllFactorials(n, results, level)
#   if n > 1
#     puts "IN RECURSE -> n = #{n} ||| level = #{level} |||results[level] = #{results[level]}"
#     results[level] = n * doAllFactorials(n -1, results, level + 1)
#     puts "results[level] = #{results[level]}"
#     return results[level]
#   else
#     return 1
#   end
# end

# allFactorials(4) => 24, 6, 2]