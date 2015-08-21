//
//  ETLocationManagerProxy.h
//  etpushtest
//
//  Created by 楊野勇智 on 2015/08/21.
//  Copyright (c) 2015年 salesforce.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JB4A-SDK/ETLocationManager.h"

@interface ETLocationManagerProxy : NSObject

+(ETLocationManager*)sharedManager;

@end
