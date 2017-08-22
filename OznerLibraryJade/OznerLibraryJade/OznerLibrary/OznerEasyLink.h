//
//  OznerEasyLink.h
//  OznerLibraryJade
//
//  Created by ZGY on 2017/8/21.
//  Copyright © 2017年 macpro. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/8/21  上午9:22
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

#import <Foundation/Foundation.h>
#import "EasyLink.h"

@interface OznerEasyLink : NSObject

+ (instancetype)sharedInstance;

#pragma mark All

- (void)cancleAll;


#pragma mark 1.0配网
/**
 开始配对
 
 @param ssid WIDI
 @param pwd 密码
 @param timeout 超时时间
 */
- (void)starPairWithSSID:(NSString *)ssid pwd:(NSString *)pwd timeOut:(int)timeout;

/**
 取消Version_1配网
 */
- (void)canclepairV1;

#pragma mark 2.0配网

/**
 开始配对
 
 @param ssid WIDI
 @param pwd 密码
 @param timeout 超时时间
 */
- (void)starPairV2WithSSID:(NSString *)ssid pwd:(NSString *)pwd timeOut:(int)timeout;

/**
 取消Version_1配网
 */
- (void)canclepairV2;


@end
