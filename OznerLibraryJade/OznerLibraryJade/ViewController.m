//
//  ViewController.m
//  OznerLibraryJade
//
//  Created by macpro on 2017/8/18.
//  Copyright © 2017年 macpro. All rights reserved.
//

#import "ViewController.h"
#import "OznerEasyLink.h"
#import "OznerWiFiManager.h"
@interface ViewController () <OznerPairDelegate>

@property (weak, nonatomic) IBOutlet UITextField *wiftName;
@property (weak, nonatomic) IBOutlet UITextField *pwd;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.wiftName.text = @"zach_phone";
    self.pwd.text = @"zhuguangyang1";
    
}

- (IBAction)startPair:(id)sender {
    
    [[OznerWiFiManager sharedInstance] starPairWithSSID:self.wiftName.text pwd:self.pwd.text delegate:self version:VersionTwo];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)devicePairSuccessWithDeviceInfo:(OznerDeviceInfo *)info
{
    NSLog(@"%@",info);
}

- (void)devicePairFailurWithError:(NSError *)error
{
    NSLog(@"%@",error);
}


@end
