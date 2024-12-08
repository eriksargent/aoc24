import Algorithms


struct Day08: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String
    var width: Int
    var height: Int
    var antennaLocations: [Character: [Point]]
    
    struct Point: Equatable, Hashable {
        var x: Int
        var y: Int
    }
    
    init(data: String) {
        self.data = data
        let lines = data.components(separatedBy: .newlines).trimming(while: { $0 == "" })
        height = lines.count
        width = lines.first?.count ?? 0
        
        var locations = [Character: [Point]]()
        for (y, line) in lines.enumerated() {
            for (x, char) in line.enumerated() where char != "." {
                locations[char, default: []].append(.init(x: x, y: y))
            }
        }
        
        antennaLocations = locations
    }
    
    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any {
        var antinodes: Set<Point> = []
        
        let possible = antennaLocations.filter({ $0.value.count > 1 })
        for (_, locations) in possible {
            for pair in locations.combinations(ofCount: 2) {
                let xDiff = pair[1].x - pair[0].x
                let yDiff = pair[1].y - pair[0].y
                
                let nodes = [
                    Point(x: pair[0].x - xDiff, y: pair[0].y - yDiff),
                    Point(x: pair[1].x + xDiff, y: pair[1].y + yDiff)
                ].filter({ $0.x >= 0 && $0.x < width && $0.y >= 0 && $0.y < height })
                
                for point in nodes {
                    antinodes.insert(point)
                }
            }
        }
        
        return antinodes.count
    }
    
    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any {
        var antinodes: Set<Point> = []
        
        let possible = antennaLocations.filter({ $0.value.count > 1 })
        for (_, locations) in possible {
            for pair in locations.combinations(ofCount: 2) {
                let xDiff = pair[1].x - pair[0].x
                let yDiff = pair[1].y - pair[0].y
                
                var x = pair[0].x
                var y = pair[0].y
                while x >= 0 && x < width && y >= 0 && y < height {
                    antinodes.insert(.init(x: x, y: y))
                    x -= xDiff
                    y -= yDiff
                }
                x = pair[1].x
                y = pair[1].y
                while x >= 0 && x < width && y >= 0 && y < height {
                    antinodes.insert(.init(x: x, y: y))
                    x += xDiff
                    y += yDiff
                }
            }
        }
        
        return antinodes.count
    }
}
