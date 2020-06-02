//
//  ToolsViewCell.h
//  GouMee
//
//  Created by 白冰 on 2019/12/16.
//  Copyright © 2019 白冰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^ToolsBlock)(NSInteger tag);
@interface ToolsViewCell : UICollectionViewCell
@property (nonatomic, strong)UIImageView *toolIcon;
@property (nonatomic, strong)UILabel *toolName;
@property (nonnull, copy) ToolsBlock clickBlock;
@property (nonatomic, strong)UIImageView *FreeIcon;
@end

NS_ASSUME_NONNULL_END
