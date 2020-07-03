//
//  VerticalLines.swift
//  GenerativePlaceholders
//
//  Created by Zach Smoroden on 2020-07-02.
//

import SwiftUI

struct VerticalLines: View {
    /// Determines how many lines will be drawn in the frame and at what percentage of the width
    var positions: [CGFloat]
    /// What the line will look like
    var strokeStyle: StrokeStyle
    /// The colour of the line
    var strokeColor: Color = .black

    var body: some View {
        GeometryReader { geometry in
            Path { path in
                for position in positions {
                    path.move(to: .init(x: position * geometry.size.width, y: 0))

                    guard let current = path.currentPoint else { return }
                    path.addLine(to: .init(x: current.x, y: current.y + geometry.size.height))
                }
            }
            .stroke(strokeColor, style: strokeStyle)
        }
    }
}

struct Line_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VerticalLines(positions: [0.5],
                          strokeStyle: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
            VerticalLines(positions: [0.2, 0.8],
                          strokeStyle: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
            VerticalLines(positions: [0.1, 0.5, 0.9],
                          strokeStyle: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
        }
    }
}
