//
//  ContentView.swift
//  FillStorage
//
//  Created by Kirill Kostarev on 14.08.2022.
//

import SwiftUI
import Combine

protocol FillStorageViewModel: ObservableObject {

    var remainingSpace: String { get }
    var remainingSpaceInfo: String { get }
    var freeSpace: String { get }
    var fillSpace: String { get }

    var onTapFillSpace: () -> Void { get }
    var onTapFreeSpace: () -> Void { get }

}

struct FillStorageView<Model: FillStorageViewModel>: View {

    @ObservedObject var model: Model

    // MARK: - Content

    var body: some View {
        content
    }

    private var content: some View {
        GeometryReader { geometry in
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    Spacer(minLength: 10)
                    centerContent
                    Spacer(minLength: 32)
                    bottomContent(geometry: geometry)
                }
                .frame(minHeight: geometry.size.height)
            }
        }
        .padding(.horizontal, 16)
        .frame(maxWidth: Static.Layout.contentMaxWidth)
    }

    private var centerContent: some View {
        VStack(spacing: 0) {
            Text(model.remainingSpace)
                .font(.system(size: 48, weight: .black))
                .foregroundColor(Static.Colors.remainingSpaceText)
                .padding(.bottom, 8)
            Text(model.remainingSpaceInfo)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(Static.Colors.annotationText)
                .fontWeight(.semibold)
        }
    }

    @ViewBuilder
    private func bottomContent(geometry: GeometryProxy) -> some View {
        VStack(spacing: 0) {
            Button {
                model.onTapFillSpace()
            } label: {
                Text(model.fillSpace)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(Static.Colors.buttonText)
                    .padding(.vertical, 12)
                    .frame(width: geometry.size.width)
                    .background(Static.Colors.buttonBackground)
                    .clipShape(Capsule())
            }
            .padding(.bottom, 8)
            .buttonStyle(ScaleButtonStyle())

            Button {
                model.onTapFreeSpace()
            } label: {
                Text(model.freeSpace)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(Static.Colors.buttonText)
                    .padding(.vertical, 12)
                    .frame(width: geometry.size.width)
                    .background(Static.Colors.buttonBackground)
                    .clipShape(Capsule())
            }
            .padding(.bottom, 20)
            .buttonStyle(ScaleButtonStyle())
        }
    }

    // MARK: - Static

    private enum Static {

        enum Colors {
            static var remainingSpaceText: Color { Color(UIColor.label) }
            static var annotationText: Color { Color("annotationColor") }
            static var buttonText: Color { Color(UIColor.label) }
            static var buttonBackground: Color { Color("buttonBackground") }
        }

        enum Layout {
            static var contentMaxWidth: CGFloat { 672 }
        }

    }

}

// MARK: - Examples

final class FillStorageViewModelMock: FillStorageViewModel {

    let remainingSpace: String
    let remainingSpaceInfo: String
    let freeSpace: String
    let fillSpace: String
    let onTapFillSpace: () -> Void
    let onTapFreeSpace: () -> Void

    init() {
        self.remainingSpace = String.Examples.Text.normal
        self.remainingSpaceInfo = String.Examples.Text.normal
        self.freeSpace = String.Examples.Text.normal
        self.fillSpace = String.Examples.Text.normal
        self.onTapFillSpace = {}
        self.onTapFreeSpace = {}
    }

    enum Examples {
        static let normal = FillStorageViewModelMock()
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FillStorageView(model: FillStorageViewModelMock.Examples.normal)
    }
}
