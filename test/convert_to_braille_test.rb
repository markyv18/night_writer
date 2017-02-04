gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/node'
require './lib/binary_tree'

class NodeTest < Minitest::Test

  def test_right_is_nil
    node = Node.new(71, "Hannibal Buress: Animal Furnace")
    assert_nil node.right
  end

  def test_left_is_nil
    node = Node.new(71, "Hannibal Buress: Animal Furnace")
    assert_nil node.left
  end
end
