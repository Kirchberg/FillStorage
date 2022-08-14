//
//  FillStorageViewFactory.swift
//  FillStorage
//
//  Created by Kirill Kostarev on 14.08.2022.
//

import UIKit
import SwiftUI

final class DebugPanelFillStorageViewFactory {

    // MARK: - Internal methods

    func makeViewController() -> UIViewController {
        let interactor = FillStorageInteractorImpl()
        let model = FillStorageViewModelImpl(interactor: interactor)
        let view = FillStorageView(model: model)
        let viewController = UIHostingController(rootView: view)
        return viewController
    }

    func makeView() -> some View {
        let interactor = FillStorageInteractorImpl()
        let model = FillStorageViewModelImpl(interactor: interactor)
        let view = FillStorageView(model: model)
        return view
    }

}
