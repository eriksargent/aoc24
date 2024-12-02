//
//  Day02.swift
//  AdventOfCode
//
//  Created by Erik Sargent on 12/2/24.
//


import Algorithms


struct Day02: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String
    
    // Splits input data into its component parts and convert from string.
    var reports: [[Int]] {
        data.split(separator: "\n").map {
            $0.components(separatedBy: .whitespaces).compactMap { Int($0) }
        }
    }
    
    func countReports(dampen: Bool = false) -> Int {
        var count = 0
        for level in reports {
            var safe = false
            let (fullSafe, badIndex) = isSafe(level)
            
            if fullSafe {
                safe = true
            }
            else if dampen, let badIndex {
                // Test removing the item, before, and after and see if any make it safe
                if badIndex > 0, isSafe(level.removing(at: badIndex - 1)).0 {
                    safe = true
                }
                else if isSafe(level.removing(at: badIndex)).0 {
                    safe = true
                }
                else if badIndex + 1 < level.count, isSafe(level.removing(at: badIndex + 1)).0 {
                    safe = true
                }
                else if badIndex > 1, isSafe(level.removing(at: 0)).0 {
                    safe = true
                }
                else if badIndex < level.count - 2, isSafe(level.removing(at: level.count - 1)).0 {
                    safe = true
                }
            }
            
            if safe {
                count += 1
            }
        }
        
        return count
    }
    
    func isSafe(_ level: [Int]) -> (Bool, Int?) {
        guard var left = level.first, let second = level.dropFirst().first else { return (false, nil) }
        
        let up = second > left
        
        for (index, right) in level.dropFirst().enumerated() {
            defer { left = right }
            
            var diff = right - left
            if !up {
                diff *= -1
            }
            
            if diff < 1 || diff > 3 {
                return (false, index + 1)
            }
        }
        
        return (true, nil)
    }
    
    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any {
        return countReports()
    }
    
    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any {
        // Sum the maximum entries in each set of data
        return countReports(dampen: true)
    }
}
