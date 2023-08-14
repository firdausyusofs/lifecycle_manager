//
//  Bundle+Extension.swift
//  lifecycle_manager
//
//  Created by firdausyusof on 14/08/2023.
//

import Foundation

extension Bundle {
    
    func getBundleName() -> String {
        var finalBundleName = Bundle.main.bundleIdentifier ?? "unknown"
        return finalBundleName
    }
    
}
