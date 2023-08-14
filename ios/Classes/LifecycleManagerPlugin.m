#import "LifecycleManagerPlugin.h"
#if __has_include(<lifecycle_manager/lifecycle_manager-Swift.h>)
#import <lifecycle_manager/lifecycle_manager-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "lifecycle_manager-Swift.h"
#endif

@implementation LifecycleManagerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftLifecycleManagerPlugin registerWithRegistrar:registrar];
}
@end
