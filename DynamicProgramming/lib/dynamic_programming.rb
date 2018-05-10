class DynamicProgramming
  attr_accessor :blair_cache, :frog_cache
  def initialize
    @blair_cache = { 1 => 1, 2 => 2 }
    @frog_cache = { 1 => [[1]], 2 => [[1, 1], [2]], 3 => [[1, 1, 1], [1, 2], [2, 1], [3]] }
    @maze_cache = {}
  end

  def blair_nums(n)
    # top-down
    # return blair_cache[n] unless blair_cache[n].nil?
    #
    # ans = blair_nums(n-1) + blair_nums(n-2) + (2 * (n-1) - 1)
    # blair_cache[n] = ans
    # return ans

    # bottom-up
    blair_cache = blair_cache_builder(n)
    blair_cache[n]
  end

  def blair_cache_builder(n)
    blair_cache = { 1 => 1, 2 => 2 }
    return blair_cache if n < 3

    (3..n).each do |num|
      blair_cache[num] = blair_cache[num - 1] + blair_cache[num - 2] + (2 * (num-1) - 1)
    end
    blair_cache
  end

  def frog_hops_bottom_up(n)
    frog_cache = frog_cache_builder(n)
    frog_cache[n]
  end

  def frog_cache_builder(n)
    frog_cache = { 1 => [[1]], 2 => [[1, 1], [2]], 3 => [[1, 1, 1], [1, 2], [2, 1], [3]] }
    return frog_cache if n < 4

    (4..n).each do |step|
      one_step_back = frog_cache[step-1].map { |move| move + [1] }
      two_step_back = frog_cache[step-2].map { |move| move + [2] }
      three_step_back = frog_cache[step-3].map { |move| move + [3] }
      frog_cache[step] = one_step_back + two_step_back + three_step_back
    end
    frog_cache
  end

  def frog_hops_top_down(n)
    frog_hops_top_down_helper(n)
  end

  def frog_hops_top_down_helper(n)
    return frog_cache[n] unless frog_cache[n].nil?

    one_step_back = frog_hops_top_down(n-1).map { |move| move + [1] }
    two_step_back = frog_hops_top_down(n-2).map { |move| move + [2] }
    three_step_back = frog_hops_top_down(n-3).map { |move| move + [3] }
    current_step_moves = one_step_back + two_step_back + three_step_back
    frog_cache[n] = current_step_moves
    return current_step_moves
  end

  def super_frog_hops(n, k)
    k = n if k > n
    return frog_cache[n] unless frog_cache[n].nil?

    current_step_moves = []
    n.downto(2) do |step|
      if k >= n - step + 1
        current_step_moves += super_frog_hops(step - 1, k).map { |move| move + [n - step + 1] }
        current_step_moves += super_frog_hops(step - 1, k).map { |move| [n - step + 1] + move }
      end
    end
    frog_cache[n] = current_step_moves.uniq
  end

  def knapsack(weights, values, capacity)
    return nil if capacity < 0 || weights.length == 0
    solution_table = knapsack_table(weights, values, capacity)
    solution_table[capacity][-1]
  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)
    solution_table = []

    # Build solutions for knapsacks of increasing capacity

    (0..capacity).each do |current_capacity|
      solution_table[current_capacity] = []
      # Go through the weights one by one by index
      (0...weights.length).each do |current_item_idx|
        if current_capacity == 0
          # If the capacity is zero, then 0 is the only value that can be placed into this slot
          solution_table[current_capacity][current_item_idx] = 0
        elsif current_item_idx == 0
          # For the first item in our list we can check for capacity
          # If our weight < capacity, put zero, otherwise put value
          solution_table[current_capacity][current_item_idx] = weights[0] > current_capacity ? 0 : values.first
        else
          # The first option is the entry considering the previous item at this capacity
          option1 = solution_table[current_capacity][current_item_idx - 1]
          # The second option (assuming enough capacity) is the maximized value of the smaller bag
          option2 = current_capacity < weights[current_item_idx] ? 0 : solution_table[current_capacity - weights[current_item_idx]][current_item_idx - 1] + values[current_item_idx]
          # Choose max of these options
          optimum = [option1, option2].max
          solution_table[current_capacity][current_item_idx] = optimum
        end
      end
    end
    solution_table
  end

  def maze_solver(maze, start_pos, end_pos)
    @maze_cache[start_pos] = nil
    queue = [start_pos]

    until queue.empty?
      current = queue.pop
      break if current = end_pos

      get_moves(maze, current).each do |move|
        @maze_cache[move] = current
        queue << move
      end
    end

    @maze_cache.include?(end_pos) ? path_from_cache(end_pos) : nil
  end

  def get_moves(maze, pos)
    x, y = pos
    moves = []
    directions = [[1, 0], [-1, 0], [0, 1], [0, -1]]

    directions.each do |direction|
      next_pos = [x + direction[0], y + direction[1]]

      if is_valid_pos?(maze, next_pos)
        moves << next_pos unless @maze_cache.include?(next_pos)
      end
    end

    moves
  end

  def is_valid?(maze, pos)
    x, y = pos
    x >= 0 && y >= 0 && x < maze.length && y < maze.first.length && maze[x][y] != "X"
  end

  def path_from_cache(end_pos)
    path = []
    current = end_pos

    while current
      path.unshift(current)
      current = @maze_cache[current]
    end
    path
  end

  def max_sum_to_leaf(node)
    if node.right.nil? &&  node.left.nil?
      return node.value
    elsif node.left && nod.right.nil?
      max_sum_to_leaf(node.left) + node.value
    elsif node.right && node.left.nil?
      max_sum_to_leaf(node.right) + node.value
    else
      [max_sum_to_leaf(node.left), max_sum_to_leaf(node.right)].max + node.value
    end
  end
end
