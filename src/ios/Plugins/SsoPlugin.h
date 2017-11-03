#import <Cordova/CDVPlugin.h>

@interface CDVUpdateApp : CDVPlugin

- (void)getSsoToken:(CDVInvokedUrlCommand*)command;
- (void)logoutToken:(CDVInvokedUrlCommand*)command;

@end