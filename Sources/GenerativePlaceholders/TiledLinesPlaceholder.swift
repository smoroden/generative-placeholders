//
//  TiledLinesPlaceholder.swift
//  GenerativePlaceholders
//
//  Created by Zach Smoroden on 2020-06-29.
//


import SwiftUI

public struct TiledLinesPlaceholder: View {
    var step: CGFloat = CGFloat.random(in: 15...40)
    var strokeStyle: StrokeStyle = StrokeStyle(lineWidth: CGFloat.random(in: 1...4))
    var background: Color = .white
    var strokeColor: Color = .black

    /// Inspired by https://generativeartistry.com/tutorials/tiled-lines/
    /// - Parameters:
    ///   - step: Controls how large the lines can be
    ///   - strokeStyle: Styles the lines
    ///   - background: The background color of the view
    ///   - strokeColor: The color of the lines
    public init(step: CGFloat = CGFloat.random(in: 15...40),
                strokeStyle: StrokeStyle = StrokeStyle(lineWidth: CGFloat.random(in: 1...4)),
                background: Color = .white,
                strokeColor: Color = .black) {
        self.step = step
        self.strokeStyle = strokeStyle
        self.background = background
        self.strokeColor = strokeColor
    }

    public var body: some View {
        GeometryReader { geometry in
            Path { path in
                let xSequence = stride(from: 0, to: geometry.size.width, by: step)
                let ySequence = stride(from: 0, to: geometry.size.height, by: step)

                for x in xSequence {
                    for y in ySequence {
                        draw(path: &path, geometry: geometry, x: x, y: y, width: step, height: step)
                    }
                }
            }
            .stroke(strokeColor, style: strokeStyle)
            .background(background)
        }
    }

    private func draw( path: inout Path, geometry: GeometryProxy, x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        if leftToRight {
            path.move(to: CGPoint(x: x, y: y))
            path.addLine(to: CGPoint(x: x + width, y: y + height))
        } else {
            path.move(to: CGPoint(x: x + width, y: y))
            path.addLine(to: CGPoint(x: x, y: y + height))
        }
    }

    private var leftToRight: Bool {
        return Bool.random()
    }
}

struct TiledLinesPlaceholder_Previews: PreviewProvider {
    static var previews: some View {
        TiledLinesPlaceholder()
    }
}
