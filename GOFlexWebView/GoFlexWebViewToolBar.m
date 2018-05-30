//
//  GoFlexWebViewToolBar.m
//  GOFlexWebViewDemo
//
//  Created by 李二狗 on 2018/5/30.
//  Copyright © 2018年 李二狗. All rights reserved.
//

#import "GoFlexWebViewToolBar.h"
#import "GoFlexWebViewConstant.h"

@interface GoFlexWebViewToolBar()

@property (strong, nonatomic) UIButton *leftBackButton;

@property (strong, nonatomic) UIButton *rightForwardButton;

@end

@implementation GoFlexWebViewToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kGo_barColor;
        
        [self addSubview:self.leftBackButton];
        [self.leftBackButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(0);
            make.bottom.equalTo(self).offset(0);
            make.left.equalTo(self).offset(kGo_ScreenWidth/2 - 100);
        }];
        
        [self addSubview:self.rightForwardButton];
        [self.rightForwardButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(0);
            make.bottom.equalTo(self).offset(0);
            make.left.equalTo(self).offset(kGo_ScreenWidth/2 + 100-49);
        }];
        
        
        [self.leftBackButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.rightForwardButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)buttonPressed:(UIButton *)sender
{
    if (sender == _leftBackButton) {
        self.backButtonPressed(sender);
    } else if (sender == _rightForwardButton) {
        self.forwardButtonPressed(sender);
    }
}

- (UIButton *)leftBackButton
{
    if (!_leftBackButton) {
        _leftBackButton = [[UIButton alloc]initWithFrame:CGRectZero];
        [_leftBackButton setImage:[UIImage imageNamed:@"WebView_ToolBar_Icon_Back"] forState:UIControlStateNormal];
        [_leftBackButton setImage:[UIImage imageNamed:@"WebView_ToolBar_Icon_Back_Disable"] forState:UIControlStateDisabled];
        
    }
    return _leftBackButton;
}


- (UIButton *)rightForwardButton
{
    if (!_rightForwardButton) {
        _rightForwardButton = [[UIButton alloc]initWithFrame:CGRectZero];
        [_rightForwardButton setImage:[UIImage imageNamed:@"WebView_ToolBar_Icon_Next"] forState:UIControlStateNormal];
        [_rightForwardButton setImage:[UIImage imageNamed:@"WebView_ToolBar_Icon_Next_Disable"] forState:UIControlStateNormal];
    }
    return _rightForwardButton;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
