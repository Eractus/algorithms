# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but all packages from 1..max_id exist.

# N.B. this is how `npm` works.

# Import any files you need to

require 'graph.rb'
require 'topological_sort'

def install_order(arr)
  packages_with_dep = arr.flatten.uniq.sort
  all_packages = packages_with_dep[0].upto(packages_with_dep[-1]).map { |package| Vertex.new(package) }
  arr.each do |tuple|
    Edge.new(all_packages[(tuple[-1]-1)], all_packages[(tuple[0]-1)])
  end
  sorted = topological_sort(all_packages)
  sorted.map { |vertex| vertex.value }
end
