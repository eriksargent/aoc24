import Algorithms


struct Day09: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String
    
    
    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any {
        var isBlock = true
        var index = 0
        var blocks = [Int?]()
        for char in data.trimmingCharacters(in: .whitespacesAndNewlines) {
            guard let value = Int(String(char)) else { continue }
            
            if isBlock {
                blocks.append(contentsOf: [Int?](repeating: index, count: value))
                index += 1
                isBlock = false
            } else {
                blocks.append(contentsOf: [Int?](repeating: nil, count: value))
                isBlock = true
            }
        }
        
        var checksum = 0
        
        var start = 0
        var end = blocks.count - 1
        while start < end {
            while let value = blocks[start], start < end {
                checksum += value * start
                start += 1
            }
            
            while blocks[end] == nil, start < end {
                end -= 1
            }
            
            if start <= end, let value = blocks[end] {
                checksum += value * start
                start += 1
                end -= 1
                
                if start == end, let value = blocks[start] {
                    checksum += value * start
                }
            }
        }
        
        return checksum
    }
    
    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any {
        var isBlock = true
        var index = 0
        var emptyIndicies = [Int]()
        var blocks = [(size: Int, value: Int?)]()
        for char in data.trimmingCharacters(in: .whitespacesAndNewlines) {
            guard let value = Int(String(char)) else { continue }
            
            if isBlock {
                blocks.append((size: value, value: index))
                index += 1
                isBlock = false
            } else {
                emptyIndicies.append(blocks.count)
                blocks.append((size: value, value: nil))
                isBlock = true
            }
        }
        
        var end = blocks.count - 1
        // Skipping first block as it'll always be a block
        while end > 0 {
            let (size, value) = blocks[end]
            guard let value else {
                end -= 1
                continue
            }
            
            for (indexOrder, possibleIndex) in emptyIndicies.enumerated() {
                let blockSize = blocks[possibleIndex].size
                if blockSize >= size {
                    blocks[possibleIndex].value = value
                    emptyIndicies.remove(at: indexOrder)
                    blocks[end].value = nil
                    
                    if blockSize > size {
                        for index in indexOrder..<emptyIndicies.count {
                            emptyIndicies[index] += 1
                        }
                        emptyIndicies.insert(possibleIndex + 1, at: indexOrder)
                        blocks.insert((size: blockSize - size, value: nil), at: possibleIndex + 1)
                        blocks[possibleIndex].size = size
                        end += 1
                    }
                    
                    break
                }
            }
            
            end -= 1
            
            while let last = emptyIndicies.last, last >= end {
                emptyIndicies.removeLast()
            }
        }
        
        var checksum = 0
        index = 0
        for block in blocks {
            guard let value = block.value else {
                index += block.size
                continue
            }
            
            for _ in 0..<block.size {
                checksum += index * value
                index += 1
            }
        }
        
        return checksum
    }
}
