//
//  ViewController.m
//  OznerLibraryJade
//
//  Created by macpro on 2017/8/18.
//  Copyright © 2017年 macpro. All rights reserved.
//

#import "ViewController.h"
#import "OznerEasyLink.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *wiftName;
@property (weak, nonatomic) IBOutlet UITextField *pwd;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.wiftName.text = @"ITDEV";
    self.pwd.text = @"87654321";
    
}

- (IBAction)startPair:(id)sender {
    
//    [[OznerEasyLink sharedInstance] starPairWithSSID:self.wiftName.text pwd:self.pwd.text timeOut:120];
    
    [[OznerEasyLink sharedInstance] starPairV2WithSSID:self.wiftName.text pwd:self.pwd.text timeOut:120];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
