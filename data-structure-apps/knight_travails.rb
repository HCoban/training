require 'byebug'
require_relative "00_tree_node.rb"

class KnightPathFinder
  attr_reader :start_pos, :start

  def initialize(start_pos)

    @start_pos = start_pos
    @vistied_positions = [@start_pos]
  end

  def find_path(end_pos)
    build_move_tree
    end_node = @start.bfs(end_pos)
    (trace_path_back(end_node).map(&:value)).reverse
  end

  def trace_path_back(end_node)
    path = [end_node]
    until end_node.parent.nil?
      path << end_node.parent
      end_node = path[-1]
    end
    path
  end

  def build_move_tree
    @start = PolyTreeNode.new(start_pos)
    next_steps = [@start]
    until next_steps.empty?
      new_move_positions(next_steps[0].value).each do |move|
        next_step = PolyTreeNode.new(move)
        next_step.parent = next_steps[0]
        next_steps << next_step
      end
      next_steps.shift
    end
  end

  def self.valid_moves(pos)
    result = []
    x, y = pos[0], pos[1]
    knight_moves = [[-1, 2], [1, 2], [2, 1], [2, -1], [1, -2],
      [-1, -2], [-2, -1], [-2, 1]]
    knight_moves.each do |move|
      if (x + move[0]).between?(0, 7) && (y + move[1]).between?(0, 7)
        result << [x + move[0], y + move[1]]
      end
    end
    result
  end

  def new_move_positions(pos)
    moves =  KnightPathFinder.valid_moves(pos)
    result = moves.reject { |move| @vistied_positions.include?(move) }
    @vistied_positions += result
    result
  end
end

if __FILE__ == $PROGRAM_NAME
  first = KnightPathFinder.new([0,0])
  p first.find_path([6, 2])
end
