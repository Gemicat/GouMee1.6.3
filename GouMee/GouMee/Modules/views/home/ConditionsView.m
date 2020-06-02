//
//  ConditionsView.m
//  GouMee
//
//  Created by 白冰 on 2019/12/12.
//  Copyright © 2019 白冰. All rights reserved.
//

#import "ConditionsView.h"
#import "FilterInputCell.h"
#import "FilterChooseCell.h"
#import "UIView+Gradient.h"
#import "AppDelegate.h"
#import "UIButton+HPImageTitleSpacing.h"
@interface ConditionsView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITextFieldDelegate>
{
    
    UIView *backView;
    NSIndexPath *oneIndex;
    NSIndexPath *twoIndex;
    NSString *highPrice;
    NSString *lowPrice;
    NSString *ratioString;
    NSString *setBool;
}
@property (nonatomic, strong)UICollectionView *screencollectView;

@end

@implementation ConditionsView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createInterface];
    }
    return self;
}

-(void)createInterface
{
    lowPrice = @"";
    highPrice = @"";
    ratioString = @"";
    setBool = @"0";
    UIButton *lastBtn = nil;
    [self addSubview:lastBtn];
    AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];

    
    NSArray *titleArr;
    if (appDelegate.auditStatus == 0) {
       titleArr = @[@"默认",@"销量",@"价格",@"佣金",@"筛选"];
    }
    else
    {
         titleArr = @[@"默认",@"销量",@"价格",@"",@"筛选"];
    }
    
    for (int i = 0; i < 5; i++) {
        UIButton *button = [UIButton new];
        [self addSubview:button];
        button.titleLabel.font= font(13);
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        if (i == 0) {
             [button setTitleColor:ThemeRedColor forState:UIControlStateNormal];
        }
        else
        {
         [button setTitleColor:COLOR_STR(0x808080) forState:UIControlStateNormal];
        }
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.width.mas_equalTo(SW/5.0);
            if (lastBtn) {
                make.left.mas_equalTo(lastBtn.mas_right).offset(0);
            }
            else
            {
                make.left.mas_equalTo(0);
            }
        }];
        if (i== 2) {
 [button setImage:[UIImage imageNamed:@"yyyy_n"] forState:UIControlStateNormal];
        }
        if (i== 4) {
            [button setImage:[UIImage imageNamed:@"shai_n"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"shai_n"] forState:UIControlStateSelected];
        }
        lastBtn = button;
        [button layoutButtonWithEdgeInsetsStyle:HPButtonEdgeInsetsStyleRight imageTitleSpace:2];
        button.tag = i+10000;
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];

    }
}
-(void)click:(UIButton *)sender
{
   

     
    if (sender.tag == 10004) {
        [self appearSheet];
    }
    else
    {
        for (int i = 0; i < 4; i++) {
            UIButton *button = [self viewWithTag:10000+i];
            [button setTitleColor:COLOR_STR(0x808080) forState:UIControlStateNormal];
            if (i == 2) {
                 [button setImage:[UIImage imageNamed:@"yyyy_n"] forState:UIControlStateNormal];
            }

            if (sender.tag != 10002) {

                button.selected = NO;
            }
            else
            {

            }

        }
        AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];

        NSString *orderStr = @"";
        if (sender.tag == 10001) {
            if (appDelegate.freeStatus == 100) {
           orderStr = @"-good__volume";
            }
            else
            {
            orderStr = @"-volume";
            }
        }
        if (sender.tag == 10000) {
                 orderStr = @"";
            }
        if (sender.tag == 10002) {
            if (sender.selected) {
                sender.selected = NO;
                 [sender setImage:[UIImage imageNamed:@"up_bg"] forState:UIControlStateNormal];
                if (appDelegate.freeStatus == 100) {
                    orderStr = @"-good__kurangoods__show_price";
                }
                else
                {
                    orderStr = @"-final_price";
                }

            }
            else
            {
                 [sender setImage:[UIImage imageNamed:@"down_bg"] forState:UIControlStateNormal];
                sender.selected = YES;
                if (appDelegate.freeStatus == 100) {
                    orderStr = @"good__kurangoods__show_price";
                }
                else
                {
                    orderStr = @"final_price";
                }

            }
            [sender layoutButtonWithEdgeInsetsStyle:HPButtonEdgeInsetsStyleRight imageTitleSpace:2];
                  }
        if (sender.tag == 10003) {

                if (appDelegate.freeStatus == 100) {
                    orderStr = @"-good__kurangoods__show_commission";
                }
                else
                {
                    orderStr = @"-commission";
                }


                  }
        if (self.click) {
            self.click(orderStr);
        }
     
    }
    if (sender.tag != 10004) {
         [sender setTitleColor:ThemeRedColor forState:UIControlStateNormal];
    }

}
-(void)appearSheet
{
    _sheetView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SW, SH)];
    [[UIApplication sharedApplication].delegate.window addSubview:_sheetView];
    _sheetView.backgroundColor = COLOR_STR1(0, 0, 0, 0.3);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelX)];
    [_sheetView addGestureRecognizer:tap];

    backView = [[UIView alloc]initWithFrame:CGRectMake(SW, 0, SW/5*3, SH)];
    [[UIApplication sharedApplication].delegate.window addSubview:backView];
    [UIView animateWithDuration:0.3 animations:^{
        self->backView.frame = CGRectMake(SW/5.0*2, 0, SW/5*3, SH);
    }];
   
    backView.backgroundColor = [UIColor whiteColor];
    [backView addSubview:self.screencollectView];
    [self.screencollectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(backView);
        make.top.mas_equalTo([UIApplication sharedApplication].statusBarFrame.size.height);
    }];

    UIView *bottomView = [UIView new];
    [backView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
                   make.bottom.equalTo(backView.mas_safeAreaLayoutGuideBottom).offset(-20);
               } else {
                   make.bottom.equalTo(backView.mas_bottom).offset(-20);
               }
        make.left.mas_equalTo(backView.mas_left).offset(52);
        make.right.mas_equalTo(backView.mas_right).offset(-15);
        make.height.mas_equalTo(scale(35));
    }];
    bottomView.layer.cornerRadius = scale(35)/2.0;
    bottomView.layer.masksToBounds = YES;
    
    UIButton *sureBtn = [UIButton new];
    [bottomView addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.mas_equalTo(0);
        make.left.mas_equalTo(bottomView.mas_centerX).offset(0);
        
    }];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:COLOR_STR(0xffffff) forState:UIControlStateNormal];
    sureBtn.titleLabel.font = font(12);
    [sureBtn setGradientBackgroundWithColors:@[COLOR_STR(0xD72E51),COLOR_STR(0xD72E51)] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
    [sureBtn addTarget:self action:@selector(zzzz) forControlEvents:UIControlEventTouchUpInside];
    UIButton *cancelBtn = [UIButton new];
    [bottomView addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.mas_equalTo(0);
        make.right.mas_equalTo(bottomView.mas_centerX).offset(0);
        
    }];
    [cancelBtn setTitle:@"重置" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:COLOR_STR(0x999999) forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = font(12);
    cancelBtn.backgroundColor = COLOR_STR(0xf2f2f2);
    [cancelBtn addTarget:self action:@selector(xxxx) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)zzzz
{
 FilterInputCell *cell1 = (FilterInputCell *)[self.screencollectView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
      FilterInputCell *cell2 = (FilterInputCell *)[self.screencollectView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];

    if (self.clicks) {
        
         UIButton *button = [self viewWithTag:10004];
        if (cell1.highPrice.text.length == 0 && cell1.lowPrice.text.length == 0 && cell2.profitsNum.text.length == 0) {
           [button setTitleColor:COLOR_STR(0x808080) forState:UIControlStateNormal];
        }
        else
        {
            
            [button setTitleColor:ThemeRedColor forState:UIControlStateNormal];
        }
        
        NSString *str = [NSString stringWithFormat:@"%ld",[cell2.profitsNum.text integerValue]*100];

        if (isNotNull(cell1.highPrice.text)) {
            if ([cell1.lowPrice.text integerValue] > [cell1.highPrice.text integerValue]) {
                highPrice = cell1.lowPrice.text;
                lowPrice = cell1.highPrice.text;
                cell1.lowPrice.text = lowPrice;
                cell1.highPrice.text = highPrice;

            }
            else
            {
                highPrice = cell1.highPrice.text;
                lowPrice = cell1.lowPrice.text;
            }
        }
        else
        {
            highPrice = cell1.highPrice.text;
            lowPrice = cell1.lowPrice.text;
        }

        ratioString = cell2.profitsNum.text;
        self.clicks(lowPrice, highPrice, str);
        [self oneIndexChange:YES];
        [self twoIndexChange:YES];
        [self cancelX];
    }
}
-(void)xxxx
{
    FilterInputCell *cell1 = (FilterInputCell *)[self.screencollectView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
      FilterInputCell *cell2 = (FilterInputCell *)[self.screencollectView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    cell1.lowPrice.text = @"";
    cell1.highPrice.text = @"";
    cell2.profitsNum.text = @"";
    [self oneIndexChange:YES];
 [self twoIndexChange:YES];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        FilterInputCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FilterInputCell" forIndexPath:indexPath];
        if (indexPath.section == 0) {
            cell.lowPrice.hidden = NO;
            cell.highPrice.hidden = NO;
            cell.line.hidden = NO;
            cell.profitsNum.hidden = YES;
            cell.markLab.hidden = YES;
            cell.lowPrice.delegate = self;
            cell.highPrice.delegate = self;
            cell.lowPrice.tag = 8000;
            cell.highPrice.tag = 8001;
            cell.lowPrice.keyboardType = UIKeyboardTypeNumberPad;
            cell.highPrice.keyboardType = UIKeyboardTypeNumberPad;
            if (isNotNull(lowPrice)) {
                cell.lowPrice.text = lowPrice;
            }
            if (isNotNull(highPrice)) {
                cell.highPrice.text = highPrice;
            }
        }
        else
        {
            cell.lowPrice.hidden = YES;
            cell.highPrice.hidden = YES;
            cell.line.hidden = YES;
            cell.profitsNum.hidden = NO;
            cell.profitsNum.textAlignment = NSTextAlignmentCenter;
            cell.markLab.hidden = NO;
            cell.profitsNum.delegate = self;
            cell.profitsNum.tag = 8002;
            [cell.profitsNum addTarget:self action:@selector(changedTextField:) forControlEvents:UIControlEventEditingChanged];



            cell.profitsNum.keyboardType = UIKeyboardTypeNumberPad;
            if (isNotNull(ratioString)) {
                cell.profitsNum.text = ratioString;
            }
        }
        
        return cell;
    }
    FilterChooseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FilterChooseCell" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        NSArray *titleArr = @[@"10元以下",@"10元 - 50元",@"50元 - 100元",@"100元以上"];
         cell.nameLab.text = titleArr[indexPath.row-1];
    }
    else
    {
        NSArray *titleArr = @[@"20%",@"30%",@"40%",@"50%"];
        cell.nameLab.text = titleArr[indexPath.row-1];
    }
   
    return cell;

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark -给每个cell中的textfield添加事件，只要值改变就调用此函数
-(void)changedTextField:(id)textField
{

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.tag == 8002) {
        NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
        NSString *regexStr = @"^\\d{0,3}$";

        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self matches %@", regexStr];
        if([predicate evaluateWithObject:text] && [text integerValue] <= 100){
            return YES;
        }
        return NO;
    }
    return YES;


}


-(void)textFieldDidEndEditing:(UITextField *)textField
{
  
    if (textField.tag == 8002) {
        NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:1];
        FilterInputCell *cell1 = (FilterInputCell *)[self.screencollectView cellForItemAtIndexPath:index];
        if ([cell1.profitsNum.text integerValue] > 0 && [cell1.profitsNum.text integerValue] < 100) {
            [self twoIndexChange:YES];
            if ([cell1.profitsNum.text isEqualToString:@"20"]) {
                twoIndex = [NSIndexPath indexPathForRow:1 inSection:1];
                               [self twoIndexChange:NO];
            }
            else if ([cell1.profitsNum.text isEqualToString:@"30"]) {
                twoIndex = [NSIndexPath indexPathForRow:2 inSection:1];
                               [self twoIndexChange:NO];
            }
            else if ([cell1.profitsNum.text isEqualToString:@"40"]) {
                           twoIndex = [NSIndexPath indexPathForRow:3 inSection:1];
                                          [self twoIndexChange:NO];
                       }
            else if ([cell1.profitsNum.text isEqualToString:@"50"]) {
                           twoIndex = [NSIndexPath indexPathForRow:4 inSection:1];
                                          [self twoIndexChange:NO];
                       }
            else
            {
                [self twoIndexChange:YES];
            }
        }
    }
    else
    {
        NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
        FilterInputCell *cell1 = (FilterInputCell *)[self.screencollectView cellForItemAtIndexPath:index];
        if (cell1.lowPrice.text.length > 0 && cell1.highPrice.text.length == 0) {
            if ([cell1.lowPrice.text isEqualToString:@"100"]) {
                oneIndex = [NSIndexPath indexPathForRow:4 inSection:0];
                [self oneIndexChange:NO];
            }
            else
            {
                [self oneIndexChange:YES];
            }
        }
        if (cell1.highPrice.text.length > 0 && cell1.lowPrice.text.length == 0) {
                   if ([cell1.lowPrice.text isEqualToString:@"10"]) {
                       oneIndex = [NSIndexPath indexPathForRow:1 inSection:0];
                       [self oneIndexChange:NO];
                   }
                   else
                   {
                       [self oneIndexChange:YES];
                   }
               }
        if (cell1.highPrice.text.length > 0 && cell1.lowPrice.text.length > 0) {
            if ([cell1.lowPrice.text isEqualToString:@"10"] &&[cell1.highPrice.text isEqualToString:@"50"]) {
                              oneIndex = [NSIndexPath indexPathForRow:2 inSection:0];
                              [self oneIndexChange:NO];
                          }
        
          else if ([cell1.lowPrice.text isEqualToString:@"50"] &&[cell1.highPrice.text isEqualToString:@"100"]) {
                oneIndex = [NSIndexPath indexPathForRow:3 inSection:0];
                [self oneIndexChange:NO];
            }
            else
            {
                [self oneIndexChange:YES];
            }
            }
    }
        
}
-(void)oneIndexChange:(BOOL)isBool
{
    if (isBool) {
        FilterChooseCell *cell1 = (FilterChooseCell *)[self.screencollectView cellForItemAtIndexPath:oneIndex];
                                     cell1.nameLab.backgroundColor = COLOR_STR(0xe6e6e6);
                                 cell1.nameLab.textColor = COLOR_STR(0x333333);
                                 cell1.markLab.hidden = YES;
        if (isNotNull(lowPrice) || isNotNull(highPrice)) {

        }
        else
        {
 oneIndex = nil;
        }

    }
    else
    {
        FilterChooseCell *cell = (FilterChooseCell *)[self.screencollectView cellForItemAtIndexPath:oneIndex];
        cell.nameLab.backgroundColor = COLOR_STR1(215, 46, 81, 0.2);
        cell.nameLab.textColor = ThemeRedColor;
        cell.markLab.hidden = NO;
    }
   
}
-(void)twoIndexChange:(BOOL)isBool
{
    if (isBool) {
        FilterChooseCell *cell1 = (FilterChooseCell *)[self.screencollectView cellForItemAtIndexPath:twoIndex];
                                     cell1.nameLab.backgroundColor = COLOR_STR(0xe6e6e6);
                                 cell1.nameLab.textColor = COLOR_STR(0x333333);
                                 cell1.markLab.hidden = YES;
        if (isNotNull(ratioString) ) {

        }
        else
        {
            twoIndex = nil;
        }
    }
    else
    {
        FilterChooseCell *cell = (FilterChooseCell *)[self.screencollectView cellForItemAtIndexPath:twoIndex];
        cell.nameLab.backgroundColor = COLOR_STR1(215, 46, 81, 0.2);
        cell.nameLab.textColor = ThemeRedColor;
        cell.markLab.hidden = NO;
    }
   
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{


    return 5;

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return CGSizeMake(SW/5*3-20,scale(40));
    }
    return CGSizeMake(SW/10.0*3-15.5,scale(40));

}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row > 0) {
            if (!oneIndex) {
                oneIndex = indexPath;
            }
            else
            {
            
                 FilterChooseCell *cell1 = (FilterChooseCell *)[self.screencollectView cellForItemAtIndexPath:oneIndex];
                    cell1.nameLab.backgroundColor = COLOR_STR(0xe6e6e6);
                cell1.nameLab.textColor = COLOR_STR(0x333333);
                cell1.markLab.hidden = YES;
                oneIndex = indexPath;
            }
            FilterChooseCell *cell = (FilterChooseCell *)[self.screencollectView cellForItemAtIndexPath:indexPath];
            cell.nameLab.backgroundColor = COLOR_STR1(215, 46, 81, 0.2);
            cell.nameLab.textColor = ThemeRedColor;
            cell.markLab.hidden = NO;
            
        NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
        FilterInputCell *cells = (FilterInputCell *)[self.screencollectView cellForItemAtIndexPath:index];
            if (indexPath.row == 1) {
                cells.highPrice.text = @"10";
                cells.lowPrice.text = @"";
            }
            if (indexPath.row == 2) {
                cells.highPrice.text = @"50";
                cells.lowPrice.text = @"10";
            }
            if (indexPath.row == 3) {
                cells.highPrice.text = @"100";
                cells.lowPrice.text = @"50";
            }
            if (indexPath.row == 4) {
                cells.highPrice.text = @"";
                cells.lowPrice.text = @"100";
            }
        }
    }
    if (indexPath.section == 1) {
           if (indexPath.row > 0) {
               if (!twoIndex) {
                   twoIndex = indexPath;
               }
               else
               {
               
                    FilterChooseCell *cell1 = (FilterChooseCell *)[self.screencollectView cellForItemAtIndexPath:twoIndex];
                     
                       cell1.nameLab.backgroundColor = COLOR_STR(0xe6e6e6);
                   cell1.nameLab.textColor = COLOR_STR(0x333333);
                   cell1.markLab.hidden = YES;
                   twoIndex = indexPath;
               }
               FilterChooseCell *cell = (FilterChooseCell *)[self.screencollectView cellForItemAtIndexPath:indexPath];
               cell.nameLab.backgroundColor = COLOR_STR1(215, 46, 81, 0.2);
               cell.markLab.hidden = NO;
               cell.nameLab.textColor = ThemeRedColor;
               NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:1];
                      FilterInputCell *cells = (FilterInputCell *)[self.screencollectView cellForItemAtIndexPath:index];
                          if (indexPath.row == 1) {
                              cells.profitsNum.text = @"20";
                          }
                          if (indexPath.row == 2) {
                              cells.profitsNum.text = @"30";
                          }
                          if (indexPath.row == 3) {
                              cells.profitsNum.text = @"40";
                          }
                          if (indexPath.row == 4) {
                             cells.profitsNum.text = @"50";
                          }
           }
       }
  
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(0.f,10.f,0.f,10.f);
}
////设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{

    return 0.f;

}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{

    return 10.f;

}
-(UICollectionView *)screencollectView
{
    if (!_screencollectView) {
        UICollectionViewFlowLayout *cellLay = [[UICollectionViewFlowLayout alloc]init];
        self.screencollectView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:cellLay];
        self.screencollectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.screencollectView registerClass:[FilterInputCell class] forCellWithReuseIdentifier:@"FilterInputCell"];
        [self.screencollectView registerClass:[FilterChooseCell class] forCellWithReuseIdentifier:@"FilterChooseCell"];
        [self.screencollectView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FilterReusableView"];
        self.screencollectView.dataSource = self;
        self.screencollectView.delegate = self;
        self.screencollectView.backgroundColor = [UIColor whiteColor];
        self.screencollectView.alwaysBounceVertical = YES;
    }
    return _screencollectView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {

    return CGSizeMake(SW, 40);
}


//通过设置SupplementaryViewOfKind 来设置头部或者底部的view，其中 ReuseIdentifier 的值必须和 注册是填写的一致，本例都为 “reusableView”
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
   
     UICollectionReusableView   *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FilterReusableView" forIndexPath:indexPath];
    headerView.backgroundColor = [UIColor clearColor];
    UILabel *label = [UILabel new];
    [headerView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(headerView.mas_bottom).offset(0);
        make.left.mas_equalTo(15);
    }];
    label.textColor = COLOR_STR(0x999999);
    label.font = font1(@"PingFangSC-Regular", scale(12));
    if (indexPath.section == 0) {
        label.text = @"价格";
    }
    else
    {
         AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
        if (appDelegate.auditStatus==0) {
            label.text = @"佣金";
        }
        else
        {
            label.text = @"优惠";
        }
        
    }
            return headerView;
    

}
-(void)cancelX
{
    [_sheetView removeFromSuperview];
    [backView removeFromSuperview];
    FilterInputCell *cell1 = (FilterInputCell *)[self.screencollectView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    FilterInputCell *cell2 = (FilterInputCell *)[self.screencollectView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    if (isNotNull(lowPrice)) {
        cell1.lowPrice.text = lowPrice;
    }
    if (isNotNull(highPrice)) {
        cell1.highPrice.text = highPrice;
    }
    if (isNotNull(ratioString)) {
        cell2.profitsNum.text = ratioString;
    }
    [self oneIndexChange:NO];
     [self twoIndexChange:NO];

}

@end
