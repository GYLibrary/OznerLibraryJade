//
//  OznerDeviceInfoOC.m
//  OznerLbFrameWork
//
//  Created by ZGY on 2017/8/14.
//  Copyright © 2017年 macpro. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/8/14  上午11:31
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

#import "OznerDeviceInfoOC.h"

@implementation OznerDeviceInfoOC

- (instancetype)initWithBrand:(NSString *)deviceID deviceMac:(NSString *)deviceMac deviceType:(NSString *)deviceType productID:(NSString *)productID wifiVersion:(NSString *)wifiVersion {
    self = [super init];
    if (self) {
        _deviceID = deviceID;
        _deviceMac = deviceMac;
        _deviceType = deviceType;
        _productID = productID;
        _wifiVersion = wifiVersion;
    }
    return self;
}





@end
