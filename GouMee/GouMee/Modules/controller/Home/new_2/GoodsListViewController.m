//
//  GoodsListViewController.m
//  KuRanApp
//
//  Created by 白冰 on 2020/2/10.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "GoodsListViewController.h"
#import "GoodsssViewCell.h"
@interface GoodsListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong)UICollectionView *collectView;

@end

@implementation GoodsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = COLOR_STR1(247, 247, 247, 1.0);

    UICollectionViewFlowLayout *cellLay = [[UICollectionViewFlowLayout alloc]init];
    self.collectView = [[UICollectionView alloc]initWithFrame:CGRectMake(15,0, self.view.bounds.size.width-30, self.view.bounds.size.height) collectionViewLayout:cellLay];
    self.collectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.collectView registerClass:[GoodsssViewCell class] forCellWithReuseIdentifier:@"GoodsssViewCell"];
    self.collectView.dataSource = self;
    self.collectView.delegate = self;
    self.collectView.backgroundColor = [UIColor clearColor];
    self.collectView.alwaysBounceVertical = YES;
    [self.view addSubview:self.collectView];

}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    GoodsssViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GoodsssViewCell" forIndexPath:indexPath];
    return cell;

}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{


    return 5;


}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    return CGSizeMake(SW,scale(150));

}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0.f,0.f,0.f,0.f);
}
////设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{

    return 0.f;

}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{

    return 0.f;

}


@end
