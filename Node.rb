class Node

    def initialize(type,x,y)
        @type = type
        @x = x
        @y = y
        @parent = nil
        @f = 0
        @g = 0
        @h = 0
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
    #We'll give diagonal movement a cost of 14 and the rest a cost of 10
    def setG(direction)
        if direction == 'diagonal'
            @g = 14
        elsif direction == 'other'
            @g = 10
        end
    end

    def getG
        @g
    end

    def setH(x_end,y_end)
        @h = (@x - x_end).abs + (@y - y_end).abs
    end

    def setF
        @f = @g + @h
    end
    
end