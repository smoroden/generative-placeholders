//
//  UnDeuxTroisPlaceholder.swift
//  GenerativePlaceholders
//
//  Created by Zach Smoroden on 2020-07-02.
//

import SwiftUI

public struct UnDeuxTroisPlaceholder: View {
    var step: CGFloat
    var strokeStyle: StrokeStyle
    var strokeColor: Color

    /// Generated line pattern.
    /// Inspired by https://generativeartistry.com/tutorials/un-deux-trois/
    /// - Parameters:
    ///   - step: The size of a line
    ///   - strokeStyle: How each line looks
    ///   - strokeColor: The color of the lines
    public init(step: CGFloat = CGFloat.random(in: 20...50),
                strokeStyle: StrokeStyle = StrokeStyle.init(lineWidth: CGFloat.random(in: 2...6),
                                                            lineCap: .round,
                                                            lineJoin: .round),
                strokeColor: Color = .black) {
        self.step = step
        self.strokeStyle = strokeStyle
        self.strokeColor = strokeColor
    }

    public var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 0) {
                Spacer()
                ForEach(geometry.insetSteps(stepSize: step, direction: .height), id: \.self) { y in
                    HStack(spacing: 0) {
                        Spacer()
                        ForEach(geometry.insetSteps(stepSize: step, direction: .width), id: \.self) { x in
                            VerticalLines(positions: positions(y: y, height: geometry.size.height),
                                          strokeStyle: strokeStyle,
                                          strokeColor: strokeColor)
                                .rotationEffect(.init(radians: Double.random(in: 0..<2 * Double.pi)), anchor: .center)
                        }
                        Spacer()
                    }
                }
                Spacer()
            }
        }
    }

    private func positions(y: CGFloat, height: CGFloat) -> [CGFloat] {
        let thirdOfHeight = height / 3
        
        if y < thirdOfHeight {
            return [0.5]
        } else if y < thirdOfHeight * 2 {
            return [0.2, 0.8]
        } else {
            return [0.1, 0.5, 0.9]
        }
    }
}

struct UnDeuxTroisPlaceholder_Previews: PreviewProvider {
    static var previews: some View {
        UnDeuxTroisPlaceholder()
            .previewLayout(.fixed(width: 300, height: 300))
    }
}
