//
//  UIDevice.swift
//  FillStorage
//
//  Created by Kirill Kostarev on 14.08.2022.
//

import UIKit
import Foundation

extension UIDevice {

    var systemFreeSize: Int64 {
        guard let systemAttributes = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory()),
              let freeSize = (systemAttributes[.systemFreeSize] as? NSNumber)?.int64Value
        else {
            return 0
        }

        return freeSize
    }

}
