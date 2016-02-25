//
//  ViewController.m
//  AddIconToHome
//
//  Created by liudonghuan on 16/2/24.
//  Copyright © 2016年 Dwight. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *shareIcon = [[UIButton alloc]initWithFrame:CGRectMake(50, 50, 50, 50)];
    shareIcon.backgroundColor = [UIColor redColor];
    [self.view addSubview:shareIcon];
    
    [shareIcon addTarget:self action:@selector(shareClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)shareClick
{
    //以下url替换成index.html所在服务器，下面地址是我的临时测试地址，随时报销。
    NSURL* url = [[ NSURL alloc ] initWithString :@"http://1.ldhtest.applinzi.com"];
    [[UIApplication sharedApplication ] openURL: url];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
