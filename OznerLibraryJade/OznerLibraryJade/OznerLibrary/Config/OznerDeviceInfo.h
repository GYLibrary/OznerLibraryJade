//
//  OznerDeviceInfo.h
//  OznerLibraryJade
//
//  Created by ZGY on 2017/8/28.
//  Copyright © 2017年 macpro. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/8/28  上午10:32
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

#import <Foundation/Foundation.h>

@interface OznerDeviceInfo : NSObject

/**
 设备唯一ID
 */
@property (copy,nonatomic) NSString *deviceID;


/**
 设备Mac：访问服务器和接口的时候才用到这个，或者Wi-Fi协议里面会用这个，其余的都用deviceID
 */
@property (copy,nonatomic) NSString *devicMac;


/**
 蓝牙产品为"BLUE"
 wifi产品为 a.2.0水机 "737bc5a2-f345-11e6-9d95-00163e103941"
 b.1.0水机 MXCHIP_HAOZE_Water
 c.1.0空净 FOG_HAOZE_AIR

 */
@property (copy,nonatomic) NSString *production;


/**
 WIFI版本 1或者2
 */
@property (assign,nonatomic) int version;


@end
