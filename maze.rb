require_relative 'Node.rb'

class Maze

    #Setting up maze and its functionality
    def initialize(textfile)

        @gameMaze = convert2Node(convert2Arr(textfile))
        @openList = []
        @closedList = []
        @currentNode = self.findS()
        @closedList << @gameMaze[@currentNode.y][@currentNode.x]
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
    def search(current)
        #End co-ords
        endCoOrds = self.findE
        
        #top left
        if (current.x-1) >= 0 and (current.y-1) >= 0
            if @gameMaze[current.y-1][current.x-1].walkable? and !(@closedList.include? @gameMaze[current.y-1][current.x-1])
                if @openList.include? @gameMaze[current.y-1][current.x-1]
                    current.setFakeG('diagonal', @gameMaze[current.y][current.x])
                    if current.getFakeG < @gameMaze[current.y-1][current.x-1].getG
                        @gameMaze[current.y-1][current.x-1].setParent(current)
                        @gameMaze[current.y-1][current.x-1].setG('diagonal', @gameMaze[current.y][current.x])
                        @gameMaze[current.y-1][current.x-1].setF()
                    end
                else
                    @gameMaze[current.y-1][current.x-1].setParent(current)
                    @gameMaze[current.y-1][current.x-1].setG('diagonal', @gameMaze[current.y][current.x])
                    @gameMaze[current.y-1][current.x-1].setH(endCoOrds.x,endCoOrds.y)
                    @gameMaze[current.y-1][current.x-1].setF()
                    @openList << @gameMaze[current.y-1][current.x-1]
                end
            end
        end
        #top right
        if (current.x+1) <= (@gameMaze[0].length-1) and (current.y-1) >= 0
            if @gameMaze[current.y-1][current.x+1].walkable? and !(@closedList.include? @gameMaze[current.y-1][current.x+1])
                if @openList.include? @gameMaze[current.y-1][current.x+1]
                    current.setFakeG('diagonal', @gameMaze[current.y][current.x])
                    if current.getFakeG < @gameMaze[current.y-1][current.x+1].getG
                        @gameMaze[current.y-1][current.x+1].setParent(current)
                        @gameMaze[current.y-1][current.x+1].setG('diagonal', @gameMaze[current.y][current.x])
                        @gameMaze[current.y-1][current.x+1].setF()
                    end
                else
                    @gameMaze[current.y-1][current.x+1].setParent(current)
                    @gameMaze[current.y-1][current.x+1].setG('diagonal', @gameMaze[current.y][current.x])
                    @gameMaze[current.y-1][current.x+1].setH(endCoOrds.x,endCoOrds.y)
                    @gameMaze[current.y-1][current.x+1].setF()
                    @openList << @gameMaze[current.y-1][current.x+1]
                end
            end
        end
        #top middle
        if (current.y-1) >= 0
            if @gameMaze[current.y-1][current.x].walkable? and !(@closedList.include? @gameMaze[current.y-1][current.x])
                if @openList.include? @gameMaze[current.y-1][current.x]
                    current.setFakeG('other', @gameMaze[current.y][current.x])
                    if current.getFakeG < @gameMaze[current.y-1][current.x].getG
                        @gameMaze[current.y-1][current.x].setParent(current)
                        @gameMaze[current.y-1][current.x].setG('other', @gameMaze[current.y][current.x])
                        @gameMaze[current.y-1][current.x].setF()
                    end
                else
                    @gameMaze[current.y-1][current.x].setParent(current)
                    @gameMaze[current.y-1][current.x].setG('other', @gameMaze[current.y][current.x])
                    @gameMaze[current.y-1][current.x].setH(endCoOrds.x,endCoOrds.y)
                    @gameMaze[current.y-1][current.x].setF()
                    @openList << @gameMaze[current.y-1][current.x]
                end
            end
        end
        #bottom right
        if (current.y+1) <= (@gameMaze.length-1) and (current.x+1) <= (@gameMaze[0].length-1)
            if @gameMaze[current.y+1][current.x+1].walkable? and !(@closedList.include? @gameMaze[current.y+1][current.x+1])
                if @openList.include? @gameMaze[current.y+1][current.x+1]
                    current.setFakeG('diagonal', @gameMaze[current.y][current.x])
                    if current.getFakeG < @gameMaze[current.y+1][current.x+1].getG
                        @gameMaze[current.y+1][current.x+1].setParent(current)
                        @gameMaze[current.y+1][current.x+1].setG('diagonal', @gameMaze[current.y][current.x])
                        @gameMaze[current.y+1][current.x+1].setF()
                    end
                else
                    @gameMaze[current.y+1][current.x+1].setParent(current)
                    @gameMaze[current.y+1][current.x+1].setG('diagonal', @gameMaze[current.y][current.x])
                    @gameMaze[current.y+1][current.x+1].setH(endCoOrds.x,endCoOrds.y)
                    @gameMaze[current.y+1][current.x+1].setF()
                    @openList << @gameMaze[current.y+1][current.x+1]
                end
            end
        end
        #middle right
        if (current.x+1) <= (@gameMaze[0].length-1)
            if @gameMaze[current.y][current.x+1].walkable? and !(@closedList.include? @gameMaze[current.y][current.x+1])
                if @openList.include? @gameMaze[current.y][current.x+1]
                    current.setFakeG('other', @gameMaze[current.y][current.x])
                    if current.getFakeG < @gameMaze[current.y][current.x+1].getG
                        @gameMaze[current.y][current.x+1].setParent(current)
                        @gameMaze[current.y][current.x+1].setG('other', @gameMaze[current.y][current.x])
                        @gameMaze[current.y][current.x+1].setF()
                    end
                else
                    @gameMaze[current.y][current.x+1].setParent(current)
                    @gameMaze[current.y][current.x+1].setG('other', @gameMaze[current.y][current.x])
                    @gameMaze[current.y][current.x+1].setH(endCoOrds.x,endCoOrds.y)
                    @gameMaze[current.y][current.x+1].setF()
                    @openList << @gameMaze[current.y][current.x+1]
                end
            end
        end
        #bottom left
        if (current.y+1) <= (@gameMaze.length-1) and (current.x-1) >= 0
            if @gameMaze[current.y+1][current.x-1].walkable? and !(@closedList.include? @gameMaze[current.y+1][current.x-1])
                if @openList.include? @gameMaze[current.y+1][current.x-1]
                    current.setFakeG('diagonal', @gameMaze[current.y][current.x])
                    if current.getFakeG < @gameMaze[current.y+1][current.x-1].getG
                        @gameMaze[current.y+1][current.x-1].setParent(current)
                        @gameMaze[current.y+1][current.x-1].setG('diagonal', @gameMaze[current.y][current.x])
                        @gameMaze[current.y+1][current.x-1].setF()
                    end
                else
                    @gameMaze[current.y+1][current.x-1].setParent(current)
                    @gameMaze[current.y+1][current.x-1].setG('diagonal', @gameMaze[current.y][current.x])
                    @gameMaze[current.y+1][current.x-1].setH(endCoOrds.x,endCoOrds.y)
                    @gameMaze[current.y+1][current.x-1].setF()
                    @openList << @gameMaze[current.y+1][current.x-1]
                end
            end
        end
        #bottom middle
        if (current.y+1) <= (@gameMaze.length-1)
            if @gameMaze[current.y+1][current.x].walkable? and !(@closedList.include? @gameMaze[current.y+1][current.x])
                if @openList.include? @gameMaze[current.y+1][current.x]
                    current.setFakeG('other', @gameMaze[current.y][current.x])
                    if current.getFakeG < @gameMaze[current.y+1][current.x].getG
                        @gameMaze[current.y+1][current.x].setParent(current)
                        @gameMaze[current.y+1][current.x].setG('other', @gameMaze[current.y][current.x])
                        @gameMaze[current.y+1][current.x].setF()
                    end
                else
                    @gameMaze[current.y+1][current.x].setParent(current)
                    @gameMaze[current.y+1][current.x].setG('other', @gameMaze[current.y][current.x])
                    @gameMaze[current.y+1][current.x].setH(endCoOrds.x,endCoOrds.y)
                    @gameMaze[current.y+1][current.x].setF()
                    @openList << @gameMaze[current.y+1][current.x]
                end
            end
        end
        #left middle
        if (current.x-1) >= 0
            if @gameMaze[current.y][current.x-1].walkable? and !(@closedList.include? @gameMaze[current.y][current.x-1])
                if @openList.include? @gameMaze[current.y][current.x-1]
                    current.setFakeG('other', @gameMaze[current.y][current.x])
                    if current.getFakeG < @gameMaze[current.y][current.x-1].getG
                        @gameMaze[current.y][current.x-1].setParent(current)
                        @gameMaze[current.y][current.x-1].setG('other', @gameMaze[current.y][current.x])
                        @gameMaze[current.y][current.x-1].setF()
                    end
                else
                    @gameMaze[current.y][current.x-1].setParent(current)
                    @gameMaze[current.y][current.x-1].setG('other', @gameMaze[current.y][current.x])
                    @gameMaze[current.y][current.x-1].setH(endCoOrds.x,endCoOrds.y)
                    @gameMaze[current.y][current.x-1].setF()
                    @openList << @gameMaze[current.y][current.x-1]
                end
            end
        end

        # n = @openList.delete(@gameMaze[current.y][current.x])
        # print @openList
        # @closedList << n

    end
    #Finds start node and returns Y,X co-ords
    def findS()
        @gameMaze.each.with_index do |arr1, idx1|
            arr1.each.with_index do |node, idx2|
                if node.type == 'S'
                    return node
                end
            end
        end
    end
    #Finds end node and returns Y,X co-ords
    def findE()
        @gameMaze.each.with_index do |arr1, idx1|
            arr1.each.with_index do |node, idx2|
                if node.type == 'E'
                    return node
                end
            end
        end
    end

    #find lowest f-value in open list and moves it to closed list
    def lowF
        lowValue = @openList[0].getF
        idxholder = 0

        @openList.each.with_index do |ele, idx|
            if ele.getF < lowValue
                lowValue = ele.getF
                idxholder = idx
            end
        end
        
        @closedList << @openList[idxholder]
        @currentNode = @openList[idxholder]
        @openList.delete_at(idxholder)
        
        # puts 
        # print @openList[1]
        # puts
        # print @openList[2]
        #print @closedList
    end

    def currentNode
        @currentNode
    end

    def getOpenList
        @openList
    end

    def hasE?
        @closedList.include? findE
    end

    def openEmpty?
        @openList.empty?
    end

    def findPath

        @currentNode = @currentNode.getParent
        while @currentNode.type != 'S'
            @currentNode.setType('X')
            @currentNode = @currentNode.getParent
        end

    end

    def writeOutput
        file = File.open("solution.txt", 'w')
            @gameMaze.each do |arr|
                line = ""
                arr.each do |node|
                    line = line + node.type
                end
                file.puts line
            end
            
        file.close()
        
    end

end





