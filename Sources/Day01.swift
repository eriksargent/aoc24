//
//  Day01.swift
//  AdventOfCode
//
//  Created by Erik Sargent on 12/2/24.
//

import Algorithms


struct Day01: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String
    
    // Splits input data into its component parts and convert from string.
    var lists: [[Int]] {
        data.split(separator: "\n").map {
            $0.components(separatedBy: .whitespaces)
                .compactMap { Int($0) }
        }
        .filter { $0.count == 2 }
    }
    
    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any {
        let lists = self.lists
        let left = lists.compactMap(\.first).sorted()
        let right = lists.compactMap(\.last).sorted()
        let distances = zip(left, right).map({ abs($0.0 - $0.1) })
        return distances.sum()
    }
    
    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any {
        let lists = self.lists
        let left = lists.compactMap(\.first).sorted()
        let right = lists.compactMap(\.last).sorted()
        
        let occurrences = right.reduce(into: [Int: Int]()) { counts, value in
            counts[value, default: 0] += 1
        }
        
        var total = 0
        for value in left {
            if let count = occurrences[value] {
                if count > 0 {
                    total += value * count
                }
            }
        }
        
        return total
    }
}
