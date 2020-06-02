//
//  FeedBackViewController.m
//  GouMee
//
//  Created by 白冰 on 2020/4/18.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "FeedBackViewController.h"
#import "WDGTextView.h"
#import "ChoosePictureViewCell.h"
#import <sys/utsname.h>//要导入头文件
@interface FeedBackViewController ()<WDGTextViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate>
{

    UIButton *applyBtn;
    NSMutableArray *picArr;
}
@property (nonatomic, strong)NSIndexPath *index;
@property (nonatomic, strong)NSMutableArray *dates;
@property (nonatomic, strong)UICollectionView *ListCollectView;
@property (strong, nonatomic) UIImagePickerController *picker;
@property (nonatomic, strong) WDGTextView *textView;
@property (nonatomic, strong) NSMutableDictionary *picModel;
@end

@implementation FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"意见反馈";
    picArr = [NSMutableArray array];
    self.textView = [[WDGTextView alloc] initWithFrame:CGRectMake(scale(20), scale(12), SW-scale(40), scale(250)) backgroundColor:[UIColor whiteColor] textColor:COLOR_STR(0x333333) fontSize:14 placeHolder:@"请输入您要反馈的内容" placeHolderTextColor:COLOR_STR(0x999999) maxTextLength:200 hiddenMaxText:NO];
    self.textView.textViewDelegate = self;
    [self.view addSubview:self.textView];
    self.textView.delegate = self;
    self.dates = [NSMutableArray array];

    UIView *line = [UIView new];
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textView.mas_bottom).offset(10);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(scale(0.5));
    }];
    line.backgroundColor = COLOR_STR(0xEFEFEF);

    UICollectionViewFlowLayout *cellLay = [[UICollectionViewFlowLayout alloc]init];
    self.ListCollectView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:cellLay];
//    self.ListCollectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    [self.ListCollectView registerClass:[ChoosePictureViewCell class] forCellWithReuseIdentifier:@"ChoosePictureViewCell"];

    self.ListCollectView.dataSource = self;
    self.ListCollectView.delegate = self;
    self.ListCollectView.scrollEnabled = NO;
    self.ListCollectView.backgroundColor = [UIColor clearColor];
    self.ListCollectView.alwaysBounceVertical = YES;
    [self.view addSubview:self.ListCollectView];
    [self.ListCollectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(scale(15));
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(line.mas_bottom).offset(scale(10));
        make.height.mas_equalTo((SW-scale(50))/4+10);

    }];
      [self.dates addObject:@"add_pic"];
    [self.ListCollectView reloadData];



    applyBtn = [UIButton new];
    [self.view addSubview:applyBtn];
    [applyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(scale(24));
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(scale(40));
        if (@available(iOS 11.0, *)) {
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-scale(60));
        } else {
            make.bottom.equalTo(self.view.mas_bottom).offset(-scale(60));
        }
    }];
    [applyBtn setTitle:@"提交" forState:UIControlStateNormal];
    [applyBtn setTitleColor:COLOR_STR(0xffffff) forState:UIControlStateNormal];
    applyBtn.titleLabel.font = font(14);
    applyBtn.layer.cornerRadius = scale(20);
    applyBtn.layer.masksToBounds = YES;
    [self changeButton];
    [applyBtn addTarget:self action:@selector(applyfeed) forControlEvents:UIControlEventTouchUpInside];

}
-(void)textViewDidChange:(UITextView *)textView

{

    //    textview 改变字体的行间距

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];

    paragraphStyle.lineSpacing = 5;// 字体的行间距



    NSDictionary *attributes = @{

                                 NSFontAttributeName:[UIFont systemFontOfSize:15],

                                 NSParagraphStyleAttributeName:paragraphStyle

                                 };

    textView.attributedText = [[NSAttributedString alloc] initWithString:textView.text attributes:attributes];



}
-(void)applyfeed
{

    if ([self isBlankString:self.textView.text] == YES) {
        [Network showMessage:@"请输入反馈内容" duration:2.0];
        return;
    }

     NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];



        NSString* phoneModel = [[UIDevice currentDevice] model];
     NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    if (self.dates.count > 0) {
        [self.dates removeLastObject];

        NSString *allImageIDArrayJson = [self.dates componentsJoinedByString:@","];
        [parm setObject:allImageIDArrayJson forKey:@"pic_by_ios"];
        [parm setObject:allImageIDArrayJson forKey:@"pic"];

    }

    [parm setObject:self.textView.text forKey:@"content"];
    [parm setObject:@(1) forKey:@"device_type"];
    [parm setObject:@"1.6.3" forKey:@"version"];
    [parm setObject:@(3) forKey:@"client_type"];
    [parm setObject:phoneModel forKey:@"device_model"];
    [parm setObject:[self getCurrentDeviceModel] forKey:@"device_brand"];
    [parm setObject:phoneVersion forKey:@"device_os_version"];


    [Network POST:@"api/v1/advice/" paramenters:parm success:^(id data) {
        if ([data[@"success"] integerValue] == 1) {
              [Network showMessages:@"感谢您的反馈" duration:2.0 picture:@"feed_success"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
  [self.navigationController popViewControllerAnimated:YES];
            });


        }
        else
        {

        [Network showMessages:@"提交失败" duration:2.0 picture:@"feed_fail"];
        }
    } error:^(id data) {
 [Network showMessages:@"提交失败" duration:2.0 picture:@"feed_fail"];
    }];




}
- (NSString *)getCurrentDeviceModel{
    struct utsname systemInfo;
    uname(&systemInfo);

    NSString *deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];


    if ([deviceModel isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceModel isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceModel isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([deviceModel isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([deviceModel isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceModel isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceModel isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceModel isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceModel isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    // 日行两款手机型号均为日本独占，可能使用索尼FeliCa支付方案而不是苹果支付
    if ([deviceModel isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([deviceModel isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    if ([deviceModel isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    if ([deviceModel isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
    if ([deviceModel isEqualToString:@"iPhone10,1"])   return @"iPhone_8";
    if ([deviceModel isEqualToString:@"iPhone10,4"])   return @"iPhone_8";
    if ([deviceModel isEqualToString:@"iPhone10,2"])   return @"iPhone_8_Plus";
    if ([deviceModel isEqualToString:@"iPhone10,5"])   return @"iPhone_8_Plus";
    if ([deviceModel isEqualToString:@"iPhone10,3"])   return @"iPhone X";
    if ([deviceModel isEqualToString:@"iPhone10,6"])   return @"iPhone X";
    if ([deviceModel isEqualToString:@"iPhone11,8"])   return @"iPhone XR";
    if ([deviceModel isEqualToString:@"iPhone11,2"])   return @"iPhone XS";
    if ([deviceModel isEqualToString:@"iPhone11,6"])   return @"iPhone XS Max";
    if ([deviceModel isEqualToString:@"iPhone11,4"])   return @"iPhone XS Max";
    if ([deviceModel isEqualToString:@"iPhone12,1"])   return @"iPhone 11";
    if ([deviceModel isEqualToString:@"iPhone12,3"])   return @"iPhone 11 Pro";
    if ([deviceModel isEqualToString:@"iPhone12,5"])   return @"iPhone 11 Pro Max";
    if ([deviceModel isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceModel isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceModel isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceModel isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceModel isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    if ([deviceModel isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceModel isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([deviceModel isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([deviceModel isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceModel isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([deviceModel isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([deviceModel isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([deviceModel isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([deviceModel isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([deviceModel isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([deviceModel isEqualToString:@"iPad4,4"])      return @"iPad Mini 2 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad4,5"])      return @"iPad Mini 2 (Cellular)";
    if ([deviceModel isEqualToString:@"iPad4,6"])      return @"iPad Mini 2";
    if ([deviceModel isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (LTE)";
    if ([deviceModel isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7";
    if ([deviceModel isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7";
    if ([deviceModel isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9";
    if ([deviceModel isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9";

    if ([deviceModel isEqualToString:@"AppleTV2,1"])      return @"Apple TV 2";
    if ([deviceModel isEqualToString:@"AppleTV3,1"])      return @"Apple TV 3";
    if ([deviceModel isEqualToString:@"AppleTV3,2"])      return @"Apple TV 3";
    if ([deviceModel isEqualToString:@"AppleTV5,3"])      return @"Apple TV 4";

    if ([deviceModel isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceModel isEqualToString:@"x86_64"])       return @"Simulator";
    return deviceModel;
}
-(void)changeButton
{
    if (self.textView.text.length > 0) {
        applyBtn.backgroundColor = ThemeRedColor;
        applyBtn.userInteractionEnabled = YES;
    }
    else
    {
        applyBtn.userInteractionEnabled = NO;
     applyBtn.backgroundColor = COLOR_STR(0xEDA0AE);
    }

}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    ChoosePictureViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ChoosePictureViewCell" forIndexPath:indexPath];
    if (self.dates.count > 0) {

        NSString *url = self.dates[indexPath.row];
        if ([url containsString:@"http"]) {
            [cell.backImg sd_setImageWithURL:[NSURL URLWithString:url]];
        }
        else
        {
            cell.backImg.image = [UIImage imageNamed:url];
        }

        if (self.dates.count == 1) {
            cell.deleBtn.hidden = YES;
        }
        else
        {
            if (indexPath.row == self.dates.count-1) {
                cell.deleBtn.hidden = YES;
            }
            else
            {
                cell.deleBtn.hidden = NO;
            }

        }
    }
    cell.deleBtn.tag = indexPath.row+2000;
    [cell.deleBtn addTarget:self action:@selector(delePic:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
-(void)delePic:(UIButton *)sender
{


    if (_dates.count > 1) {
  [_dates removeObjectAtIndex:sender.tag-2000];
        [self.ListCollectView reloadData];
    }


}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.dates.count > 4) {
        return 4;
    }
    return self.dates.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    return CGSizeMake((SW-scale(40))/4,(SW-scale(50))/4+10);

}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.picker.delegate = self;

    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {

    }];

    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

        _index = indexPath;
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        else
        {


        }

        [self presentViewController:self.picker animated:YES completion:nil];

    }];

    UIAlertAction *picture = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

          _index = indexPath;
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            self.picker.mediaTypes = [[NSArray alloc] initWithObjects:(NSString*)kUTTypeImage,nil];

        }

        [self presentViewController:self.picker animated:YES completion:nil];
    }];
    [alertVc addAction:cancle];
    [alertVc addAction:camera];
    [alertVc addAction:picture];
    [self presentViewController:alertVc animated:YES completion:nil];
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{

    return UIEdgeInsetsMake(5.f,5.f,5.f,5.f);
    //    }

}
////设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{

    return 5.f;

}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{

    return 5.f;
}

-(UIImagePickerController *)picker
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
- (NSString *)getCurrentTimestamp {
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0]; // 获取当前时间0秒后的时间
    NSTimeInterval time = [date timeIntervalSince1970]*1000;// *1000 是精确到毫秒(13位),不乘就是精确到秒(10位)
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
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

        if ([self.dates[_index.row] isEqual:@"add_pic"]) {
            [self.dates insertObject:url atIndex:_index.row];
        }
        else
        {
            [self.dates replaceObjectAtIndex:_index.row withObject:url];
        }

        [self.ListCollectView reloadData];
        [self changeButton];
        //    获取图片后返回
        [self hiddenHub];


    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self hiddenHub];
    }];

}


//按取消按钮时候的功能
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //    返回
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark WDGTextViewDelegate
//当需要显示字数显示的时候，必须实现这个代理方法，虽然在这里可以什么都不用操作
- (void)refreshTextLimit {
    NSLog(@"Sheldon");
    [self changeButton];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


- (BOOL)isBlankString:(NSString *)string
 {
         if (string == nil)
             {
                     return YES;
                 }
         if (string == NULL)
             {
                     return YES;
                 }
         if ([string isKindOfClass:[NSNull class]])
             {
                     return YES;
                 }
         if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0)
            {
                     return YES;
                }
         return NO;
    }

@end
