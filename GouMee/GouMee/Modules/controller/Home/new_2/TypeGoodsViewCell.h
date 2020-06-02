//
//  TypeGoodsViewCell.h
//  KuRanApp
//
//  Created by 白冰 on 2020/2/10.
//  Copyright © 2020 白冰. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickBlock)(NSDictionary *model);
NS_ASSUME_NONNULL_BEGIN

@interface TypeGoodsViewCell : UICollectionViewCell
@property (nonatomic, strong)UIView *backView;
@property (nonatomic, strong)UIImageView *topView;
@property (nonatomic, strong)UILabel *titleLab;
@property (nonatomic, strong)UILabel *contextLab;
@property (nonatomic, strong)UIButton *moreBtn;
@property (nonatomic, strong) NSArray *sources;
@property (nonatomic, strong)UIImageView *rightIcon;
@property (nonatomic, copy) ClickBlock click;
-(void)addModel:(NSArray *)arr index:(NSString *)type;
@end

NS_ASSUME_NONNULL_END
