//
//  OznerWiFiManager.m
//  OznerLibraryJade
//
//  Created by ZGY on 2017/8/22.
//  Copyright © 2017年 macpro. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/8/22  下午2:48
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

#import "OznerWiFiManager.h"
#import "OznerEasyLink.h"

@implementation OznerWiFiManager

- (instancetype)sharedInstance
{
    
    static OznerWiFiManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[OznerWiFiManager alloc] init];
    });
    
    return manager;
    
}

#pragma mark - found the device in SQL

- (BOOL)foundDeviceIsExistWithMac:(NSString *)mac {
    
    return false;
}


#pragma mark - start or cancle pair

- (void)starPairWithSSID:(NSString *)ssid pwd:(NSString *)pwd version:(OznerWifiVersion)version
{
    
    switch (version) {
        case VersionOne:
            [[OznerEasyLink sharedInstance] starPairWithSSID:ssid pwd:pwd timeOut:120];
            break;
        case VersionTwo:
            [[OznerEasyLink sharedInstance] starPairV2WithSSID:ssid pwd:pwd timeOut:120];
            break;
        case AllVersion:
            [[OznerEasyLink sharedInstance] starPairWithSSID:ssid pwd:pwd timeOut:120];
            [[OznerEasyLink sharedInstance] starPairV2WithSSID:ssid pwd:pwd timeOut:120];
            break;
        default:
            break;
    }
    
}

- (void)canclePair {
    
    [[OznerEasyLink sharedInstance] cancleAll];
}

@end
