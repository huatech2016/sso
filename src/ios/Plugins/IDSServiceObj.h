//
//  IDSServiceObj.h
//  IDS6
//
//  Created by dyf on 15/11/9.
//  Copyright © 2015年 wisorg. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IDSServiceObj;
typedef void(^IDSResponseBlock)(IDSServiceObj *obj);

typedef enum
{
    IDSResultSuccess = 0,
    IDSResultAuthorizeCancel,
    IDSResultAuthorizeFailed,
    IDSResultNotAuthorized,
    IDSResultRequestTimedOut,
    IDSResultRequestConnectionFailure
    
}IDSResultCode;


@interface IDSServiceObj : NSObject

@property (nonatomic, assign) IDSResultCode code;
@property (nonatomic, strong) id data;
@property (nonatomic, copy) NSString *msg;
@end
