//
//  Goumee_AddressViewCell.h
//  GouMee
//
//  Created by 白冰 on 2020/3/9.
//  Copyright © 2020 白冰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Goumee_AddressViewCell : UITableViewCell
@property (nonatomic, strong)UIImageView *leftIcon;
@property (nonatomic, strong)UILabel *name;
@property (nonatomic, strong)UILabel *address;
@property (nonatomic, strong)UIButton *editBtn;
@property (nonatomic, strong)UILabel *type;
@property (nonatomic, assign)NSInteger chooseBool;
-(void)addModel:(NSDictionary *)model;

@end

NS_ASSUME_NONNULL_END
