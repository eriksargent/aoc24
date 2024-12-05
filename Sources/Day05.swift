import Algorithms


struct Day05: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String
    var rules: [Rule]
    var ruleGroups: [Int: Set<Int>]
    var updates: [[Int]]
    
    init(data: String) {
        self.data = data
        
        let parts = data.split(separator: "\n\n")
        guard parts.count == 2 else { fatalError() }
        
        rules = parts[0]
            .components(separatedBy: .newlines)
            .compactMap({ Rule.init(from: $0) })
            .sorted(by: { $0.before < $1.before })
        
        updates = parts[1]
            .components(separatedBy: .newlines)
            .compactMap({ $0.components(separatedBy: ",").compactMap(Int.init) })
            .filter({ $0.count > 1 })
        
        ruleGroups = rules
            .grouped(by: \.before)
            .reduce(into: [Int: Set<Int>]()) { partialResult, next in
                partialResult[next.key] = Set(next.value.map(\.after))
            }
    }
    
    struct Rule: CustomStringConvertible {
        var before: Int
        var after: Int
        
        init?(from: String) {
            let comps = from.components(separatedBy: "|").compactMap(Int.init)
            guard comps.count == 2 else { return nil }
            before = comps[0]
            after = comps[1]
        }
        
        var description: String {
            "\(before)|\(after)"
        }
    }
    
    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any {
        var middleSum = 0
        
        for update in updates {
            var valid = true
            for (index, page) in update.enumerated().dropFirst() where valid {
                guard let afters = ruleGroups[page] else { continue }
                
                for previous in update[..<index] {
                    if afters.contains(previous) {
                        // An after requirement was found before this page
                        valid = false
                        continue
                    }
                }
            }
            
            if valid {
                middleSum += update[update.count / 2]
            }
        }
        
        return middleSum
    }
    
    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any {
        var middleSum = 0
        for var update in updates {
            var valid = true
            // Test if it is invalid
            for (index, page) in update.enumerated().dropFirst() where valid {
                guard let afters = ruleGroups[page] else { continue }
                
                for previous in update[..<index] {
                    if afters.contains(previous) {
                        // An after requirement was found before this page
                        valid = false
                        continue
                    }
                }
            }
            
            if !valid {
                update = update.sorted { lhs, rhs in
                    return ruleGroups[rhs]?.contains(lhs) != true
                }

                middleSum += update[update.count / 2]
            }
        }
        
        return middleSum
    }
}
