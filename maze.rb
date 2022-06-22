class maze


    def initialize(textfile)

        @gameMaze = convert2Node(convert2Arr(textfile))
        
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

            arr1.each.with_index do |ele,idx2|
                inner = []
                inner <<  Node.new(ele,idx2,idx1)
            end
        end

    end

end


