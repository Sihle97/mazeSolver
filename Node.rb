class Node

    def initialize(type,x,y)
        @type = type
        @x = x
        @y = y
        @parent = nil
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

    def setParent(parent)
        @parent = parent
    end

    def getParent()
        @parent
    end

    def getX
        @x
    end

    def getY
        @y
    end

end