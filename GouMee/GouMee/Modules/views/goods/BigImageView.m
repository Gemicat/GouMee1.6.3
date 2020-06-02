//
//  BigImageView.m
//  xiaolvlan
//
//  Created by 白冰 on 2019/4/26.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "BigImageView.h"
#import "BigImgViewCell.h"
@implementation BigImageView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_STR(0x000000);
        [self drawSubviews];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        [self addGestureRecognizer:tap];
    }
    return self;
}
-(void)tap
{
    [self removeFromSuperview];
}
- (void)drawSubviews {
    [self addTopCollectionView:self];
}
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)oldBounds
{
    return YES;
}
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    _offer = scrollView.contentOffset.x;
    NSLog(@"end========%f",_offer);
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    if (fabs(scrollView.contentOffset.x -_offer) > 10) {
        if (scrollView.contentOffset.x > _offer) {
            int i = scrollView.contentOffset.x/([UIScreen mainScreen].bounds.size.width - 30)+1;
            if (i < self.modelArray.count) {
                NSIndexPath * index =  [NSIndexPath indexPathForRow:i inSection:0];
                [_collectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
            }

        }else{
            int i = scrollView.contentOffset.x/([UIScreen mainScreen].bounds.size.width - 30)+1;
            NSIndexPath * index =  [NSIndexPath indexPathForRow:i-1 inSection:0];
            [_collectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        }
    }
}

//用户拖拽是调用
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    if (fabs(scrollView.contentOffset.x -_offer) > 20) {
        if (scrollView.contentOffset.x > _offer) {
            int i = _collectionView.contentOffset.x/([UIScreen mainScreen].bounds.size.width - 30)+1;
            if (i < self.modelArray.count) {
                NSIndexPath * index =  [NSIndexPath indexPathForRow:i inSection:0];
                [_collectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
            }

        }else{
            int i = scrollView.contentOffset.x/([UIScreen mainScreen].bounds.size.width - 30)+1;
            NSIndexPath * index =  [NSIndexPath indexPathForRow:i-1 inSection:0];
            [_collectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        }
    }
}

- (void)addTopCollectionView:(UIView*)view {
    //1.初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置collectionView滚动方向
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    //2.初始化collectionView
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0, SW, SH) collectionViewLayout:layout];
    [view addSubview:_collectionView];
    _collectionView.backgroundColor = [UIColor blackColor];
    //3.注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    [_collectionView registerClass:[BigImgViewCell class] forCellWithReuseIdentifier:@"BigImgViewCell"];
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.decelerationRate = 10;//我改的是10
    //4.设置代理
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
}

#pragma mark collectionView代理方法
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.modelArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BigImgViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BigImgViewCell" forIndexPath:indexPath];
    if (_modelArray.count > 0) {

        cell.bigImg.contentMode = UIViewContentModeScaleAspectFit;
        [cell.bigImg sd_setImageWithURL:[NSURL URLWithString:_modelArray[indexPath.row]]];
        
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(SW, SH);
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
-(void)setModelArray:(NSMutableArray *)modelArray
{
    _modelArray = modelArray;
    [self.collectionView reloadData];
}
-(void)setCount:(NSInteger)count
{
        CGFloat offsetX = count * self.collectionView.frame.size.width;
        [self.collectionView setContentOffset:CGPointMake(offsetX, 0)];
}
@end
