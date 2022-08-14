//
//  ScaleButtonStyle.swift
//  FillStorage
//
//  Created by Kirill Kostarev on 14.08.2022.
//

import Foundation
import SwiftUI

public struct ScaleButtonStyle: ButtonStyle {

    public init(scaleEffect: CGFloat = 0.9, duration: Double = 0.15) {
        self.scaleEffect = scaleEffect
        self.duration = duration
    }

    public func makeBody(configuration: Self.Configuration) -> some View {
        return configuration.label
            .scaleEffect(configuration.isPressed ? scaleEffect : 1)
            .animation(.easeInOut(duration: duration), value: configuration.isPressed)
    }

    private let scaleEffect: CGFloat
    private let duration: Double

}
