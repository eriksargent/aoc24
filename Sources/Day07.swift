import Algorithms


struct Day07: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String
    
    // Splits input data into its component parts and convert from string.
    var rows: [(Int, [Int])] {
        data.components(separatedBy: .newlines).trimming(while: { $0 == "" }).compactMap {
            let parts = $0.split(separator: ": ")
            guard parts.count == 2 else { return nil }
            guard let total = Int(parts[0]) else { return nil }
            
            let values = parts[1].components(separatedBy: .whitespaces).compactMap(Int.init)
            
            return (total, values)
        }
    }
    
    func isEquationValid<S: Collection>(_ values: S, total: Int, target: Int, includeConcat: Bool = false) -> Bool where S.Element == Int {
        guard let value = values.first else { return total == target }
        
        let next = values.dropFirst()
        let mult = value * total
        if isEquationValid(next, total: mult, target: target, includeConcat: includeConcat) {
            return true
        }
        
        let add = value + total
        if isEquationValid(next, total: add, target: target, includeConcat: includeConcat) {
            return true
        }
        
        if includeConcat {
            let concat = Int("\(total)\(value)") ?? 0
            if isEquationValid(next, total: concat, target: target, includeConcat: includeConcat) {
                return true
            }
        }
        
        return false
    }
    
    func part1() -> Any {
        var sum = 0
        
        for (total, values) in rows {
            guard let start = values.first else { continue }
            let next = values.dropFirst()
            
            if isEquationValid(next, total: start, target: total) {
                sum += total
            }
        }
        
        return sum
    }
    
    func part2() async -> Any {
        return await withTaskGroup(of: Int.self) { group in
            for chunk in rows.chunks(ofCount: 100) {
                group.addTask {
                    var sum = 0
                    for (total, values) in chunk {
                        guard let start = values.first else { continue }
                        let next = values.dropFirst()
                        
                        if isEquationValid(next, total: start, target: total, includeConcat: true) {
                            sum += total
                        }
                    }
                    return sum
                }
            }
            
            var sum = 0
            while let partial = await group.next() {
                sum += partial
            }
            return sum
        }
    }
}
