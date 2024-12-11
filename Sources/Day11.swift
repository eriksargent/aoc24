import Algorithms


struct Day11: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String
    var input: [UInt] {
        data.trimming(while: { $0.isWhitespace || $0.isNewline })
            .components(separatedBy: .whitespaces)
            .compactMap(UInt.init)
    }
    
    struct CountInput: Hashable {
        let input: UInt
        let rounds: Int
    }
    
    func countBlinks(rounds: Int) -> Int {
        var count = 0
        for start in input {
            count += recursiveMemoize({ countValues, data in
                let input = data.input
                let rounds = data.rounds
                
                if rounds == 0 {
                    return 1
                }
                
                var values = [input]
                if input == 0 {
                    values = [1]
                }
                else {
                    let digits = input.numberOfDigits
                    if digits.isEven {
                        let power = pow(10, UInt(digits / 2))
                        let left = input / power
                        let right = input - left * power
                        
                        values = [left, right]
                    }
                    else {
                        values = [input * 2024]
                    }
                }
                
                var count = 0
                for value in values {
                    count += countValues(CountInput(input: value, rounds: rounds - 1))
                }
                return count
            })(CountInput(input: start, rounds: rounds))
        }
        
        return count
    }
    
    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any {
        countBlinks(rounds: 25)
    }
    
    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any {
        countBlinks(rounds: 75)
    }
}
