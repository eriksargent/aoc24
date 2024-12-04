import Algorithms


struct Day04: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String
    
    // Splits input data into its component parts and convert from string.
    let table: [[Int8]]
    let height: Int
    let width: Int
    
    init(data: String) {
        self.data = data
        let table: [[Int8]] = data.components(separatedBy: .newlines).map { line in
            line.map {
                switch $0 {
                case "X": return 0
                case "M": return 1
                case "A": return 2
                case "S": return 3
                default: return 9
                }
            }
        }
        
        let width = table.first?.count ?? 0
        self.width = width
        self.table = table.filter({ $0.count == width })
        self.height = self.table.count
    }
    
    func get(x: ClosedRange<Int>, y: Int) -> [Int8] {
        guard x.lowerBound >= 0 && x.upperBound < width else { return [] }
        return x.map { table[y][$0] }
    }
    
    func get(x: Int, y: ClosedRange<Int>) -> [Int8] {
        guard y.lowerBound >= 0 && y.upperBound < height else { return [] }
        return y.map { table[$0][x] }
    }
    
    func get(diagonal: Diagonal, fromX: Int, y: Int) -> [Int8] {
        var x = fromX
        var y = y
        var result = [Int8]()
        
        for _ in 0..<4 where x >= 0 && x < width && y >= 0 && y < height {
            result.append(table[y][x])
            x += diagonal.offset.0
            y += diagonal.offset.1
        }
        
        return result
    }
    
    func getDiagonalBox(x: Int, y: Int) -> [[Int8]] {
        let first = [table[y - 1][x - 1], table[y + 1][x + 1]].sorted()
        let second = [table[y - 1][x + 1], table[y + 1][x - 1]].sorted()
        return [first, second]
    }
    
    enum Diagonal: CaseIterable {
        case upLeft
        case upRight
        case downLeft
        case downRight
        
        var offset: (Int, Int) {
            switch self {
            case .upLeft: return (-1, -1)
            case .upRight: return (1, -1)
            case .downLeft: return (-1, 1)
            case .downRight: return (1, 1)
            }
        }
    }
    
    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any {
        let table = self.table
        var count = 0
       
        for (lineIndex, line) in table.enumerated() {
            for (charIndex, char) in line.enumerated() where char == 0 {
                if get(x: charIndex...charIndex + 3, y: lineIndex) == [0, 1, 2, 3] {
                    count += 1
                }
                if get(x: charIndex - 3...charIndex, y: lineIndex) == [3, 2, 1, 0] {
                    count += 1
                }
                if get(x: charIndex, y: lineIndex...lineIndex + 3) == [0, 1, 2, 3] {
                    count += 1
                }
                if get(x: charIndex, y: lineIndex - 3...lineIndex) == [3, 2, 1, 0] {
                    count += 1
                }
                
                for diagonal in Diagonal.allCases {
                    let diagonalData = get(diagonal: diagonal, fromX: charIndex, y: lineIndex)
                    if diagonalData == [0, 1, 2, 3] {
                        count += 1
                    }
                }
            }
        }
                
        return count
    }
    
    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any {
        let table = self.table
        var count = 0
        
        for (lineIndex, line) in table.enumerated().dropFirst().dropLast() {
            for (charIndex, char) in line.enumerated().dropFirst().dropLast() where char == 2 {
                if getDiagonalBox(x: charIndex, y: lineIndex) == [[1, 3], [1, 3]] {
                    count += 1
                }
            }
        }
        
        return count
    }
}
