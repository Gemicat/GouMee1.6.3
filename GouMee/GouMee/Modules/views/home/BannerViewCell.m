//
//  BannerViewCell.m
//  GouMee
//
//  Created by 白冰 on 2019/12/11.
//  Copyright © 2019 白冰. All rights reserved.
//

#import "BannerViewCell.h"

@implementation BannerViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        [self creatView];
    }
    return self;
}

-(void)creatView
{
  
    self.typeIcon = [UIImageView new];
    [self.contentView addSubview:self.typeIcon];
    [self.typeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];


}
@end
