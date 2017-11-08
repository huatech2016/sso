#import "SsoPlugin.h"

@implementation CDVSso

@synthesize datas, result,command1;


- (void)getSsoToken:(CDVInvokedUrlCommand *)command {

  //CDVPluginResult* commandResult = nil;
  //commandResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@""];
  //commandResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsInt:0];
  //commandResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
  //[self.commandDelegate sendPluginResult:commandResult callbackId:command.callbackId];
    //array = [[NSArray alloc] initWithArray:nil];
   //pluginResult = [CDVPluginResult resultWithStatus:(CDVCommandStatus_OK) messageAsArray:array];
    datas = [[NSMutableArray alloc] init];
    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsArray:datas];
    command1 = command;
    [result setKeepCallbackAsBool:YES];
    
    [[IDSService defaultService] authorize:^(IDSServiceObj *obj) {
        
        
        if (obj.code == IDSResultSuccess) {
            //获取用户信息
            //NSLog(@"%@",obj.data);
            [[NSUserDefaults standardUserDefaults] setObject:obj.data forKey:@"login_token"];
            NSString *token = obj.data;
            [datas addObject:token];
            [self performSelector:@selector(getProfile) withObject:nil afterDelay:0.5];
        }
    }];

}

- (void)getProfile
{
    [[IDSService defaultService] getProfile:^(IDSServiceObj *obj) {

        NSString *msg = @"需要重新授权";

        if (obj.code == IDSResultSuccess) {
            [datas addObject:[obj.data description]];
        }
        
        if (obj.code == IDSResultNotAuthorized) {
            NSLog(@"需要重新授权");
             [datas addObject:msg];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"login_token"];

        }
        
        [result setKeepCallbackAsBool:NO];
        [self.commandDelegate sendPluginResult:result callbackId:command1.callbackId];
    }];
}


- (void)logoutToken:(CDVInvokedUrlCommand *)command2
{
    [[IDSService defaultService] logout:^(IDSServiceObj *obj) {
        CDVPluginResult *commandResult = nil;
        if (obj.code == IDSResultSuccess) {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"login_token"];
              commandResult = [CDVPluginResult resultWithStatus:(CDVCommandStatus_OK) messageAsString:@"登出成功"];
        }
        else{
            commandResult = [CDVPluginResult resultWithStatus:(CDVCommandStatus_OK) messageAsString:obj.msg]; ;
        }
        
         [self.commandDelegate sendPluginResult:commandResult callbackId:command2.callbackId];
    }];
}

@end

