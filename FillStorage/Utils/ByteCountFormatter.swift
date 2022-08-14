//
//  ByteCountFormatter.swift
//  FillStorage
//
//  Created by Kirill Kostarev on 14.08.2022.
//

import Foundation

extension ByteCountFormatter {

    static let humanReadableDiskSpaceFormatter: ByteCountFormatter = {
        let formatter = ByteCountFormatter()
        formatter.countStyle = .decimal
        formatter.allowedUnits = [.useKB, .useMB, .useGB, .useTB]
        return formatter
    }()

}
