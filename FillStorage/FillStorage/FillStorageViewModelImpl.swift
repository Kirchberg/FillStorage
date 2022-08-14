//
//  FillStorageViewModelImpl.swift
//  FillStorage
//
//  Created by Kirill Kostarev on 14.08.2022.
//

import Combine
import Foundation

protocol FillStorageInteractor {

    var remainingSpace: String { get }

    func fillRemainingSpace()
    func freeSpace()

}

final class FillStorageViewModelImpl: FillStorageViewModel {

    // MARK: - Internal Properties

    @Published var remainingSpace: String
    let remainingSpaceInfo: String = Static.Strings.remainingSpace
    let fillSpace: String = Static.Strings.fillSpace
    let freeSpace: String = Static.Strings.freeSpace

    let onTapFillSpace: () -> Void
    let onTapFreeSpace: () -> Void

    // MARK: - Internal Init

    init(interactor: FillStorageInteractor) {
        self.interactor = interactor

        self.remainingSpace = .init(remainingSpaceSubject.value)

        self.onTapFillSpace = { interactor.fillRemainingSpace() }
        self.onTapFreeSpace = { interactor.freeSpace() }

        timerCanceller = Timer
            .publish(every: 0.5, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                let remainingSpace = self?.interactor.remainingSpace
                self?.remainingSpaceSubject.send(remainingSpace ?? Static.Strings.calculatingSizePlaceholder)
            }

        remainingSpaceCanceller = remainingSpacePublisher
            .receive(on: RunLoop.main)
            .assign(to: \.remainingSpace, on: self)
    }

    // MARK: - Private Types

    private enum Static {

        enum Strings {

            static let calculatingSizePlaceholder = NSLocalizedString(
                "FillStorage.calculatingSizePlaceholder",
                value: "Calculating...",
                comment: ""
            )

            static let fillSpace = NSLocalizedString(
                "FillStorage.fillSpace",
                value: "💩 Clog up",
                comment: ""
            )

            static let freeSpace = NSLocalizedString(
                "FillStorage.freeSpace",
                value: "🚽 Relieve",
                comment: ""
            )

            static let remainingSpace = NSLocalizedString(
                "FillStorage.remainingSpace",
                value: "Free space on the device",
                comment: ""
            )

        }

    }

    // MARK: - Private properties

    private let interactor: FillStorageInteractor

    private var remainingSpacePublisher: AnyPublisher<String, Never> { remainingSpaceSubject.eraseToAnyPublisher() }

    private let remainingSpaceSubject = CurrentValueSubject<String, Never>(Static.Strings.calculatingSizePlaceholder)

    private var remainingSpaceCanceller: AnyCancellable?
    private var timerCanceller: AnyCancellable?

}
