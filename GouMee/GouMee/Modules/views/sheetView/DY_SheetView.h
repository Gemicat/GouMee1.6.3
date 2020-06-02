//
//  DY_SheetView.h
//  GouMee
//
//  Created by 白冰 on 2019/12/19.
//  Copyright © 2019 白冰. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CancelBlock)(void);
NS_ASSUME_NONNULL_BEGIN

@interface DY_SheetView : UIView
@property (nonatomic, copy)CancelBlock click;
@property (nonatomic, copy)CancelBlock pidclick;
@property (nonatomic, copy)CancelBlock taobaoclick;
@end

NS_ASSUME_NONNULL_END
