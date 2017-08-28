//
//  OznerWiFiManager.h
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

#import <Foundation/Foundation.h>

@protocol OznerPairDelegate <NSObject>

@optional

- (void)devicePairSuccess;

- (void)devicePairFailurWithError:(NSError *)error;


@end


typedef enum : NSUInteger {
    VersionOne,
    VersionTwo,
    AllVersion,
} OznerWifiVersion;

@interface OznerWiFiManager : NSObject

@property (weak,nonatomic) id<OznerPairDelegate> delegate;

- (instancetype)sharedInstance;


/**
 start pair

 @param ssid ssid description
 @param pwd pwd description
 @param version 配网版本
 */
- (void)starPairWithSSID:(NSString *)ssid pwd:(NSString *)pwd delegate:(id <OznerPairDelegate>)delegate version:(OznerWifiVersion)version;

/**
 cancle pair
 */
- (void)canclePair;


/**
 已存在的设备

 @param mac mac description
 @return return value description
 */
- (BOOL)foundDeviceIsExistWithMac:(NSString *)mac;

@end
