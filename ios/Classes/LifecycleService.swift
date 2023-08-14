//
//  LifecycleService.swift
//  lifecycle_manager
//
//  Created by firdausyusof on 14/08/2023.
//

import Foundation

public class LifecycleService: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    private let TAG = "LifecycleService"
    
    public override init() {
        super.init()
        
        LifecycleManager
            .shared
            .startListeners()
    }
    
    // MARK: - Accessors
    
    public var currentLifeCycle: Lifecycle {
        get { return LifecycleManager.shared.currentLifeCycle }
    }
    
}
