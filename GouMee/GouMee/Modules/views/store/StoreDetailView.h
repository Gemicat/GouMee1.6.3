//
//  StoreDetailView.h
//  GouMee
//
//  Created by 白冰 on 2019/12/16.
//  Copyright © 2019 白冰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StoreDetailView : UIView
@property (nonatomic, strong)UIView *backView;
@property (nonatomic, strong)UIButton *enterStore;
@property (nonatomic, strong)NSDictionary *StoreModel;
@property (nonatomic, assign)BOOL isCircle;
@end

NS_ASSUME_NONNULL_END
