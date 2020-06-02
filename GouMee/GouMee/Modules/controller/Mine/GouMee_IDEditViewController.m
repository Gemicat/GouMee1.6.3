//
//  GouMee_IDEditViewController.m
//  GouMee
//
//  Created by 白冰 on 2020/1/11.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "GouMee_IDEditViewController.h"
#import "MineReusableView.h"
#import "IDEditViewCell.h"
#import "GouMee_CertificationStatusViewController.h"
@interface GouMee_IDEditViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITextFieldDelegate>
{
    UITextField *fields;
}

@property (nonatomic, strong)UICollectionView *mineCollectView;

@end

@implementation GouMee_IDEditViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"实名认证";
    self.view.backgroundColor = viewColor;

UICollectionViewFlowLayout *cellLay = [[UICollectionViewFlowLayout alloc]init];
    self.mineCollectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0, self.view.bounds.size.width, SH-[self navHeight]) collectionViewLayout:cellLay];
           [self.mineCollectView registerClass:[MineReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MineReusableView"];
   
     [self.mineCollectView registerClass:[IDEditViewCell class] forCellWithReuseIdentifier:@"IDEditViewCell"];
           self.mineCollectView.dataSource = self;
           self.mineCollectView.delegate = self;
           self.mineCollectView.backgroundColor = viewColor;
           self.mineCollectView.alwaysBounceVertical = YES;
           [self.view addSubview:self.mineCollectView];
    self.mineCollectView.scrollEnabled = NO;
    UIButton *nextBtn = [UIButton new];
       [self.view addSubview:nextBtn];
       [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerX.mas_equalTo(0);
           make.left.mas_equalTo(30);
           make.height.mas_equalTo(scale(44));
           make.bottom.mas_equalTo(-50);
       }];
       [nextBtn setTitle:@"提交审核" forState:UIControlStateNormal];
       [nextBtn setGradientBackgroundWithColors:@[COLOR_STR(0xD72E51),COLOR_STR(0xDC4761)] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
       nextBtn.layer.cornerRadius = scale(22);
       nextBtn.layer.masksToBounds = YES;
       [nextBtn addTarget:self action:@selector(certains) forControlEvents:UIControlEventTouchUpInside];
  }
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)certains
{
    if (fields.text.length == 0 || [fields.text isEqualToString:@"请输入开户行"]) {
        [Network showMessage:@"请输入开户行" duration:2.0];
        return;
    }
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    [parm setObject:_frontModel[@"name"] forKey:@"name"];
    [parm setObject:_frontModel[@"num"] forKey:@"identity"];
    [parm setObject:_frontModel[@"imgUrl"] forKey:@"photo"];
    [parm setObject:_afterModel[@"imgUrl"] forKey:@"back_photo"];
    if ([_frontModel[@"sex"] isEqual:@"男"]) {
        [parm setObject:@"1" forKey:@"gender"];
    }
    else
    {
       [parm setObject:@"2" forKey:@"gender"];
    }
    [parm setObject:_frontModel[@"address"] forKey:@"id_address"];
    [parm setObject:_frontModel[@"nationality"] forKey:@"nation"];
    [parm setObject:_afterModel[@"issue"] forKey:@"issue_org"];
    [parm setObject:_IDModel[@"imgUrl"] forKey:@"bank_photo"];
    [parm setObject:_IDModel[@"card_num"] forKey:@"bank_card_num"];
    [parm setObject:_IDModel[@"bank_name"] forKey:@"bank"];
    NSMutableString* startTime=[[NSMutableString alloc]initWithString:_afterModel[@"start_date"]];//存在堆区，可变字符串
      
          [startTime insertString:@"-"atIndex:6];//把一个字符串插入另一个字符串中的某一个位置
      [startTime insertString:@"-"atIndex:4];//把一个字符串插入另一个字符串中的某一个位置
    
    NSMutableString* endTime=[[NSMutableString alloc]initWithString:_afterModel[@"end_date"]];//存在堆区，可变字符串
         
             [endTime insertString:@"-"atIndex:6];//把一个字符串插入另一个字符串中的某一个位置
         [endTime insertString:@"-"atIndex:4];//把一个字符串插入另一个字符串中的某一个位置
       
    
    
    [parm setObject:startTime forKey:@"id_start_time"];
    [parm setObject:endTime forKey:@"id_end_time"];
    [parm setObject:fields.text forKey:@"opening_bank"];
    [Network POST:@"api/v1/identities/" paramenters:parm success:^(id data) {
        if ([data[@"success"] intValue] == 1) {
            GouMee_CertificationStatusViewController *vc = [[GouMee_CertificationStatusViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    } error:^(id data) {
        
    }];
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   
           IDEditViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"IDEditViewCell" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.field.enabled = NO;
        if (indexPath.row == 0) {
            cell.field.placeholder = _frontModel[@"name"];
            cell.frontLab.text = @"姓名";
        }
        if (indexPath.row == 1) {
                   cell.field.placeholder = _frontModel[@"num"];
             cell.frontLab.text = @"身份证号";
               }
        if (indexPath.row == 2) {
            
            NSMutableString* value = [[NSMutableString alloc] initWithString:_afterModel[@"start_date"]];
                   [value insertString:@"-" atIndex:6];
                   [value insertString:@"-" atIndex:4];
                   cell.field.placeholder = value;
              cell.frontLab.text = @"签发日期";
               }
        if (indexPath.row == 3) {

            NSMutableString* value = [[NSMutableString alloc] initWithString:_afterModel[@"end_date"]];
                              [value insertString:@"-" atIndex:6];
                              [value insertString:@"-" atIndex:4];
                              cell.field.placeholder = value;
              cell.frontLab.text = @"截止日期";
               }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
             cell.field.placeholder =[self getNewBankNumWitOldBankNum:_IDModel[@"card_num"]] ;
              cell.frontLab.text = @"银行卡号";
            cell.field.enabled = NO;
        }
        if (indexPath.row == 2) {
                    cell.field.placeholder =_IDModel[@"bank_name"] ;
              cell.frontLab.text = @"归属行";
            cell.field.enabled = NO;
               }
        if (indexPath.row == 0) {
           
              cell.frontLab.text = @"开户行";
            NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc] initWithString:@"请输入开户行" attributes:@{NSForegroundColorAttributeName : COLOR_STR(0x333333)}];
            cell.field.attributedPlaceholder = placeholderString;
           
            cell.field.enabled = YES;
            fields = cell.field;
        }
        
    }
     [cell.field addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    cell.field.delegate = self;
    return cell;
       

}
- (void)textFieldDidChanged:(UITextField *)textField {
 // 判断是否存在高亮字符，如果有，则不进行字数统计和字符串截断
 UITextRange *selectedRange = textField.markedTextRange;
 UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
 if (position) {
 return;
 }
 // 判断是否超过最大字数限制，如果超过就截断
    if (textField == fields) {
        if (textField.text.length > 100) {
        textField.text = [textField.text substringToIndex:100];
        }
    }
   

 // 剩余字数显示 UI 更新
}
- (NSString *)getNewBankNumWitOldBankNum:(NSString *)bankNum{
NSMutableString *mutableStr;
if (bankNum.length) {
mutableStr = [NSMutableString stringWithString:bankNum];
    NSString *text = mutableStr;
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *newString = @"";
    while (text.length > 0) {
        NSString *subString = [text substringToIndex:MIN(text.length, 4)];
        newString = [newString stringByAppendingString:subString];
        if (subString.length == 4) {
            newString = [newString stringByAppendingString:@" "];
        }
        text = [text substringFromIndex:MIN(text.length, 4)];
    }
    newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
return newString;
  }
   return bankNum;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 1) {
        return 3;
    }
    return 4;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
     return CGSizeMake(SW,scale(40));
   
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   

  
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
   
        return 0;
  
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
   
         return UIEdgeInsetsMake(0.f,0.f,0.f,0.f);
   
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
   
        return 0;
   
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
   
    return CGSizeMake(SW, 50);
}


//通过设置SupplementaryViewOfKind 来设置头部或者底部的view，其中 ReuseIdentifier 的值必须和 注册是填写的一致，本例都为 “reusableView”
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
   
     MineReusableView   *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MineReusableView" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        headerView.textLab.text = @"身份证";
    }
    if (indexPath.section == 1) {
        headerView.textLab.text = @"银行卡";
    }
    headerView.backgroundColor = COLOR_STR(0xf2f2f2);
   
            return headerView;
    

}







/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
