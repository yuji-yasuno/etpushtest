//
//  ETLocationManagerProxy.m
//  etpushtest
//
//  Created by 楊野勇智 on 2015/08/21.
//  Copyright (c) 2015年 salesforce.com. All rights reserved.
//

#import "ETLocationManagerProxy.h"

@implementation ETLocationManagerProxy

+ (ETLocationManager*)sharedManager
{
    return [ETLocationManager locationManager];
}
@end
