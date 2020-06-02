//
//  MQGradientProgressView.m
//  MQGradientProgress
//
//  Created by 小马 on 2017/7/24.
//  Copyright © 2017年 maqi. All rights reserved.
//

#import "MQGradientProgressView.h"





@interface MQGradientProgressView ()

@property (nonatomic, strong) UILabel *bgLayer;
@property (nonatomic, strong) UILabel *gradientLayer;


@end


@implementation MQGradientProgressView

#pragma mark -
#pragma mark - GET ---> view

- (UILabel *)bgLayer {
    if (!_bgLayer) {
        _bgLayer = [[UILabel alloc]init];
        //一般不用frame，因为不支持隐式动画
        _bgLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
//        _bgLayer.anchorPoint = CGPointMake(0, 0);
        _bgLayer.layer.backgroundColor = self.bgProgressColor.CGColor;
        _bgLayer.layer.cornerRadius = self.frame.size.height / 2.;
        [self addSubview:_bgLayer];
    }
    return _bgLayer;
}

- (UILabel *)gradientLayer {
    if (!_gradientLayer) {
        _gradientLayer = [[UILabel alloc]init];
        _gradientLayer.frame = CGRectMake(0, 0, self.frame.size.width * self.progress, self.frame.size.height);
//        _gradientLayer.startPoint = CGPointMake(0, 0);
//        _gradientLayer.endPoint = CGPointMake(1, 0);
//        _gradientLayer.anchorPoint = CGPointMake(0, 0);
        NSArray *colorArr = self.colorArr;
        _gradientLayer.colors = colorArr;
        _gradientLayer.layer.cornerRadius = self.frame.size.height / 2.;
        [self addSubview:_gradientLayer];
    }
    return _gradientLayer;
}

#pragma mark -
#pragma mark - SET ---> data

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    if (_progress>0) {
         [self updateView];
    }
   
}

- (void)setColorArr:(NSArray *)colorArr {
    if (colorArr.count >= 2) {
        _colorArr = colorArr;
           self.gradientLayer.colors = _colorArr;
//        [self updateView];
    }else {
        NSLog(@">>>>>颜色数组个数小于2，显示默认颜色");
    }
}
-(void)setBgProgressColor:(UIColor *)bgProgressColor
{
    _bgProgressColor = bgProgressColor;
    [self updateView];
}
#pragma mark -
#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self config];
        [self simulateViewDidLoad];
       
        self.progress = 0.65;
    }
    return self;
}

- (void)simulateViewDidLoad {
    [self addSubViewTree];
}

- (void)config {
   
}

- (void)addSubViewTree {
    [self bgLayer];
    [self gradientLayer];
}

- (void)updateView {
    self.gradientLayer.frame = CGRectMake(0, 0, self.frame.size.width * self.progress, self.frame.size.height);
    self.bgLayer.layer.backgroundColor = self.bgProgressColor.CGColor;
}

@end
