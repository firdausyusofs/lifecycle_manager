//
//  LifecycleManager.swift
//  lifecycle_manager
//
//  Created by firdausyusof on 14/08/2023.
//

import Foundation

public class LifecycleManager: NSObject, UIApplicationDelegate {
    
    private let TAG = "LifecycleManager"
    private let referenceKey: String = "currentlifeCycle"
    
    static let _userDefaults = UserDefaults(suiteName: Keys.USER_DEFAULT_TAG)
    
    // MARK: - Singleton
    
    static var instance: LifecycleManager?
    public static var shared: LifecycleManager {
        get {
            LifecycleManager.instance = LifecycleManager.instance ?? LifecycleManager()
            return LifecycleManager.instance!
        }
    }
    
    private override init() {
        super.init()
    }
    
    // MARK: - Listeners
    
    private var listening = false
    public func startListeners() {
        guard !listening else { return }
        listening.toggle()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.applicationDidBecomeActive),
            name: UIApplication.didBecomeActiveNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.applicationWillResignActive),
            name: UIApplication.willResignActiveNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.applicationDidEnterBackground),
            name: UIApplication.didEnterBackgroundNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.applicationWillTerminate),
            name: UIApplication.willTerminateNotification,
            object: nil
        )
    }
    
    deinit {
        if listening {
            NotificationCenter.default.removeObserver(self)
        }
    }
    
    // MARK: - Variables
    
    private var _oldLifecycle: Lifecycle?
    private var _currentLifecycle: Lifecycle?
    
    public var currentLifeCycle: Lifecycle {
        get {
            return _currentLifecycle ?? Lifecycle.AppKilled
        }
        set {
            _currentLifecycle = newValue
            
            LifecycleManager
                ._userDefaults?
                .setValue(newValue.rawValue, forKey: referenceKey)
            
            if _currentLifecycle == .Foreground {
                _isForeground = true
            }
            
            if _currentLifecycle != _oldLifecycle {
                _oldLifecycle = _currentLifecycle
                Logger.d(TAG, "App is now \(newValue.rawValue)")
            }
        }
    }
    
    private var _isOutOfFocus = false
    public var isOutOfFocus: Bool {
        get {
            return _isOutOfFocus
        }
    }
    
    private var _isForeground = false
    public var isForeground: Bool {
        get {
            return _isForeground
        }
    }
    
    // MARK: - Functions
    
    public func applicationDidBecomeActive(_ application: UIApplication) {
        currentLifeCycle = .Foreground
        _isOutOfFocus = false
    }
    
    public func applicationWillResignActive(_ application: UIApplication) {
        _isOutOfFocus = true
    }
    
    public func applicationDidEnterBackground(_ application: UIApplication) {
        currentLifeCycle = isForeground ? .Background : .AppKilled
    }
    
    public func applicationWillTerminate(_ application: UIApplication) {
        currentLifeCycle = .AppKilled
    }
    
}
