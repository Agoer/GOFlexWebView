//
//  GoFlexWebViewNavigationBar.m
//  GOFlexWebViewDemo
//
//  Created by 李二狗 on 2018/5/30.
//  Copyright © 2018年 李二狗. All rights reserved.
//

#import "GoFlexWebViewNavigationBar.h"
#import "GoFlexWebViewConstant.h"

@interface GoFlexWebViewNavigationBar()

@property (strong, nonatomic) UIButton *leftBarButton;

@property (strong, nonatomic) UILabel *naviBarTitleLabel;

@property (strong, nonatomic) UIButton *rightBarButton;

@end

@implementation GoFlexWebViewNavigationBar


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kGo_barColor;
        
        [self addSubview:self.leftBarButton];
        [self.leftBarButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.equalTo(self).offset(0);
            make.size.mas_equalTo(CGSizeMake(44, 44));
        }];
        
        [self addSubview:self.rightBarButton];
        [self.rightBarButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.equalTo(self).offset(0);
            make.size.mas_equalTo(CGSizeMake(44, 44));
        }];
        
        [self addSubview:self.naviBarTitleLabel];
        [self.naviBarTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(self).offset(-5);
            
        }];
        
        [self.leftBarButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.rightBarButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)buttonPressed:(UIButton *)sender
{
    if (sender == _leftBarButton) {
        self.leftButtonPressed(sender);
    } else if (sender == _rightBarButton) {
        self.rightButtonPressed(sender);
    }
}

- (UIButton *)leftBarButton
{
    if (!_leftBarButton) {
        _leftBarButton = [[UIButton alloc]initWithFrame:CGRectZero];
        [_leftBarButton setImage:[UIImage imageNamed:@"MP_NavBar_Icon_Close"] forState:UIControlStateNormal];
    }
    return _leftBarButton;
}

- (UILabel *)naviBarTitleLabel
{
    if (!_naviBarTitleLabel) {
        _naviBarTitleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _naviBarTitleLabel.font = [UIFont systemFontOfSize:12];
        _naviBarTitleLabel.textAlignment = NSTextAlignmentCenter;
        _naviBarTitleLabel.text = @"我的大哥";
        _naviBarTitleLabel.alpha = 0;
    }
    return _naviBarTitleLabel;
}

- (UIButton *)rightBarButton
{
    if (!_rightBarButton) {
        _rightBarButton = [[UIButton alloc]initWithFrame:CGRectZero];
        [_rightBarButton setImage:[UIImage imageNamed:@"MP_NavBar_Icon_More"] forState:UIControlStateNormal];
    }
    return _rightBarButton;
}

- (void)setIndent:(BOOL)indent
{
    if (indent) {
        self.naviBarTitleLabel.alpha = 1;
        self.leftBarButton.alpha = 0;
        self.rightBarButton.alpha = 0;
         self.naviBarTitleLabel.transform = CGAffineTransformScale(self.naviBarTitleLabel.transform, 0.5, 0.5);
    } else {
        self.naviBarTitleLabel.alpha = 1;
        self.leftBarButton.alpha = 1;
        self.rightBarButton.alpha = 1;
        self.naviBarTitleLabel.font = [UIFont systemFontOfSize:17];
        self.naviBarTitleLabel.transform = CGAffineTransformScale(self.naviBarTitleLabel.transform, 2, 2);
    }
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
