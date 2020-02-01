class PolyTreeNode

    attr_reader :parent, :children, :value

    def initialize(value)
        @parent = nil
        @children = Array.new()
        @value = value
    end

    def parent= (node)
        if @parent != nil && node != nil
            @parent.children.delete(self)
        end
        @parent = node
        node.children << self if node != nil
    end

    def remove_child(node)
        raise error if @children.include?(node) == false
        node.parent=(nil)
    end

    def add_child(node)
        if @children.include?(node) == false
            node.parent=(self)
        end
    end

    def dfs(target)
        return self if target == self.value
        @children.each do |child|
            search_result = child.dfs(target)
            return search_result unless search_result.nil?
        end
        nil
    end

    def bfs(target)
        queue = Array.new()
        queue << self
        until queue.empty?
            el = queue.shift
            return el if target == el.value
            el.children.each{ |child| queue << child}
        end
    end

end