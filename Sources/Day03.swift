import Algorithms


struct Day03: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String
    
    func sumMult(from data: String) -> Int {
        let regex = /mul\((\d{1,3}),(\d{1,3})\)/
        let matches = data.matches(of: regex)
        let result: Int = matches.compactMap({
            guard let x = Int($0.output.1), let y = Int($0.output.2) else { return nil }
            return x * y
        }).sum()
        return result
    }
    
    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any {
        sumMult(from: data)
    }
    
    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any {
        var filtered = self.data
        
        let offRegex = /don\'t\(\)/
        let onRegex = /do\(\)/
        var start = filtered.startIndex
        while start < filtered.endIndex {
            if let offRange = try? offRegex.firstMatch(in: filtered[start...]) {
                if let onRange = try? onRegex.firstMatch(in: filtered[offRange.endIndex...]) {
                    filtered.removeSubrange(offRange.startIndex..<onRange.endIndex)
                    start = offRange.startIndex
                }
                else {
                    filtered.removeSubrange(offRange.startIndex...)
                    break
                }
            }
            else {
                break
            }
        }
        
        return sumMult(from: filtered)
    }
}
