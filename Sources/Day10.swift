import Algorithms


struct Day10: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String
    var table: [[Int]]
    var trailheads: [(x: Int, y: Int)]
    var width: Int
    var height: Int
    
    init(data: String) {
        self.data = data
        var table = [[Int]]()
        var trailheads = [(x: Int, y: Int)]()
        
        for (y, line) in data.components(separatedBy: .newlines).trimming(while: { $0 == "" }).enumerated() {
            var row: [Int] = []
            let values = line.compactMap({ Int(String($0)) })
            
            for (x, value) in values.enumerated() {
                row.append(value)
                if value == 0 {
                    trailheads.append((x, y))
                }
            }
            
            table.append(row)
        }
        
        self.table = table
        self.trailheads = trailheads
        
        self.width = table.first?.count ?? 0
        self.height = table.count
    }
    
    enum Direction: CaseIterable {
        case up
        case down
        case left
        case right
        
        var offset: (Int, Int) {
            switch self {
            case .up: return (0, -1)
            case .down: return (0, 1)
            case .left: return (-1, 0)
            case .right: return (1, 0)
            }
        }
    }
    
    struct Point: Hashable, Equatable {
        var x: Int
        var y: Int
    }
    
    func isPointValid(x: Int, y: Int) -> Bool {
        return x >= 0 && x < width && y >= 0 && y < height
    }
    
    func trails(startingAtX x: Int, y: Int, value: Int) -> [Point] {
        var valid = [Point]()
        for direction in Direction.allCases {
            let (xOff, yOff) = direction.offset
            let nextX = x + xOff
            let nextY = y + yOff
            
            guard isPointValid(x: nextX, y: nextY) else { continue }
            
            let nextValue = table[nextY][nextX]
            guard nextValue == value + 1 else { continue }
            
            if nextValue == 9 {
                valid.append(Point(x: nextX, y: nextY))
            }
            else {
                valid.append(contentsOf: trails(startingAtX: nextX, y: nextY, value: nextValue))
            }
        }
        
        return valid
    }
    
    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any {
        return trailheads.reduce(0, { sum, trailhead in
            let trails = trails(startingAtX: trailhead.x, y: trailhead.y, value: 0)
            let unique = Set(trails).count
            return sum + unique
        })
    }
    
    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any {
        return trailheads.reduce(0, { sum, trailhead in
            let trails = trails(startingAtX: trailhead.x, y: trailhead.y, value: 0)
            return sum + trails.count
        })
    }
}
