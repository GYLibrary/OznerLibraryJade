//
//  OznerEasyLink.h.m
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

#import "OznerEasyLink.h"
#import "OznerBonjourDetail.h"
#import "ZBBonjourService.h"
#import "GCDAsyncSocket.h"
static OznerEasyLink *linkV1 = nil;

@interface OznerEasyLink() <EasyLinkFTCDelegate,ZBBonjourServiceDelegate,GCDAsyncSocketDelegate>

@end

@implementation OznerEasyLink
{
    EASYLINK *easyLinkConfig;
    OznerBonjourDetail *bonJourDetail;
    GCDAsyncSocket *socket;
    BOOL isActivate;
    NSString *hostIp;

}

#pragma mark All

- (void)cancleAll{
    
    [self canclepairV1];
    [self canclepairV2];
}


/**
 发送硬件WIFI信息

 @param ssid ssid description
 @param pwd pwd description
 */
- (void) connectWifiWithSSID:(NSString *)ssid pwd:(NSString *)pwd {
    
    if (easyLinkConfig == nil) {
        easyLinkConfig = [[EASYLINK alloc] initWithDelegate:self ];
    }
    
    NSMutableDictionary *wlanConfig = [[NSMutableDictionary alloc] init];
    
    wlanConfig[KEY_SSID] = [ssid dataUsingEncoding:NSUTF8StringEncoding];
    wlanConfig[KEY_PASSWORD] = pwd;
    wlanConfig[KEY_DHCP] = [[NSNumber alloc] initWithInt:1];
    wlanConfig[KEY_IP] = [EASYLINK getIPAddress];
    wlanConfig[KEY_NETMASK] = [EASYLINK getNetMask];
    wlanConfig[KEY_GATEWAY] = [EASYLINK getGatewayAddress];
    wlanConfig[KEY_DNS1] = [EASYLINK getGatewayAddress];
    
    [easyLinkConfig prepareEasyLink_withFTC:wlanConfig info:[@"" dataUsingEncoding:NSUTF8StringEncoding] mode:EASYLINK_V2_PLUS];

}

#pragma mark 1.O配网相关
- (void)starPairWithSSID:(NSString *)ssid pwd:(NSString *)pwd timeOut:(int)timeout {
    
    [self connectWifiWithSSID:ssid pwd:pwd];
    
    @try {
        [easyLinkConfig transmitSettings];
    } @catch (NSException *exception) {
        NSLog(@"%@",exception);
    } @finally {
        NSLog(@"1.0开始配网");
    }
    
}

- (void)canclepairV1 {
    if (easyLinkConfig != nil) {
        @try {
            [easyLinkConfig stopTransmitting];
        } @catch (NSException *exception) {
            NSLog(@"%@",exception);
        } @finally {
            NSLog(@"取消1.0配网");
        }
    }
}

- (void)pairSuccessedV1WithConfigDic:(NSDictionary *)configDic {
    
    [self cancleAll];
    [easyLinkConfig unInit];
    easyLinkConfig = nil;
    bonJourDetail = nil;
    
    NSString *ip = [[[configDic valueForKey:@"C"][1] valueForKey:@"C"][3] valueForKey:@"C"];
//    __weak typeof(self) weakSelf = self;
    sleep(3);
    bonJourDetail = [[OznerBonjourDetail alloc] init:ip block:^(NSString *deviceID) {
        
        if ([deviceID containsString:@"/"]) {
            
            NSArray *deviceInfoArr = [deviceID componentsSeparatedByString:@"/"];
            NSString *str = [deviceInfoArr[1] uppercaseString];
            
            NSMutableString  *identifier = [[NSMutableString alloc] initWithFormat:@"%@", [str substringToIndex:2] ];
          
            for (int i = 1; i <= 5; i++) {
                
                NSString *tempStr = [str substringFromIndex:i*2];
                [identifier appendString:@":"];
                [identifier appendString:[tempStr substringToIndex:2]];
                NSLog(@"1.0激活成功,配网成功,deviceID:%@,productID:%@",identifier,deviceInfoArr[0]);
            }
        }
        
    }];
    
}

#pragma mark 1.0配网代理设置

- (void)onFound:(NSNumber *)client withName:(NSString *)name mataData:(NSDictionary *)mataDataDict
{
    
    [self pairInfomataData:mataDataDict];
    
}

- (void)onFoundByFTC:(NSNumber *)client withConfiguration:(NSDictionary *)configDict
{
    
    [self pairInfomataData:configDict];
    
}

- (void)onDisconnectFromFTC:(NSNumber *)client withError:(bool)err
{
    if (err) {
        NSLog(@"与FTC断开连接");
    }
}

- (void)pairInfomataData:(NSDictionary *)mataDataDict {
    
    if (mataDataDict[@"FW"]) {
        
        NSMutableString *productID =[NSMutableString stringWithFormat:@"%@", @"16a21bd6"];
        if ([mataDataDict[@"FW"] containsString:@"FOG_HAOZE_AIR"]) {
            productID = [NSMutableString stringWithFormat:@"%@", @"580c2783"];
        }
        
        [self pairSuccessedV1WithConfigDic:mataDataDict];
        
    }
    
}

#pragma mark 2.0配网相关信息

- (void)starPairV2WithSSID:(NSString *)ssid pwd:(NSString *)pwd timeOut:(int)timeout {
    
    [self connectWifiWithSSID:ssid pwd:pwd];
    
    [[ZBBonjourService sharedInstance] stopSearchDevice];
    [ZBBonjourService sharedInstance].delegate = self;
    [[ZBBonjourService sharedInstance] startSearchDevice];
    
}

- (void)canclepairV2{
    [[ZBBonjourService sharedInstance] stopSearchDevice];
    NSLog(@"2.0取消配网");
}

#pragma mark 2.0 代理相关

- (void)bonjourService:(ZBBonjourService *)service didReturnDevicesArray:(NSArray *)array {
    
    
    for (NSDictionary *item in array) {
        
        if ([item valueForKey:@"RecordData"][@"FogProductId"]) {
            
            NSString *macAdress = [item valueForKey:@"RecordData"][@"MAC"];
            //此处判断是否已经配对
            if ([item valueForKey:@"RecordData"][@"IP"]) {
                
              hostIp = [item valueForKey:@"RecordData"][@"IP"];
                
            } else {
                continue;
            }
            
            NSLog(@"搜索到新设备%@,IP:%@\n开始激活设备",macAdress,hostIp);
            [[ZBBonjourService sharedInstance] stopSearchDevice];
            
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:queue];
            
            NSError *error = nil;
            
            @try {
                [socket connectToHost:hostIp onPort:8002 error:&error];
            } @catch (NSException *exception) {
                NSLog(@"激活失败：%@",error);
            } @finally {
                break;
            }
            
        }
        
    }
    
}

# pragma mark 2.0 SocketDelegate

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err {
    
    //此处设置超时时间 超时失败
    //此处判断是否需要重新连接
    if (isActivate) {
        return;
    } else {
        NSError *error = nil;
        @try {
            [socket connectToHost:hostIp onPort:8002 error:&error];
        } @catch (NSException *exception) {
            NSLog(@"激活失败：%@",error);
        } @finally {
            NSLog(@"");
        }
    }
}

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port {
    
    NSLog(@"socket 连接成功");
    isActivate = false;
    [self canclepairV1];
    [socket readDataWithTimeout:-1 tag:200];
    
    NSString  *postUrl = @"POST / HTTP/1.1\r\n\r\n{\"getvercode\":\"\"}\r\n";
    NSData *postdata = [postUrl dataUsingEncoding:NSUTF8StringEncoding];
    
    [socket writeData:postdata withTimeout:10 tag:100];
    NSLog(@"开始激活设备");
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"激活设备成功:%@",str);
    isActivate = true;
    [socket disconnect];
}



#pragma mark 单利设置

+  (instancetype)sharedInstance {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        if (linkV1 == nil) {
            linkV1 = [[OznerEasyLink alloc] init];
        }
    });
    
    return linkV1;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        if (easyLinkConfig == nil) {
            easyLinkConfig = [[EASYLINK alloc]initWithDelegate:self];
        }
    }
    return self;
}

@end
