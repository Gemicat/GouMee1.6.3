//
//  TypeGoodsViewCell.m
//  KuRanApp
//
//  Created by 白冰 on 2020/2/10.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "TypeGoodsViewCell.h"
#import "GoodsListViewCell.h"
@interface TypeGoodsViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong)UICollectionView *collectView;

@end

@implementation TypeGoodsViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        [self creatView];
    }
    return self;
}

-(void)creatView
{

    self.backgroundColor = [UIColor clearColor];

    self.backView = [UIView new];
    [self addSubview:self.backView];
    self.backView.backgroundColor = [UIColor whiteColor];
    self.backView.layer.cornerRadius = 6;
    self.backView.frame = CGRectMake(scale(15), scale(0), SW-scale(30), scale(210));

    [self viewShadowPathWithColor:COLOR_STR(0x909090) shadowOpacity:0.5 shadowRadius:6 shadowPathWidth:1];

    self.topView = [UIImageView new];
    [self.backView addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(scale(60));
    }];
    [self.topView layoutIfNeeded];
    [self changeLabelStyle:self.topView];

    self.titleLab = [UILabel new];
    [self.topView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topView.mas_top).offset(10);
        make.left.mas_equalTo(self.topView.mas_left).offset(scale(15));
        make.bottom.mas_equalTo(self.topView.mas_centerY).offset(0);
    }];
    self.titleLab.font = font(14);
    self.titleLab.textColor = COLOR_STR(0xffffff);
    self.titleLab.text = @"爆品库";

    self.contextLab = [UILabel new];
    [self.topView addSubview:self.contextLab];
    [self.contextLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topView.mas_centerY).offset(0);
        make.left.mas_equalTo(self.topView.mas_left).offset(scale(15));
        make.bottom.mas_equalTo(self.topView.mas_bottom).offset(0);
    }];
    self.contextLab.font = font(12);
    self.contextLab.textColor = COLOR_STR(0xffffff);
    self.contextLab.text = @"全网销量TOP，大众的选择，安全";

    self.rightIcon = [UIImageView new];
    self.rightIcon.contentMode = UIViewContentModeScaleAspectFill;
    [self.topView addSubview:self.rightIcon];
    [self.rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.mas_equalTo(0);
    }];


    self.moreBtn  = [UIButton new];
    [self.topView addSubview:self.moreBtn];
    self.moreBtn.layer.cornerRadius = 10;
    self.moreBtn.layer.masksToBounds = YES;
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.topView.mas_centerY).offset(0);
        make.right.mas_equalTo(self.topView.mas_right).offset(scale(-10));
        make.width.mas_equalTo(scale(50));
        make.height.mas_equalTo(20);
    }];
    self.moreBtn.userInteractionEnabled = YES;
    self.topView.userInteractionEnabled = YES;
    self.moreBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.moreBtn.layer.borderWidth = 1;
    [self.moreBtn setTitle:@"更多" forState:UIControlStateNormal];
    [self.moreBtn setTitleColor:COLOR_STR(0xffffff) forState:UIControlStateNormal];
    self.moreBtn.titleLabel.font = font(12);




}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    GoodsListViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GoodsListViewCell" forIndexPath:indexPath];
    if (isNotNull(_sources)) {
        cell.model = _sources[indexPath.row];
    }
    return cell;

}
-(void)setSources:(NSArray *)sources
{
    _sources = sources;
//    NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//
//    [self.collectView scrollToItemAtIndexPath:scrollIndexPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
    if (self.collectView) {
        [self.collectView removeFromSuperview];
    }
    UICollectionViewFlowLayout *cellLay = [[UICollectionViewFlowLayout alloc]init];
    self.collectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,scale(65), SW-30, scale(140)) collectionViewLayout:cellLay];
    self.collectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.collectView registerClass:[GoodsListViewCell class] forCellWithReuseIdentifier:@"GoodsListViewCell"];
    cellLay.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectView.dataSource = self;
    self.collectView.delegate = self;
    self.collectView.backgroundColor = [UIColor clearColor];
    self.collectView.alwaysBounceVertical = NO;
    self.collectView.showsVerticalScrollIndicator = NO;
    self.collectView.showsHorizontalScrollIndicator = NO;
    [self.backView addSubview:self.collectView];
   [self.collectView reloadData];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{


    return _sources.count;


}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    return CGSizeMake(scale(90),scale(140));

}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.click) {
        self.click(_sources[indexPath.row]);
    }
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10.f,10.f,10.f,10.f);
}
////设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{

    return 10.f;

}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{

    return 10.f;

}

-(void)changeLabelStyle:(UIImageView *)label{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:label.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(6, 6)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = label.bounds;
    maskLayer.path = maskPath.CGPath;
    label.layer.mask = maskLayer;
}
- (void)viewShadowPathWithColor:(UIColor *)shadowColor shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius  shadowPathWidth:(CGFloat)shadowPathWidth{

    self.backView.layer.masksToBounds = NO;//必须要等于NO否则会把阴影切割隐藏掉
    self.backView.layer.shadowColor = shadowColor.CGColor;// 阴影颜色
    self.backView.layer.shadowOpacity = shadowOpacity;// 阴影透明度，默认0
    self.backView.layer.shadowOffset = CGSizeZero;//shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
    self.backView.layer.shadowRadius = shadowRadius;//阴影半径，默认3
    CGRect shadowRect = CGRectZero;
    CGFloat originX,originY,sizeWith,sizeHeight;
    originX = 0;
    originY = 0;
    sizeWith = self.backView.bounds.size.width;
    sizeHeight = self.backView.bounds.size.height;

//    if (shadowPathType == LeShadowPathTop) {
//        shadowRect = CGRectMake(originX, originY-shadowPathWidth/2, sizeWith, shadowPathWidth);
//    }else if (shadowPathType == LeShadowPathBottom){
        shadowRect = CGRectMake(originY, sizeHeight-shadowPathWidth/2, sizeWith, shadowPathWidth);
//    }else if (shadowPathType == LeShadowPathLeft){
//        shadowRect = CGRectMake(originX-shadowPathWidth/2, originY, shadowPathWidth, sizeHeight);
//    }else if (shadowPathType == LeShadowPathRight){
//        shadowRect = CGRectMake(sizeWith-shadowPathWidth/2, originY, shadowPathWidth, sizeHeight);
//    }else if (shadowPathType == LeShadowPathCommon){
//        shadowRect = CGRectMake(originX-shadowPathWidth/2, 2, sizeWith+shadowPathWidth, sizeHeight+shadowPathWidth/2);
//    }else if (shadowPathType == LeShadowPathAround){
//        shadowRect = CGRectMake(originX-shadowPathWidth/2, originY-shadowPathWidth/2, sizeWith+shadowPathWidth, sizeHeight+shadowPathWidth);
//    }
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:shadowRect];
    self.backView.layer.shadowPath = bezierPath.CGPath;//阴影路径
}
@end
