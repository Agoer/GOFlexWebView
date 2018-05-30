//
//  GoFlexWebViewNavigationBar.h
//  GOFlexWebViewDemo
//
//  Created by 李二狗 on 2018/5/30.
//  Copyright © 2018年 李二狗. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoFlexWebViewConstant.h"

@interface GoFlexWebViewNavigationBar : UIView

@property (copy, nonatomic) GoFlexWebViewButtonPressed leftButtonPressed;
@property (copy, nonatomic) GoFlexWebViewButtonPressed rightButtonPressed;

- (void)setIndent:(BOOL)indent;
@end
