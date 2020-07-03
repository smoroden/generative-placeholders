//
//  CubicDisarrayPlaceholder.swift
//  GenerativePlaceholders
//
//  Created by Zach Smoroden on 2020-06-30.
//

import SwiftUI


public struct CubicDisarrayPlaceholder: View {
    var squareSize: CGFloat
    var strokeStyle: StrokeStyle
    var strokeColor: Color

    var randomDisplacement: CGFloat
    var rotateMultiplier: CGFloat

    /// A cubed placeholder that falls into dissaray.
    /// Inspired by https://generativeartistry.com/tutorials/cubic-disarray/
    /// - Parameters:
    ///   - strokeStyle: The style for the cube stroke
    ///   - squareSize: The length of the side of the cubes
    ///   - strokeColor: The colour of the stroke
    ///   - randomDisplacement: Affects the x offset of the cubes. Larger for more displacement.
    ///   - rotateMultiplier: Affects the rotation of the cubes. Larger for more rotation
    public init(strokeStyle: StrokeStyle = StrokeStyle(lineWidth: CGFloat.random(in: 1...3)),
                squareSize: CGFloat = CGFloat.random(in: 20...40),
                strokeColor: Color = .black,
                randomDisplacement: CGFloat = 15,
                rotateMultiplier: CGFloat = CGFloat.random(in: 3...20)) {
        self.strokeStyle = strokeStyle
        self.squareSize = squareSize
        self.strokeColor = strokeColor
        self.randomDisplacement = randomDisplacement
        self.rotateMultiplier = rotateMultiplier
    }

    public var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                ForEach(geometry.insetSteps(stepSize: squareSize, direction: .height), id: \.self) { y in
                    HStack(spacing: 0) {
                        ForEach(geometry.insetSteps(stepSize: squareSize, direction: .width), id: \.self) { x in
                            Rectangle()
                                .stroke(strokeColor, style: strokeStyle)
                                .rotationEffect(.init(radians: rotationAmount(geometry, y: y)), anchor: .center)
                                .offset(x: translateAmount(geometry, y: y), y: 0)
                        }
                    }
                }
            }
        }
    }

    private func translateAmount(_ geometry: GeometryProxy, y: CGFloat) -> CGFloat {
        let plusOrMinus: CGFloat = Bool.random() ? -1 : 1

        return y / geometry.size.width * plusOrMinus * CGFloat(Float.random(in: 0..<1)) * randomDisplacement
    }

    private func rotationAmount(_ geometry: GeometryProxy, y: CGFloat) -> Double {
        let plusOrMinus: CGFloat = Bool.random() ? -1 : 1

        return Double(y / geometry.size.width * CGFloat.pi / 180 * plusOrMinus * CGFloat(Float.random(in: 0..<1)) * rotateMultiplier)
    }
}

struct CubicDisarrayPlaceholder_Previews: PreviewProvider {
    static var previews: some View {
        CubicDisarrayPlaceholder()
            .previewLayout(.fixed(width: 300, height: 300))
    }
}
