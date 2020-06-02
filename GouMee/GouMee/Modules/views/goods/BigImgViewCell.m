//
//  BigImgViewCell.m
//  xiaolvlan
//
//  Created by 白冰 on 2019/4/26.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "BigImgViewCell.h"

@implementation BigImgViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        [self drawSubviews];
    }
    return self;
}
- (void)drawSubviews {
    self.bigImg = [UIImageView new];
    [self addSubview:self.bigImg];
    [self.bigImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(0);
    }];
}
@end
