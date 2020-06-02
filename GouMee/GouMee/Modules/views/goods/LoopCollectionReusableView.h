//
//  LoopCollectionReusableView.h
//  xiaolvlan
//
//  Created by mac on 2019/3/7.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^LoopCollectionReusableViewBlock)(void);

@interface LoopCollectionReusableView : UICollectionReusableView

@property (nonatomic, copy) LoopCollectionReusableViewBlock buyEvent;
@property (nonatomic, copy) LoopCollectionReusableViewBlock updateEvent;
@property (nonatomic, copy) LoopCollectionReusableViewBlock butieEvent;
@property (nonatomic, copy) NSArray *imageUrls;
@property (nonatomic, copy) NSDictionary *goodsDTO;
@property (nonatomic, copy) NSString* shareText;
@property (nonatomic, copy) NSString *mobileShortUrl;
@property (nonatomic, assign)NSInteger isNull;
@end

NS_ASSUME_NONNULL_END
