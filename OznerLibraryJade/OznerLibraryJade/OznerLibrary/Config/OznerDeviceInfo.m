//
//  OznerDeviceInfo.m
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

#import "OznerDeviceInfo.h"

@implementation OznerDeviceInfo

- (id)initWithCoder:(NSCoder *)aDecoder{

    
    if (self = [super init]) {
        
        self.deviceID = [aDecoder decodeObjectForKey:@"deviceID"];
        self.devicMac = [aDecoder decodeObjectForKey:@"devicMac"];
        self.production = [aDecoder decodeObjectForKey:@"production"];
        self.version = [aDecoder decodeIntForKey:@"version"];
        
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:self.deviceID forKey:@"deviceID"];
    [aCoder encodeObject:self.devicMac forKey:@"devicMac"];
    [aCoder encodeObject:self.production forKey:@"production"];
    [aCoder encodeInt:self.version forKey:@"version"];
}

@end
