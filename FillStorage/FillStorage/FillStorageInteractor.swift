//
//  FillStorageInteractor.swift
//  FillStorage
//
//  Created by Kirill Kostarev on 14.08.2022.
//

import UIKit
import Foundation

final class FillStorageInteractorImpl: FillStorageInteractor {

    var remainingSpace: String {
        return humanReadableDiskSpaceFormatter.string(fromByteCount: UIDevice.current.systemFreeSize)
    }

    func fillRemainingSpace() {
        freeSpaceTask?.cancel()
        fillSpaceTask?.cancel()

        let fileManager = FileManager.default
        guard let docsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let folderPath = docsDir.appendingPathComponent(Static.Layout.folderTitle)
        if !fileManager.fileExists(atPath: folderPath.path) {
            do {
                try fileManager.createDirectory(atPath: folderPath.path, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error.localizedDescription)
            }
        }

        fillSpaceTask = Task.detached(priority: .high) { [weak self] in
            self?.fillSpace()
        }
    }

    func freeSpace() {
        freeSpaceTask?.cancel()
        fillSpaceTask?.cancel()

        freeSpaceTask = Task.detached(priority: .high) {
            let fileManager = FileManager.default

            guard let docsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
            let folderPath = docsDir.appendingPathComponent(Static.Layout.folderTitle)

            if fileManager.fileExists(atPath: folderPath.path) {
                do {
                    try fileManager.removeItem(atPath: folderPath.path)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }

    // MARK: - Private Types

    private enum Static {
        enum Layout {
            static let folderTitle: String = "fill_storage_junk"
            static let fileURLSuffix: String = "fill_"
            static let fileURLExtension: String = ".storage"
        }
    }

    // MARK: - Private properties

    private let humanReadableDiskSpaceFormatter: ByteCountFormatter = .humanReadableDiskSpaceFormatter

    private var fillSpaceTask: Task<Void, Never>?
    private var freeSpaceTask: Task<Void, Never>?

    // MARK: - Private methods

    private func fillSpace(data: Data = Data([UInt8](repeating: 1, count: 512_000_000))) {
        let fileManager = FileManager.default

        guard data.count > 1, let docsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }

        let folderPath = docsDir.appendingPathComponent(Static.Layout.folderTitle)

        let fileName = Static.Layout.fileURLSuffix + UUID().uuidString + Static.Layout.fileURLExtension
        let destPath = folderPath.appendingPathComponent("/\(fileName)")

        if fileManager.createFile(atPath: destPath.path, contents: data, attributes: nil) {
            fillSpace(data: data)
        } else {
            fillSpace(data: Data([UInt8](repeating: 1, count: data.count / 2)))
        }
    }

}
