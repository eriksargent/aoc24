//
//  Day02.swift
//  AdventOfCode
//
//  Created by Erik Sargent on 12/2/24.
//

import Testing

@testable import AdventOfCode

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
struct Day02Tests {
    // Smoke test data provided in the challenge question
    let testData = """
    7 6 4 2 1
    1 2 7 8 9
    9 7 6 2 1
    1 3 2 4 5
    8 6 4 4 1
    1 3 6 7 9
    """
    
    @Test func testPart1() async throws {
        let challenge = Day02(data: testData)
        #expect(String(describing: challenge.part1()) == "2")
    }
    
    @Test func testPart2() async throws {
        let challenge = Day02(data: testData)
        #expect(String(describing: challenge.part2()) == "4")
        
        let edgeCases = """
        48 46 47 49 51 54 56
        1 1 2 3 4 5
        1 2 3 4 5 5
        5 1 2 3 4 5
        1 4 3 2 1
        1 6 7 8 9
        1 2 3 4 3
        9 8 7 6 7
        7 10 8 10 11
        29 28 27 25 26 25 22 20
        """
        let edgeCasesChallenge = Day02(data: edgeCases)
        #expect(String(describing: edgeCasesChallenge.part2()) == "10")
    }
}
