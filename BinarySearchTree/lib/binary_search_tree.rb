# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.
require 'bst_node'

class BinarySearchTree
  attr_accessor :root

  def initialize(root=nil)
    @root = root
  end

  def insert(value)
    return @root = BSTNode.new(value) if @root == nil

    if self.root.value > value
      if !self.root.left.nil?
        BinarySearchTree.new(self.root.left).insert(value)
      else
        self.root.left = BSTNode.new(value)
      end
    elsif self.root.value <= value
      if !self.root.right.nil?
        BinarySearchTree.new(self.root.right).insert(value)
      else
        self.root.right = BSTNode.new(value)
      end
    end
  end

  def find(value, tree_node = @root)
    return tree_node if tree_node.value == value
    return nil if tree_node.left.nil? && tree_node.right.nil?

    if tree_node.value > value
      BinarySearchTree.new(tree_node.left).find(value, tree_node.left)
    elsif tree_node.value <= value
      BinarySearchTree.new(tree_node.right).find(value, tree_node.right)
    end
  end

  def delete(value)
    # return nil if @root == nil && @root.left.nil? && @root.right.nil?
    # return @root = nil if @root.value == value

    # val_node = BinarySearchTree.new(@root).find(value, @root)
    # if !val_node.nil?
    #   val_node = nil
    #   max = BinarySearchTree.new(val_node.left).(maximum(val_node.left))
    #   orphaned_node = max.left
    #   abandoned_parent = max.parent
    #   orphaned_node.parent = abandoned_parent
    #   max.parent = val_node.parent
    #   max.left = val_node.left if !val_node.left.nil?
    #   max.right = val_node.right if !val_node.right.nil?
    # end

    @root = remove_from_tree(@root, value)
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    return tree_node if tree_node.right.nil?

    if !tree_node.right.nil?
      BinarySearchTree.new(tree_node.right).maximum(tree_node.right)
    end
  end

  def depth(tree_node = @root)
    return 0 if (tree_node.left.nil? && tree_node.right.nil?) || tree_node.nil?

    if !tree_node.left.nil? && !tree_node.right.nil?
      left_depth = 1 + BinarySearchTree.new(tree_node.left).depth(tree_node.left)
      right_depth = 1+ BinarySearchTree.new(tree_node.right).depth(tree_node.right)
      [left_depth, right_depth].max
    elsif !tree_node.left.nil?
      left_depth = 1 + BinarySearchTree.new(tree_node.left).depth(tree_node.left)
    else !tree_node.right.nil?
      right_depth = 1+ BinarySearchTree.new(tree_node.right).depth(tree_node.right)
    end

    # return -1 if tree_node.nil?
    #
    # left_dept = depth(tree_node.left)
    # right_depth = depth(tree_node.right)
    #
    # if left_depth > right_depth
    #   return left_depth + 1
    # else
    #   return right_depth +1
    # end

  end

  def is_balanced?(tree_node = @root)
    # left_depth = BinarySearchTree.new(tree_node.left).depth(tree_node.right)
    # right_depth = BinarySearchTree.new(tree_node.right).depth(tree_node.right)
    # return true if left_depth <= right_depth + 1 && left_depth >= right_depth - 1
    # return true if right_depth <= left_depth + 1 && right_depth >= left_depth - 1
    # false

    return true if tree_node.nil?

    left_depth = depth(tree_node.left)
    right_depth = depth(tree_node.right)

    if (left_depth - right_depth).abs < 2 && is_balanced?(tree_node.left) && is_balanced?(tree_node.right)
      return true
    else
      false
    end
  end

  def in_order_traversal(tree_node = @root, arr = [])
    return arr if tree_node.nil?
    arr = BinarySearchTree.new(tree_node.left).in_order_traversal(tree_node.left, arr)
    arr << tree_node.value
    arr = BinarySearchTree.new(tree_node.right).in_order_traversal(tree_node.right, arr)
  end


  private
  # optional helper methods go here:
  def insert_into_tree(tree_node, value)
    return BSTNode.new(value) if tree_node.nil?

    if value <= tree_node.value
      tree_node.left = insert_into_tree(tree_node.left, value)
    else
      tree_node.right = insert_into_tree(tree_node.right, value)
    end

    tree_node
  end

  def remove_from_tree(tree_node, value)
    if value == tree_node.value
      remove(tree_node)
    elsif value < tree_node.value
      tree_node.left = remove_from_tree(tree_node.left, value)
    else
      tree_node.right = remove_from_tree(tree_node.right, value)
    end
    tree_node
  end

  def remove(node)
    if node.right.nil? && node.left.nil?
      node = nil
    elsif node.left && node.right.nil?
      node = node.left
    elsif node.left.nil? && node.right
      node = node.right
    else
      node = replace_parent(node)
    end
  end

  def replace_parent(node)
    replacement_node = maximum(node.left)
    if replacement_node.left
      node.left.right = replacement_node.left
    end

    replacement_node.left = node.left
    replacement_node.right = node.right

    replacement_node
  end
end
