import Flutter
import UIKit

public class SwiftLifecycleManagerPlugin: NSObject, FlutterPlugin {
    
    static var flutterRegistrantCallback: FlutterPluginRegistrantCallback?
    var lifecycleService: LifecycleService?
    var flutterChannel:FlutterMethodChannel?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "lifecycle_manager", binaryMessenger: registrar.messenger())
        
        SwiftLifecycleManagerPlugin()
            .onAttachedEngine(usingRegistrar: registrar, throughFlutterChannel: channel)
    }
    
    public func detachFromEngine(for registrar: FlutterPluginRegistrar) {
        flutterChannel = nil
        
        lifecycleService = nil
    }
    
    public static func setPluginRegistrantCallback(_ callback: FlutterPluginRegistrantCallback) {
        flutterRegistrantCallback = callback
    }
    
    public func onAttachedEngine(usingRegistrar registrar: FlutterPluginRegistrar, throughFlutterChannel channel: FlutterMethodChannel) {
        
        flutterChannel = channel
        
        lifecycleService = LifecycleService()
        
        registrar.addMethodCallDelegate(self, channel: self.flutterChannel!)
        registrar.addApplicationDelegate(self)
        
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      
      switch call.method {
        case Keys.CHANNEL_METHOD_GET_APP_LIFE_CYCLE:
          methodGetAppLifecycle(call: call, result: result)
          return
        default:
          result(FlutterMethodNotImplemented)
          return
      }
      
    }
    
    private func methodGetAppLifecycle(call: FlutterMethodCall, result: @escaping FlutterResult) {
        result(lifecycleService?.currentLifeCycle.rawValue)
    }
    
}
