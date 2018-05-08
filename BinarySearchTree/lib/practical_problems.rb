def post_order_traversal(tree_node, arr = [])
  #left, right, root
  return arr if tree_node.nil?
  BinarySearchTree.new(tree_node.left).post_order_traversal(tree_node.left, arr)
  BinarySearchTree.new(tree_node.right).post_order_traversal(tree_node.right, arr)
  arr << tree_node.value
end

def pre_order_traversal(tree_node, arr = [])
  #left, right, root
  return arr if tree_node.nil?
  arr << tree_node.value
  BinarySearchTree.new(tree_node.left).pre_order_traversal(tree_node.left, arr)
  BinarySearchTree.new(tree_node.right).pre_order_traversal(tree_node.right, arr)
end

def in_order_traversal_iterative(tree_node)
  # 1. create an empty stack
  # 2. initialize current node as root
  # 3. push the current into the stck and set current as current.left until current is null
  # 4. if current is null and stack isn't empty
  #   1. pop top item from stack and print
  #   2. set current to popped item.right
  #   3. go back to step 3
  # 5. 

  stack = []
  current = tree_node
  until current.nil? && stack.empty?
    if current
      stack << current
      current = current.left
    else
      top_node = stack.pop
      p top_node.value
      current = top_node.right
    end
  end
end
