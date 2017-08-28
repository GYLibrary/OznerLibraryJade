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

- (void)starPairWithSSID:(NSString *)ssid pwd:(NSString *)pwd delegate:(id <OznerPairDelegate>)delegate version:(OznerWifiVersion)version
{
    
    
    __block typeof(self)  __weakSelf = self;
    
    if (version == VersionOne) {
        
        [[OznerEasyLink sharedInstance] starPairWithSSID:ssid pwd:pwd success:^(OznerDeviceInfo *info) {
            
            [__weakSelf blockSuccesActionWithDelegate:delegate deviceInfo:info];
            
        } failure:^(NSError *error) {
            
            [__weakSelf blockFaliureActionWithDelegate:delegate error:error];
            
        } timeOut:120];
    } else if (version == VersionTwo) {
        
        [[OznerEasyLink sharedInstance] starPairV2WithSSID:ssid pwd:pwd success:^(OznerDeviceInfo *info) {
            
            [__weakSelf blockSuccesActionWithDelegate:delegate deviceInfo:info];
            
        } failure:^(NSError *error) {
            
            [__weakSelf blockFaliureActionWithDelegate:delegate error:error];

            
        } timeOut:120];
        
    } else {
        
        [[OznerEasyLink sharedInstance] starPairWithSSID:ssid pwd:pwd success:^(OznerDeviceInfo *info) {
            
            [__weakSelf blockSuccesActionWithDelegate:delegate deviceInfo:info];

            
        } failure:^(NSError *error) {
            
            [__weakSelf blockFaliureActionWithDelegate:delegate error:error];
            
        } timeOut:120];
        
        [[OznerEasyLink sharedInstance] starPairV2WithSSID:ssid pwd:pwd success:^(OznerDeviceInfo *info) {
            
            [__weakSelf blockSuccesActionWithDelegate:delegate deviceInfo:info];

            
        } failure:^(NSError *error) {
            
             [__weakSelf blockFaliureActionWithDelegate:delegate error:error];
            
        } timeOut:120];
        
    }

}

- (void)blockSuccesActionWithDelegate:(id<OznerPairDelegate>)delegate deviceInfo:(OznerDeviceInfo*)info {
    
    if ([delegate respondsToSelector:@selector(devicePairSuccessWithDeviceInfo:)]) {
        
        [delegate devicePairSuccessWithDeviceInfo:info];
        
    }
    
}

- (void)blockFaliureActionWithDelegate:(id<OznerPairDelegate>)delegate error:(NSError*)error {

    if ([delegate respondsToSelector:@selector(devicePairFailurWithError:)]) {
        
        [delegate devicePairFailurWithError:error];
        
    }
    
}

- (void)canclePair {
    
    [[OznerEasyLink sharedInstance] cancleAll];
}

@end
