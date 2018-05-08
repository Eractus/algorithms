require 'binary_search_tree'

def kth_largest(tree_node, k)
  array = []
  array = BinarySearchTree.new(tree_node).in_order_traversal(tree_node, array)
  p array
  array[k]
end
