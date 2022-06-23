require_relative 'Node.rb'

class Maze

    #Setting up maze and its functionality
    def initialize(textfile)

        @gameMaze = convert2Node(convert2Arr(textfile))
        @openList = []
        @closedList = []
    end

    #Converts maze text file to an array remove newline character
    def convert2Arr(maze)

        x = File.read(maze)

        outter = []
        lastElement = ""
        x.each_line do |line|
            inner = line.split('')
            lastElement = inner.pop()
            outter << inner
        end

        outter[-1].push(lastElement)

        outter
    end

    #Takes array maze form and converts it to array of Nodes
    def convert2Node(mazeArr)
        outter = []
        mazeArr.each.with_index do |arr1, idx1|
            inner = []
            arr1.each.with_index do |ele,idx2|
                
                inner <<  Node.new(ele,idx2,idx1)
            end
            outter << inner
            
        end
        outter
    end

    #searches all surounding nodes and checks whether they're elligible terrain
    #at the end parent node gets removed from openList and added to closedList
    #G and H values are also inserted here and F calculated
    def search(x,y)
        #End co-ords
        endCoOrds = self.findE
        
        #top left
        if (x-1) >= 0 and (y-1) >= 0
            if @gameMaze[y-1][x-1].walkable?
                @gameMaze[y-1][x-1].setParent(@gameMaze[y][x])
                @gameMaze[y-1][x-1].setG('diagonal', @gameMaze[y][x])
                @gameMaze[y-1][x-1].setH(endCoOrds[1],endCoOrds[0])
                @gameMaze[y-1][x-1].setF()
                @openList << @gameMaze[y-1][x-1]
            end
        end
        #top right
        if (x+1) <= (@gameMaze[0].length-1) and (y-1) >= 0
            if @gameMaze[y-1][x+1].walkable?
                @gameMaze[y-1][x+1].setParent(@gameMaze[y][x])
                @gameMaze[y-1][x+1].setG('diagonal', @gameMaze[y][x])
                @gameMaze[y-1][x+1].setH(endCoOrds[1],endCoOrds[0])
                @gameMaze[y-1][x+1].setF()
                @openList << @gameMaze[y-1][x+1]
            end
        end
        #top middle
        if (y-1) >= 0
            if @gameMaze[x][y-1].walkable?
                @gameMaze[x][y-1].setParent(@gameMaze[y][x])
                @gameMaze[x][y-1].setG('other', @gameMaze[y][x])
                @gameMaze[x][y-1].setH(endCoOrds[1],endCoOrds[0])
                @gameMaze[x][y-1].setF()
                @openList << @gameMaze[x][y-1]
            end
        end
        #bottom right
        if (y+1) <= (@gameMaze.length-1) and (x+1) <= (@gameMaze[0].length-1)
            if @gameMaze[y+1][x+1].walkable?
                @gameMaze[y+1][x+1].setParent(@gameMaze[y][x])
                @gameMaze[y+1][x+1].setG('diagonal', @gameMaze[y][x])
                @gameMaze[y+1][x+1].setH(endCoOrds[1],endCoOrds[0])
                @gameMaze[y+1][x+1].setF()
                @openList << @gameMaze[y+1][x+1]
            end
        end
        #middle right
        if (x+1) <= (@gameMaze[0].length-1)
            if @gameMaze[y][x+1].walkable?
                @gameMaze[y][x+1].setParent(@gameMaze[y][x])
                @gameMaze[y][x+1].setG('other', @gameMaze[y][x])
                @gameMaze[y][x+1].setH(endCoOrds[1],endCoOrds[0])
                @gameMaze[y][x+1].setF()
                @openList << @gameMaze[y][x+1]
            end
        end
        #bottom left
        if (y+1) <= (@gameMaze.length-1) and (x-1) >= 0
            if @gameMaze[y+1][x-1].walkable?
                @gameMaze[y+1][x-1].setParent(@gameMaze[y][x])
                @gameMaze[y+1][x-1].setG('diagonal', @gameMaze[y][x])
                @gameMaze[y+1][x-1].setH(endCoOrds[1],endCoOrds[0])
                @gameMaze[y+1][x-1].setF()
                @openList << @gameMaze[y+1][x-1]
            end
        end
        #bottom middle
        if (y+1) <= (@gameMaze.length-1)
            if @gameMaze[y+1][x].walkable?
                @gameMaze[y+1][x].setParent(@gameMaze[y][x])
                @gameMaze[y+1][x].setG('other', @gameMaze[y][x])
                @gameMaze[y+1][x].setH(endCoOrds[1],endCoOrds[0])
                @gameMaze[y+1][x].setF()
                @openList << @gameMaze[y+1][x]
            end
        end
        #left middle
        if (x-1) >= 0
            if @gameMaze[y][x-1].walkable?
                @gameMaze[y][x-1].setParent(@gameMaze[y][x])
                @gameMaze[y][x-1].setG('other', @gameMaze[y][x])
                @gameMaze[y][x-1].setH(endCoOrds[1],endCoOrds[0])
                @gameMaze[y][x-1].setF()
                @openList << @gameMaze[y][x-1]
            end
        end

        n = @openList.delete(@gameMaze[y][x])

        @closedList << n

    end
    #Finds start node and returns Y,X co-ords
    def findS()
        @gameMaze.each.with_index do |arr1, idx1|
            arr1.each.with_index do |node, idx2|
                if node.type == 'S'
                    return [idx1, idx2]
                end
            end
        end
    end
    #Finds end node and returns Y,X co-ords
    def findE()
        @gameMaze.each.with_index do |arr1, idx1|
            arr1.each.with_index do |node, idx2|
                if node.type == 'E'
                    return [idx1, idx2]
                end
            end
        end
    end

end

test = Maze.new('maze.txt')
print test.search(1,6)



