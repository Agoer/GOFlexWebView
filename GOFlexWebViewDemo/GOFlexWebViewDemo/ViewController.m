//
//  ViewController.m
//  GOFlexWebViewDemo
//
//  Created by 李二狗 on 2018/5/30.
//  Copyright © 2018年 李二狗. All rights reserved.
//

#import "ViewController.h"
#import "GoFlexWebViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)gotoButtonPressed:(id)sender {
    GoFlexWebViewController *webVC = [[GoFlexWebViewController alloc]init];
    [self.navigationController pushViewController:webVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
