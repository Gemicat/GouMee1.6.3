//
//  GouMee_ AuthenticationViewController.m
//  GouMee
//
//  Created by 白冰 on 2020/1/9.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "GouMee_AuthenticationViewController.h"
#import "MineReusableView.h"
#import "HelpViewCell.h"
#import "PhotoViewCell.h"
#import "GouMee_IDEditViewController.h"
#import <MBProgressHUD.h>
#import "PID_SheetView.h"
@interface GouMee_AuthenticationViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    
    UIImageView *imgIcon;
    NSIndexPath *index;
    NSMutableDictionary *IDCardModel;
    NSMutableDictionary *frontModel;
    NSMutableDictionary *afterModel;
    MBProgressHUD *_hub;
    UIButton *nextBtn;
    
}

@property (strong, nonatomic) UIImagePickerController *picker;
@property (nonatomic, strong)UICollectionView *mineCollectView;

@end

@implementation GouMee_AuthenticationViewController

-(void)pushView
{
           PID_SheetView *vc = [[PID_SheetView alloc]init];
           vc.context = @"图片内容识别失败，请重新上传。请确保卡面证件内容完整、清晰、无遮挡或反光";
           [self.view addSubview:vc];
}
- (UIImagePickerController *)picker
{
    if (!_picker) {
        _picker = [[UIImagePickerController alloc]init];
    }
    return _picker;
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
//    获取图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [Network GET:@"api/v1/oss-token/" paramenters:nil success:^(id data) {
        [self creatHub:@"正在识别图片"];
           [self postPhoto:data imgWithImage:image];

       } error:^(id data) {

       }];
//    获取图片后返回
    [picker dismissViewControllerAnimated:YES completion:nil];
}
//按取消按钮时候的功能
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
//    返回
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"实名认证";
    self.view.backgroundColor =viewColor;
    
    UILabel *tips = [UILabel new];
    [self.view addSubview:tips];
    [tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.centerX.mas_equalTo(0);
        
    }];
    tips.text = @"温馨提示：请确保使用本人身份证和银行卡，否则将无法提现";
    tips.textColor = COLOR_STR(0x999999);
    tips.font = font1(@"PingFangSC-Regular", scale(12));
    
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:tips.text];
                
    [str addAttribute:NSForegroundColorAttributeName value:COLOR_STR(0xED642C) range:NSMakeRange(tips.text.length-7, 7)];//颜色

     tips.attributedText = str;

UICollectionViewFlowLayout *cellLay = [[UICollectionViewFlowLayout alloc]init];
    self.mineCollectView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:cellLay];
           [self.mineCollectView registerClass:[MineReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MineReusableView"];

     [self.mineCollectView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"nextCell"];
     [self.mineCollectView registerClass:[PhotoViewCell class] forCellWithReuseIdentifier:@"PhotoViewCell"];
           self.mineCollectView.dataSource = self;
           self.mineCollectView.delegate = self;
           self.mineCollectView.backgroundColor = viewColor;
           self.mineCollectView.alwaysBounceVertical = YES;
           [self.view addSubview:self.mineCollectView];
    [self.mineCollectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tips.mas_bottom).offset(10);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-10);
    }];
    

       }
-(void)next
{
    if (!isNotNull(IDCardModel)) {
        [Network showMessage:@"上传银行卡" duration:2.0];
        return;
    }
    if (!isNotNull(frontModel)) {
        [Network showMessage:@"上传身份证正面" duration:2.0];
        return;
    }
    if (!isNotNull(afterModel)) {
        [Network showMessage:@"上传身份证反面" duration:2.0];
        return;
    }
    GouMee_IDEditViewController *vc = [[GouMee_IDEditViewController alloc]init];
    vc.IDModel = IDCardModel;
    vc.afterModel = afterModel;
    vc.frontModel = frontModel;
    [self.navigationController pushViewController:vc animated:YES];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 2) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"nextCell" forIndexPath:indexPath];
        nextBtn = [UIButton new];
        [cell addSubview:nextBtn];
        [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.left.mas_equalTo(30);
            make.height.mas_equalTo(scale(44));
            make.centerY.mas_equalTo(0);
        }];
        [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [nextBtn setGradientBackgroundWithColors:@[COLOR_STR(0xD72E51),COLOR_STR(0xD72E51)] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
        nextBtn.layer.cornerRadius = scale(22);
        nextBtn.layer.masksToBounds = YES;
        [nextBtn addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
        [self isButtonChange];
        return cell;
    }

           PhotoViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoViewCell" forIndexPath:indexPath];
    NSArray *arr = @[@"card_front",@"card_after"];

  
        cell.backView.tag = indexPath.row + 10000 +indexPath.section*10;
        
    if (indexPath.section == 0) {
         cell.backView.image = [UIImage imageNamed:arr[indexPath.row]];
    }
    else
    {
      cell.backView.image = [UIImage imageNamed:@"bank_bg"];
    }
    
   
    return cell;
       

}
-(void)isButtonChange
{
    if (isNotNull(IDCardModel) && isNotNull(frontModel) && isNotNull(afterModel)) {
       [nextBtn setTitleColor:COLOR_STR(0xffffff) forState:UIControlStateNormal];
      [nextBtn setGradientBackgroundWithColors:@[COLOR_STR(0xD72E51),COLOR_STR(0xD72E51)] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
    }
    else
    {

          [nextBtn setTitleColor:COLOR_STR(0x9B9B9B) forState:UIControlStateNormal];
     [nextBtn setGradientBackgroundWithColors:@[COLOR_STR(0xEBEBEB),COLOR_STR(0xEBEBEB)] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];

    }


}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    if (section == 1 || section == 2) {
        return 1;
    }
    return 2;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        return CGSizeMake(SW,100);
    }
     return CGSizeMake(SW,220);
   
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   
//    [self isBank];
    if (indexPath.section < 2) {

    index = indexPath;
    self.picker.delegate = self;
    self.picker.allowsEditing = YES;
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
           UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {
               
           }];
           
           UIAlertAction *camera = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
               
             
               if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
                    self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
               }
             
                   [self presentViewController:self.picker animated:YES completion:nil];
               
           }];
           
           UIAlertAction *picture = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
               
              
               if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                   self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                   self.picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:self.picker.sourceType];
                   
               }
            
               [self presentViewController:self.picker animated:YES completion:nil];
           }];
           [alertVc addAction:cancle];
           [alertVc addAction:camera];
           [alertVc addAction:picture];
           [self presentViewController:alertVc animated:YES completion:nil];
    
    
}
    
    
    
   
  
}
-(void)isIDCaid:(NSString *)face withImg:(NSString *)imgUrl
{
//    UIImage *originImage = [UIImage imageNamed:@"IDcard"];
//       NSData *imgdata = UIImageJPEGRepresentation(originImage, 1.0f);
//       NSString *encodedImageStr = [imgdata base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSString *appcode = @"3cbb3d5d15ff47b08f57c9d1c2d08f5f";
    NSString *host = @"https://dm-51.data.aliyun.com";
    NSString *path = @"/rest/160601/ocr/ocr_idcard.json";
    NSString *method = @"POST";
    NSString *querys = @"";
    NSString *url = [NSString stringWithFormat:@"%@%@%@",  host,  path , querys];
    NSString *bodys =[NSString stringWithFormat: @"{\"image\":\"%@\",\"configure\":\"{\\\"side\\\":\\\"%@\\\"}\"}",imgUrl,face]; ;

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: url]  cachePolicy:1  timeoutInterval:  5];
    request.HTTPMethod  =  method;
    [request addValue:  [NSString  stringWithFormat:@"APPCODE %@" ,  appcode]  forHTTPHeaderField:  @"Authorization"];
    //根据API的要求，定义相对应的Content-Type
    [request addValue: @"application/json; charset=UTF-8" forHTTPHeaderField: @"Content-Type"];
    NSData *data = [bodys dataUsingEncoding: NSUTF8StringEncoding];
    [request setHTTPBody: data];
    NSURLSession *requestSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [requestSession dataTaskWithRequest:request
        completionHandler:^(NSData * _Nullable body , NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:body options:NSJSONReadingMutableLeaves error:nil];
        [self hiddenHub];
    
         if (isNotNull(jsonDict)) {
             if (index.row == 0) {
                 frontModel = [NSMutableDictionary dictionaryWithDictionary:jsonDict];
                 [frontModel setObject:imgUrl forKey:@"imgUrl"];
             }
             else
             {
                afterModel = [NSMutableDictionary dictionaryWithDictionary:jsonDict];
                                 [afterModel setObject:imgUrl forKey:@"imgUrl"];
             }


             dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

                
                 dispatch_async(dispatch_get_main_queue(), ^{
                       imgIcon = [self.view viewWithTag:index.row + 10000+index.section*10];
                     [imgIcon sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
                      [self isButtonChange];
                     
                 });
             });


             
                }
                else
                {
                     dispatch_async(dispatch_get_main_queue(), ^{
                         [self pushView];
                                         
                                     });
                }
       
        }];

    [task resume];
    
}
-(void)isBank:(NSString *)imgUrl
{
    
    UIImage *originImage = [UIImage imageNamed:@"IDCard"];
    NSData *imgdata = UIImageJPEGRepresentation(originImage, 1.0f);
    NSString *encodedImageStr = [imgdata base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSString *appcode = @"3cbb3d5d15ff47b08f57c9d1c2d08f5f";
    NSString *host = @"https://yhk.market.alicloudapi.com";
    NSString *path = @"/rest/160601/ocr/ocr_bank_card.json";
    NSString *method = @"POST";
    NSString *querys = @"";
    NSString *url = [NSString stringWithFormat:@"%@%@%@",  host,  path , querys];
    NSString *bodys =[NSString stringWithFormat: @"{\"image\":\"%@\"}",imgUrl];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: url]  cachePolicy:1  timeoutInterval:  5];
    request.HTTPMethod  =  method;
    [request addValue:  [NSString  stringWithFormat:@"APPCODE %@" ,  appcode]  forHTTPHeaderField:  @"Authorization"];
    //根据API的要求，定义相对应的Content-Type
    [request addValue: @"application/json; charset=UTF-8" forHTTPHeaderField: @"Content-Type"];
    NSData *data = [bodys dataUsingEncoding: NSUTF8StringEncoding];
    [request setHTTPBody: data];
    NSURLSession *requestSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [requestSession dataTaskWithRequest:request
        completionHandler:^(NSData * _Nullable body , NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"Response object: %@" , response);
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:body options:NSJSONReadingMutableLeaves error:nil];
        [self hiddenHub];
               if (isNotNull(jsonDict)) {
                    IDCardModel = [NSMutableDictionary dictionaryWithDictionary:jsonDict];
                                   [IDCardModel setObject:imgUrl forKey:@"imgUrl"];
                            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

                                
                                dispatch_async(dispatch_get_main_queue(), ^{
                                     imgIcon = [self.view viewWithTag:index.row + 10000+index.section*10];
                                    [imgIcon sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
                                      [self isButtonChange];
                                });
                            });

                               }
                               else
                               {
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                            [self pushView];
                                                                            
                                                                        });
                               }
                      
                       }];

    [task resume];
   
}
-(void)postPhoto:(NSDictionary *)model imgWithImage:(UIImage *)img
{
    UIImage *image = img;
    NSString *ext = @"";
     if (UIImagePNGRepresentation(image)) {//返回为png图像。
         ext = @"png";
     }else {//返回为JPEG图像。
         ext = @"jpeg";
     }
     NSString *policy = model[@"data"][@"policy"];
            NSString *Signature = model[@"data"][@"signature"];
            NSString *OSSAccessKeyId = model[@"data"][@"accessid"];
            NSString *key = [NSString stringWithFormat:@"%@%@.jpg",model[@"data"][@"dir"],[self getRandomStringWithNum:30]];
     NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
     [parameters setValue:key forKey:@"key"];
     [parameters setValue:policy forKey:@"policy"];
     [parameters setValue:Signature forKey:@"Signature"];
    
     [parameters setValue:OSSAccessKeyId forKey:@"OSSAccessKeyId"];
//     [parameters setValue:[NSString stringWithFormat:@"temp.%@", ext] forKey:@"file"];
     
     AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
     [session.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
     session.responseSerializer = [AFHTTPResponseSerializer serializer];
     session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"application/xml", nil];
    NSURLSessionDataTask *uploadTask = [session POST:@"https://kuran-oss.oss-cn-hangzhou.aliyuncs.com" parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
         NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
         [formData appendPartWithFileData :imageData name:@"file" fileName:key mimeType:@"multipart/form-data"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
       
        NSString *url = [NSString stringWithFormat:@"https://kuran-oss.oss-cn-hangzhou.aliyuncs.com/%@",key];
        if (index.section == 0) {
                  if (index.row == 0) {
                       [self isIDCaid:@"face" withImg:url];
                  }
                  else
                  {
                    [self isIDCaid:@"back" withImg:url];
                  }
              }
              else
              {
                  [self isBank:url];
              }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self hiddenHub];
    }];
    
}
- (NSString *)getCurrentTimestamp {
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0]; // 获取当前时间0秒后的时间
    NSTimeInterval time = [date timeIntervalSince1970]*1000;// *1000 是精确到毫秒(13位),不乘就是精确到秒(10位)
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}
- (NSString *)getRandomStringWithNum:(NSInteger)num
{
    NSString *string = [[NSString alloc]init];
    for (int i = 0; i < num; i++) {
        int number = arc4random() % 36;
        if (number < 10) {
            int figure = arc4random() % 10;
            NSString *tempString = [NSString stringWithFormat:@"%d", figure];
            string = [string stringByAppendingString:tempString];
        }else {
            int figure = (arc4random() % 26) + 97;
            char character = figure;
            NSString *tempString = [NSString stringWithFormat:@"%c", character];
            string = [string stringByAppendingString:tempString];
        }
    }
    return [NSString stringWithFormat:@"%@%@",[self getCurrentTimestamp],string];
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
   
        return 10;
  
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
   
         return UIEdgeInsetsMake(10.f,10.f,10.f,10.f);
   
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
   
        return 10;
   
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section < 2) {
         return CGSizeMake(SW, 30);
    }
 return CGSizeMake(SW, 0);
}


//通过设置SupplementaryViewOfKind 来设置头部或者底部的view，其中 ReuseIdentifier 的值必须和 注册是填写的一致，本例都为 “reusableView”
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
   
     MineReusableView   *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MineReusableView" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        headerView.textLab.text = @"身份证照";
    }
    if (indexPath.section == 1) {
        headerView.textLab.text = @"银行卡照";
    }
    headerView.backgroundColor = viewColor;
   
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
