require_relative "polytreenode"

class KnightPathFinder
    MOVES = [[2,1],[2,-1],[-2,1],[-2,-1],[1,2],[1,-2],[-1,2],[-1,-2]].freeze

    attr_reader :root_node, :considered_positions

    def initialize(pos)
        valid_pos?(pos)
        @root_node = PolyTreeNode.new(pos)
        @considered_positions = [pos]
        build_move_tree
    end
    
    def new_move_positions(pos)
        valid_pos?(pos)
        new_moves = Array.new()
        posible_moves = valid_moves(pos)
        posible_moves.each do |move|
            if @considered_positions.include?(move) == false
                new_moves << move
                @considered_positions << move
            end
        end
        new_moves
    end

    def build_move_tree
        
        # build tree out in bfs style
        nodes = [@root_node]
        until nodes.empty?
            curr_node = nodes.shift
            curr_pos = curr_node.value
            new_move_positions(curr_pos).each do |next_pos|
                next_node = PolyTreeNode.new(next_pos)
                curr_node.add_child(next_node)
                nodes << next_node
            end
        end
    end

    def find_path(end_pos)
        valid_pos?(end_pos)
        end_node = @root_node.dfs(end_pos)
        return trace_path_back(end_node)
    end

    def trace_path_back(end_node)
        path = [end_node]
        curr_node = end_node
        until curr_node == @root_node
            prev_node = curr_node.parent
            path.unshift(prev_node)
            curr_node = curr_node.parent
        end
        path
    end
    
    private
    
    def valid_pos?(pos)
        raise error if pos.is_a?(Array) == false || pos.length != 2
        pos.each{ |ele| raise error if ele < 0 || ele > 7 }
    end
    
    def valid_moves(pos)
        valid_pos?(pos)
        moves = Array.new()
        MOVES.each do |move|
            new_x = pos.first + move.first
            new_y = pos.last + move.last
            moves << [new_x,new_y] if new_x.between?(0,7) && new_y.between?(0,7)
        end
        moves
    end
end