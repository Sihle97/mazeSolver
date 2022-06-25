class Node

    def initialize(type,x,y)
        @type = type
        @x = x
        @y = y
        @parent = nil
        @f = 0
        @g = 0
        @h = 0
        @fakeg = 0
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

    def x
        @x
    end

    def y
        @y
    end
    #We'll give diagonal movement a cost of 14 and the rest a cost of 10
    def setG(direction, parent)
        if direction == 'diagonal'
            @g = parent.getG + 14
        elsif direction == 'other'
            @g = parent.getG + 10
        end
    end

    def setFakeG(direction, parent)
  
        if direction == 'diagonal'
            @fakeg = @g + 14
        elsif direction == 'other'
            @fakeg = @g + 10
        end
    end

    def getFakeG
        @fakeg
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

    def getF
        @f
    end

end