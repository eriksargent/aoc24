//
//  Numeric.swift
//  AdventOfCode
//
//  Created by Erik Sargent on 12/2/24.
//


extension Array where Element: Numeric {
    public func sum() -> Element {
        return self.reduce(0, +)
    }
}
