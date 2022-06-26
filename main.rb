require_relative 'maze.rb'


game = Maze.new('maze.txt')

while !game.hasE? 
    game.search(game.currentNode)

    game.lowF
end

game.findPath
game.writeOutput


