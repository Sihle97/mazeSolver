class Node

    def initialize(type,x,y)
        @type = type
        @x = x
        @y = y
    end

    def walkable?
        if self.type == '*'
            return false
        else
            return true
        end
    end

    def type
        @type
    end
end