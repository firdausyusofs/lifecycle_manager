//
//  Lifecycle.swift
//  lifecycle_manager
//
//  Created by firdausyusof on 14/08/2023.
//

import Foundation

public enum Lifecycle: String, CaseIterable {
    
    case Foreground = "Foreground"
    case Background = "Background"
    case AppKilled = "AppKilled"
    
}
