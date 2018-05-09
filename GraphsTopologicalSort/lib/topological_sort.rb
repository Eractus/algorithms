require_relative 'graph'

# Implementing topological sort using both Khan's and Tarjan's algorithms

def topological_sort(vertices)
  # Khan's algorithm
  sorted_arr = []
  queue = Queue.new
  # in_edges = {}
  vertices.each do |vertex|
    if vertex.in_edges.empty?
      queue.enq(vertex)
    end
  end

  # vertices.each do |vertex|
  #   in_edge_cost = vertex.in_edges.reduce(0) { |sum, edge| sum += edge.cost }
  #   in_edges[vertex] = in_edge_cost
  #   queue << vertex if in_edge_cost == 0
  # end

  until queue.empty?
    u = queue.deq
    sorted_arr << u
    while u.out_edges.length != 0
      current_edge = u.out_edges[0]
      queue.enq(current_edge.to_vertex) if current_edge.to_vertex.in_edges == [current_edge]
      current_edge.destroy!
    end
    u.out_edges = []
  end

  # until queue.empty?
  #   current = queue.shift
  #
  #   current.out_edges.each do |edge|
  #     to_vertex = edge.to_vertex
  #     in_edges[to_vertex] -= edge.cost
  #     queue << to_vertex if in_edges[to_vertex] == 0
  #   end
  #
  #   sorted arr << current
  # end

  if sorted_arr.length != vertices.length
    return []
  # vertices.length == order.length ? order : []
  end

  sorted_arr

  # Tarjan's algorithm (without cyce catching)
  # order = []
  # explored = Set.new
  #
  # vertices.each do |vertex|
  #   dfs!(order, explored, vertex) unless explored.include?(vertex) #depth-first search
  # end
  #
  # order

end

# def dfs!(order, explored, vertex)
#   explored.add(vertex)
#
#   vertex.out_edges.each do |edge|
#     to_vertex = edge.to_vertex
#     dfs!(order, explored, to_vertex) unless explored.include?(to_vertex)
#   end
#
#   order.unshift(vertex)
# end
