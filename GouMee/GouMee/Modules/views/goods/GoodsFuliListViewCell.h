//
//  GoodsFuliListViewCell.h
//  GouMee
//
//  Created by 白冰 on 2020/4/23.
//  Copyright © 2020 白冰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GoodsFuliListViewCell : UICollectionViewCell
@property (nonatomic, strong)UILabel *titleLab;
@property (nonatomic, strong)UILabel *context;
@property (nonatomic, strong)UIImageView *leftIcon;
@property (nonatomic, strong)UILabel *contexts;

-(void)addModel:(NSDictionary *)model index:(NSInteger)index;
-(void)addModels:(NSDictionary *)model indexs:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
