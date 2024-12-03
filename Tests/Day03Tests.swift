import Testing

@testable import AdventOfCode


// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
struct Day03Tests {
    // Smoke test data provided in the challenge question
    let testData = """
    xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))
    """
    
    @Test func testPart1() async throws {
        let challenge = Day03(data: testData)
        #expect(String(describing: challenge.part1()) == "161")
        
        #expect(String(describing: Day03(data: "mul ( 2, 4 )").part1()) == "0")
        #expect(String(describing: Day03(data: "mul(4*,2)").part1()) == "0")
        #expect(String(describing: Day03(data: "mul(6,9!").part1()) == "0")
        #expect(String(describing: Day03(data: "?(12,34)").part1()) == "0")
    }
    
    @Test func testPart2() async throws {
        var challenge = Day03(data: "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))")
        #expect(String(describing: challenge.part2()) == "48")
        
        challenge = Day03(data: "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo?mul(8,5))")
        #expect(String(describing: challenge.part2()) == "8")
        
        challenge = Day03(data: "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()mul(8,5))")
        #expect(String(describing: challenge.part2()) == "48")
    }
}
