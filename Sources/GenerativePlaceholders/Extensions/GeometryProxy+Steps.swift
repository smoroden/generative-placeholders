//
//  GeometryProxy+Steps.swift
//  iOS
//
//  Created by Zach Smoroden on 2020-07-02.
//

import SwiftUI

extension GeometryProxy {
    enum Direction {
        case width
        case height
    }

    func insetSteps(stepSize: CGFloat, direction: Direction) -> [CGFloat] {
        var endpoint: CGFloat = -stepSize
        switch direction {
        case .height:
            endpoint += size.height
        case .width:
            endpoint += size.width
        }

        return stride(from: stepSize, to: endpoint, by: stepSize).map { $0 }
    }

    func steps(stepSize: CGFloat, direction: Direction) -> [CGFloat] {
        var endpoint: CGFloat
        switch direction {
        case .height:
            endpoint = size.height
        case .width:
            endpoint = size.width
        }

        return stride(from: 0, to: endpoint, by: stepSize).map { $0 }
    }
}
