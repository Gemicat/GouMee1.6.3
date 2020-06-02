//
//  MSSAutoresizeLabelFlowCell.m
//  XDAutoresizeLabelFlow
//
//  Created by Celia on 2018/4/11.
//  Copyright © 2018年 HP. All rights reserved.
//

#import "XDAutoresizeLabelFlowCell.h"
#import "XDAutoresizeLabelFlowConfig.h"
#define JKColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
@interface XDAutoresizeLabelFlowCell ()

@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation XDAutoresizeLabelFlowCell

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = COLOR_STR(0x333333);
        _titleLabel.font = font(12);
        _titleLabel.layer.cornerRadius = [XDAutoresizeLabelFlowConfig shareConfig].itemHeight/2.0;
        _titleLabel.layer.masksToBounds = YES;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = COLOR_STR(0xF2F2F2);
    }
    return _titleLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

- (void)configCellWithTitle:(NSString *)title {
    self.titleLabel.frame = self.bounds;
    self.titleLabel.text = title;
}

- (void)setBeSelected:(BOOL)beSelected {
    _beSelected = beSelected;
//    if (beSelected) {
//        self.titleLabel.backgroundColor = COLOR_STR(0xf2f2f2);
//        self.titleLabel.textColor = [XDAutoresizeLabelFlowConfig shareConfig].textSelectedColor;
//    }else {
//       self.titleLabel.backgroundColor = COLOR_STR(0xf2f2f2);
//        self.titleLabel.textColor = [XDAutoresizeLabelFlowConfig shareConfig].textColor;
//    }
}

@end
