#import "SsoPlugin.h"

@implementation Open

- (void)getSsoToken:(CDVInvokedUrlCommand *)command {


  //CDVPluginResult* commandResult = nil;
  //commandResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@""];
  //commandResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsInt:0];
  //commandResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
  //[self.commandDelegate sendPluginResult:commandResult callbackId:command.callbackId];
    [[IDSService defaultService] authorize:^(IDSServiceObj *obj) {

        if (obj.code == IDSResultSuccess) {
            //获取用户信息
            NSLog(@"%@",obj.data);
            //[self refreshButtonStatus:YES];
           // showTxt.text = [NSString stringWithFormat:@"token:%@",obj.data];
            [[NSUserDefaults standardUserDefaults] setObject:obj.data forKey:@"login_token"];

            [self performSelector:@selector(getProfile) withObject:nil afterDelay:0.5];
        }
    }];

}

- (void)getProfile
{
    [[IDSService defaultService] getProfile:^(IDSServiceObj *obj) {

        NSString *msg = @"";

        if (obj.code == IDSResultSuccess) {
            msg = [NSString stringWithFormat:@"返回：%@",obj.data];
        }
        else{
            msg = [NSString stringWithFormat:@"返回：%@",obj.msg];
        }
        [self showMessage:msg];
        if (obj.code == IDSResultNotAuthorized) {
            //需要重新授权
            NSLog(@"需要重新授权");

            //[self refreshButtonStatus:NO];
            //showTxt.text = @"token:";
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"login_token"];

        }
    }];
}


- (void)logoutToken
{
    [[IDSService defaultService] logout:^(IDSServiceObj *obj) {

        if (obj.code == IDSResultSuccess) {
            //[self refreshButtonStatus:NO];
            //showTxt.text = @"token:";
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"login_token"];
            [self showMessage:@"登出成功"];
        }
        else{
            //[self showMessage:obj.msg];
        }
    }];


      //if (result) {
       //      pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
       //  } else {
       //      pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
       //  }
       //    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end

