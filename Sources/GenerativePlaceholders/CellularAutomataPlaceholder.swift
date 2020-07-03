//
//  CellularAutomataPlaceholder.swift
//  iOS
//
//  Created by Zach Smoroden on 2020-07-02.
//

import SwiftUI

public struct CellularAutomataPlaceholder: View {
    typealias Rule = ((Int, Int, Int) -> Int)

    var cellSize: CGFloat = CGFloat.random(in: 10...50)
    var colors: (Color, Color) = (Color.white, Color.black)

    /// A blocky generated pattern.
    /// Inspired by https://generative-placeholders.glitch.me
    /// - Parameters:
    ///   - cellSize: The length of a side of a square
    ///   - colors: The two colours for the pattern
    public init(cellSize: CGFloat = CGFloat.random(in: 10...50),
                colors: (Color, Color) = (Color.white, Color.black)) {
        self.cellSize = cellSize
        self.colors = colors
    }

    public var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                ForEach(grid(rule: getRule(num: Int.random(in: 0...255)),
                             columns: Int(geometry.size.width / cellSize),
                             rows: Int(geometry.size.height / cellSize)),
                        id: \.self) { row in
                    HStack(spacing: 0) {
                        ForEach(row, id: \.self) { cell in
                            Rectangle()
                                .foregroundColor(cell == 0 ? colors.0 : colors.1)
                        }
                    }
                }
            }
        }
    }

    private func getBit(num: Int, pos: Int) -> Int {
        return (num >> pos) & 1
    }

    private func combine(b1: Int, b2: Int, b3: Int) -> Int {
        return (b1 << 2) + (b2 << 1) + (b3 << 0)
    }

    private func getRule(num: Int) -> Rule {
        return { b1, b2, b3 in
            getBit(num: num, pos: combine(b1: b1, b2: b2, b3: b3))
        }
    }

    private func nextRow(oldRow: [Int], rule: Rule) -> [Int] {
        var newRow = [Int]()

        for index in 0..<oldRow.count {
            newRow.append(rule(index - 1 >= oldRow.startIndex ? oldRow[index - 1] : 0, oldRow[index], index + 1 < oldRow.endIndex ? oldRow[index + 1] : 0))
        }

        return newRow
    }

    private func randomInitialRow(width: Int) -> [Int] {
        (0..<width).map { _ in Bool.random() ? 1 : 0 }
    }

    private func grid(rule: Rule, columns: Int, rows: Int) -> [[Int]] {
        var grid = [[Int]]()

        var row = randomInitialRow(width: columns)
        grid.append(row)

        (0..<rows).forEach { index in
            row = nextRow(oldRow: row, rule: rule)
            grid.append(row)
        }

        return grid
    }
}

struct CellularAutomataPlaceholder_Previews: PreviewProvider {
    static var previews: some View {
        CellularAutomataPlaceholder()
            .previewLayout(.fixed(width: 300, height: 300))
    }
}
