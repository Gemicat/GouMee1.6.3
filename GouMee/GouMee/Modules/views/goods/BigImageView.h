//
//  BigImageView.h
//  xiaolvlan
//
//  Created by 白冰 on 2019/4/26.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BigImageView : UIView
<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *modelArray;
@property (nonatomic, assign)NSInteger count;
@property (nonatomic, assign) CGFloat offer;
@end

NS_ASSUME_NONNULL_END
