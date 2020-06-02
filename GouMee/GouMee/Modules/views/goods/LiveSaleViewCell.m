//
//  LiveSaleViewCell.m
//  GouMee
//
//  Created by 白冰 on 2019/12/16.
//  Copyright © 2019 白冰. All rights reserved.
//

#import "LiveSaleViewCell.h"

@interface LiveSaleViewCell ()
{
    UILabel *markLab;
}

@end

@implementation LiveSaleViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self drawSubviews];
    }
    return self;
}

- (void)drawSubviews {
    markLab = [UILabel new];
    [self.contentView addSubview:markLab];
    [markLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(15);
    }];
    markLab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:scale(14)];
    markLab.textColor = COLOR_STR(0x333333);
    self.desLab = [UILabel new];
    [self.contentView addSubview:self.desLab];
    [self.desLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(markLab.mas_bottom).offset(10);
        make.left.mas_equalTo(markLab.mas_left).offset(0);
        make.centerX.mas_equalTo(0);
    }];
    self.desLab.textColor = COLOR_STR(0x666666);
    self.desLab.numberOfLines = 0;
    self.desLab.text = @"";
    self.desLab.font = [UIFont fontWithName:@"PingFangSC-Regular" size:scale(12)];
     UIView *line = [UIView new];
       [self.contentView addSubview:line];
       [line mas_makeConstraints:^(MASConstraintMaker *make) {
           make.bottom.mas_equalTo(self.desLab.mas_bottom).offset(20);
           make.left.mas_equalTo(self.contentView.mas_left).offset(0);
           make.right.mas_equalTo(self.contentView.mas_right).offset(0);
           make.height.mas_equalTo(scale(10));
       }];
       line.backgroundColor = viewColor;
}
-(void)setModel:(NSDictionary *)model
{
    CGFloat h = 0;
     
    CGFloat h1 = [self getLabelHeightWithText:@"直播卖点" width:SW-30 font:[UIFont fontWithName:@"PingFangSC-Medium" size:scale(14)]];
    CGFloat h2 = [self getLabelHeightWithText:@"秋季新款小熊上衣秋季新款小熊上衣秋季新款小熊上衣秋季新款小熊上衣新款小熊上衣新款小熊上衣新款小熊上衣" width:SW-30 font:[UIFont fontWithName:@"PingFangSC-Regular" size:scale(12)]];
    h = 10+h1 +10+h2+10+10;
    if (self.click) {
        markLab.text = @"直播卖点" ;
         self.desLab.text = @"秋季新款小熊上衣秋季新款小熊上衣秋季新款小熊上衣秋季新款小熊上衣新款小熊上衣新款小熊上衣新款小熊上衣" ;
        self.click(h);
    }
    
}
- (CGFloat)getLabelHeightWithText:(NSString *)text width:(CGFloat)width font: (UIFont *)font
{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
         return rect.size.height;
}

@end
