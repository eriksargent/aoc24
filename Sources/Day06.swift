import Algorithms


struct Day06: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String
    
    enum GridType: Equatable {
        case empty
        case obstruction
        case visited(Direction)
    }
    
    enum Direction: Int, CaseIterable, Equatable {
        case up
        case right
        case down
        case left
        
        var move: (x: Int, y: Int) {
            switch self {
            case .up: return (0, -1)
            case .down: return (0, 1)
            case .left: return (-1, 0)
            case .right: return (1, 0)
            }
        }
        
        var nextDir: Direction {
            let next = self.rawValue + 1
            return Direction(rawValue: next) ?? .up
        }
    }
    
    func parseGrid() -> (grid: [[GridType]], startingPosition: (x: Int, y: Int), startingDirection: Direction) {
        var grid = [[GridType]]()
        var currentPosition: (x: Int, y: Int) = (0, 0)
        var direction = Direction.right
        
        for (y, line) in data.components(separatedBy: .newlines).trimming(while: { $0 == "" }).enumerated() {
            var lineGrid: [GridType] = []
            
            for (x, char) in line.enumerated() {
                switch char {
                case ".": lineGrid.append(.empty)
                case "#": lineGrid.append(.obstruction)
                case ">":
                    lineGrid.append(.empty)
                    currentPosition = (x, y)
                    direction = .right
                case "<":
                    lineGrid.append(.empty)
                    currentPosition = (x, y)
                    direction = .left
                case "^":
                    lineGrid.append(.empty)
                    currentPosition = (x, y)
                    direction = .up
                case "v":
                    lineGrid.append(.empty)
                    currentPosition = (x, y)
                    direction = .down
                default:
                    fatalError()
                }
            }
            
            grid.append(lineGrid)
        }
        
        return (grid, currentPosition, direction)
    }
    
    nonisolated func countVisited(grid: [[GridType]], startingPosition: (x: Int, y: Int), startingDirection: Direction) async -> Int? {
        var grid = grid
        var currentPosition = startingPosition
        var direction = startingDirection
        
        let height = grid.count
        let width = grid[0].count
        var count = 0
        var totalVisits = 0
        
        while currentPosition.x >= 0 && currentPosition.x < width && currentPosition.y >= 0 && currentPosition.y < height {
            if case .visited(let previousDirection) = grid[currentPosition.y][currentPosition.x] {
                if direction == previousDirection || totalVisits == count * 10 {
                    // LOOP!
                    return nil
                }
            }
            else {
                count += 1
            }
            totalVisits += 1
            grid[currentPosition.y][currentPosition.x] = .visited(direction)
            
            let move = direction.move
            let nextPosition = (x: currentPosition.x + move.x, y: currentPosition.y + move.y)
            
            if nextPosition.x >= 0 && nextPosition.x < width && nextPosition.y >= 0 && nextPosition.y < height {
                if grid[nextPosition.y][nextPosition.x] == .obstruction {
                    direction = direction.nextDir
                }
                else {
                    currentPosition = nextPosition
                }
            }
            else {
                currentPosition = nextPosition
            }
        }
        
        return count
    }
    
    // Replace this with your solution for the first part of the day's challenge.
    func part1() async -> Any {
        let (grid, startingPosition, startingDirection) = parseGrid()
        return await countVisited(grid: grid, startingPosition: startingPosition, startingDirection: startingDirection) ?? 0
    }
    
    // Replace this with your solution for the second part of the day's challenge.
    func part2() async -> Any {
        let (grid, startingPosition, startingDirection) = parseGrid()
        let height = grid.count
        let width = grid[0].count
        
        let count = await withTaskGroup(of: Int.self) { group in
            for chunk in (0..<height).chunks(ofCount: 10) {
                group.addTask(priority: .high) {
                    var count = 0
                    for y in chunk {
                        for x in 0..<width {
                            if case .empty = grid[y][x] {
                                var newGrid = grid
                                newGrid[y][x] = .obstruction
                                if await countVisited(grid: newGrid, startingPosition: startingPosition, startingDirection: startingDirection) == nil {
                                    count += 1
                                }
                            }
                        }
                    }
                    
                    return count
                }
            }
            
            var count = 0
            while let partial = await group.next() {
                count += partial
            }
            
            return count
        }
        
        return count
    }
}
