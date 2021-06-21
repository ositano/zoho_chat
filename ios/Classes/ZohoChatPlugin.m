#import "ZohoChatPlugin.h"
#if __has_include(<zoho_chat/zoho_chat-Swift.h>)
#import <zoho_chat/zoho_chat-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "zoho_chat-Swift.h"
#endif

@implementation ZohoChatPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftZohoChatPlugin registerWithRegistrar:registrar];
}
@end
