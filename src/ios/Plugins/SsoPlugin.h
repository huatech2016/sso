#import <Cordova/CDVPlugin.h>
#import "IDS.h"
@interface SsoPlugin : CDVPlugin

- (void)getSsoToken:(CDVInvokedUrlCommand*)command;
- (void)logoutToken:(CDVInvokedUrlCommand*)command;

@property (nonatomic, strong) CDVPluginResult* result;
@property (nonatomic, strong) NSMutableArray* datas;
@property (nonatomic, strong) CDVInvokedUrlCommand* command1;

@end
