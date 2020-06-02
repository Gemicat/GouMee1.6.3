//
//  GouMee_LoginViewController.m
//  GouMee
//
//  Created by 白冰 on 2019/12/13.
//  Copyright © 2019 白冰. All rights reserved.
//

#import "GouMee_LoginViewController.h"
#import "UIView+Gradient.h"
#import "UIButton+Extensions.h"
#import "GouMee_RegisterViewController.h"
#import "GouMee_StoreViewController.h"
#import "GouMee_TabbarViewController.h"
#import "TaobaoViewController.h"
#import "GoumeeRegisterWebViewController.h"
#import <sys/utsname.h>//要导入头文件
@interface GouMee_LoginViewController ()<UITextFieldDelegate,UITextViewDelegate>
{
    UITextField *phoneField;
    UITextField *pwdField;
    UIButton *codeBtn;
    UIButton *loginBtn;
    
    
}

@end

@implementation GouMee_LoginViewController

-(void)isCodeChange
{
    if (![Network checkTelephoneNumber:phoneField.text]) {
        codeBtn.userInteractionEnabled = NO;
        codeBtn.layer.borderColor = COLOR_STR(0xBDBDBD).CGColor;
        [codeBtn setTitleColor:COLOR_STR(0xA7A7A7) forState:UIControlStateNormal];
    }
    else
    {
        codeBtn.userInteractionEnabled = YES;
        codeBtn.layer.borderColor = COLOR_STR(0xD72E51).CGColor;
        [codeBtn setTitleColor:COLOR_STR(0xD72E51) forState:UIControlStateNormal];

    }

}
-(void)isloginChange
{
    if ([Network checkTelephoneNumber:phoneField.text] && pwdField.text.length > 0) {



        loginBtn.userInteractionEnabled = YES;
        [loginBtn setGradientBackgroundWithColors:@[COLOR_STR(0xD72E51),COLOR_STR(0xDC4761)] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
        [loginBtn setTitleColor:COLOR_STR(0xffffff) forState:UIControlStateNormal];

    }
    else
    {
        loginBtn.userInteractionEnabled = NO;
        [loginBtn setGradientBackgroundWithColors:@[COLOR_STR(0xEBEBEB),COLOR_STR(0xEBEBEB)] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
        [loginBtn setTitleColor:COLOR_STR(0x9B9B9B) forState:UIControlStateNormal];


    }

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"";
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@""] style:UIBarButtonItemStyleDone target:self action:nil];
    UIButton *nextButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    //设置UIButton的图像

    [nextButton setTitle:@"注册" forState:UIControlStateNormal];
    [nextButton setTitleColor:COLOR_STR(0x333333) forState:UIControlStateNormal];
    nextButton.titleLabel.font = font(14);
    //给UIButton绑定一个方法，在这个方法中进行popViewControllerAnimated
    [nextButton addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    //然后通过系统给的自定义BarButtonItem的方法创建BarButtonItem
 UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:nextButton];
    //覆盖返回按键
    AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
     if(appDelegate.auditStatus == 0)
     {
 self.navigationItem.rightBarButtonItem = backItem;

     }


    [self.navigationController.navigationBar setTitleTextAttributes:@{
           NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size:scale(18)],
           NSForegroundColorAttributeName: COLOR_STR(0x333333)}];
    self.view.backgroundColor = COLOR_STR(0xffffff);


    UIImageView *tips = [UIImageView new];
    [self.view addSubview:tips];
    tips.image = [UIImage imageNamed:@"login_title"];
    [tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(scale(90));
        make.left.mas_equalTo(scale(38));
    }];


    if (appDelegate.auditStatus == 1) {

        UILabel *label = [UILabel new];
        [self.view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(tips.mas_bottom).offset(scale(15));
            make.left.mas_equalTo(tips.mas_left).offset(0);
        }];
        label.textColor = COLOR_STR(0x999999);
        label.font = font(13);
        label.text = @"未注册手机号将为您直接注册";
        
    }

    phoneField = [UITextField new];
    [self.view addSubview:phoneField];
    phoneField.delegate = self;
    phoneField.font = font1(@"PingFangSC-Medium", scale(14));
    phoneField.backgroundColor = COLOR_STR(0xffffff);
    phoneField.placeholder = @"请填写手机号";
    [phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tips.mas_bottom).offset(scale(57));
        make.left.mas_equalTo(tips.mas_left).offset(0);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];

    UIView *line1 = [UIView new];
    [phoneField addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(phoneField.mas_bottom).offset(0);
        make.left.mas_equalTo(phoneField.mas_left).offset(0);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    line1.backgroundColor = COLOR_STR(0xf8f8f8);
    phoneField.keyboardType = UIKeyboardTypeNumberPad;
    codeBtn = [UIButton new];
    [self.view addSubview:codeBtn];
    [codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(phoneField.mas_bottom).offset(20);
        make.right.mas_equalTo(phoneField.mas_right).offset(0);
        make.height.mas_equalTo(scale(26));
        make.width.mas_equalTo(scale(70));
    }];
    codeBtn.backgroundColor = COLOR_STR(0xffffff);
    codeBtn.layer.cornerRadius = 2.5;
    codeBtn.layer.masksToBounds = YES;
    codeBtn.layer.borderWidth = 1;
    codeBtn.layer.borderColor = COLOR_STR(0xBDBDBD).CGColor;
    [codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [codeBtn setTitleColor:COLOR_STR(0xBDBDBD) forState:UIControlStateNormal];
    codeBtn.titleLabel.font = font(11);
    
    pwdField = [UITextField new];
    [self.view addSubview:pwdField];
     pwdField.keyboardType = UIKeyboardTypeNumberPad;
    [pwdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(codeBtn.mas_top).offset(0);
        make.left.mas_equalTo(phoneField.mas_left).offset(0);
        make.right.mas_equalTo(codeBtn.mas_left).offset(-10);
        make.bottom.mas_equalTo(codeBtn.mas_bottom).offset(0);
        
    }];
    UIView *line2 = [UIView new];
    [self.view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(codeBtn.mas_bottom).offset(5);
        make.left.mas_equalTo(pwdField.mas_left).offset(0);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    line2.backgroundColor = COLOR_STR(0xf8f8f8);
    pwdField.font = font1(@"PingFangSC-Medium", scale(14));
    pwdField.delegate = self;
       pwdField.backgroundColor = COLOR_STR(0xffffff);
       pwdField.placeholder = @"请填写验证码";
    loginBtn = [UIButton new];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(pwdField.mas_bottom).offset(scale(45));
        make.left.mas_equalTo(phoneField.mas_left).offset(0);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(45);
    }];
    [loginBtn setTitleColor:COLOR_STR(0x9B9B9B) forState:UIControlStateNormal];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:scale(14)];
    [loginBtn setGradientBackgroundWithColors:@[COLOR_STR(0xEBEBEB),COLOR_STR(0xEBEBEB)] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
    [loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.layer.cornerRadius = 22.5;
    loginBtn.layer.masksToBounds = YES;

    [codeBtn addTarget:self action:@selector(codeAction) forControlEvents:UIControlEventTouchUpInside];

    UITextView *textView = [UITextView new];

    textView.text = @"登录即代表您同意我们的《用户协议》《隐私政策》《直播协议》";
    textView.font = font(10);
    textView.textColor = COLOR_STR(0x999999);
    [self.view addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-20);
        } else {
            make.bottom.equalTo(self.view.mas_bottom).offset(-20);
        }
        make.centerX.mas_equalTo(0);
    }];

    // 字体的行间距

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];

    paragraphStyle.lineSpacing= 1;
    NSDictionary*attributes = @{

                                     NSFontAttributeName:font(10),

                                     NSParagraphStyleAttributeName:paragraphStyle

                                     };

    //设置富文本点击

    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:textView.text attributes:attributes];

    [attributedString addAttribute:NSLinkAttributeName

                                 value:@"yonghuxieyi://"

                                 range:[[attributedString string]rangeOfString:@"《用户协议》"]];

     [attributedString addAttribute:NSLinkAttributeName

                                 value:@"jiesuanxieyi://"

                                 range:[[attributedString string]rangeOfString:@"《直播协议》"]];
    [attributedString addAttribute:NSLinkAttributeName

                                    value:@"yisizhengce://"

                                    range:[[attributedString string]rangeOfString:@"《隐私政策》"]];

    //设置字体
    //设置整体颜色

    [attributedString addAttribute:NSForegroundColorAttributeName value:COLOR_STR(0x999999) range:NSMakeRange(0,textView.text.length)];

    textView.attributedText= attributedString;

     //设置被点击字体颜色

     textView.linkTextAttributes = @{NSForegroundColorAttributeName:COLOR_STR(0x33A2F6)};

    textView.delegate=self;

    //必须禁止输入，否则点击将弹出输入键盘

    textView.editable=NO;

     textView.scrollEnabled=NO;
    NSString *phone = [[NSUserDefaults standardUserDefaults]objectForKey:@"login_phone"];
    if (isNotNull(phone)) {
        phoneField.text = phone;
    }
    [self isCodeChange];
    [phoneField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
   [pwdField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
}


- (void)textFieldDidChanged:(UITextField *)textField {
 // 判断是否存在高亮字符，如果有，则不进行字数统计和字符串截断
 UITextRange *selectedRange = textField.markedTextRange;
 UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
 if (position) {
 return;
 }
 // 判断是否超过最大字数限制，如果超过就截断
    if (textField == phoneField) {
        if (textField.text.length > 11) {
        textField.text = [textField.text substringToIndex:11];
        }
        [self isCodeChange];
    }
    else
    {
        if (textField.text.length > 6) {
        textField.text = [textField.text substringToIndex:6];
        }
    }
    [self isloginChange];
 // 剩余字数显示 UI 更新
}


- (BOOL)textView:(UITextView*)textView shouldInteractWithURL:(NSURL*)URL inRange:(NSRange)characterRange {
    TaobaoViewController *webView = [[TaobaoViewController alloc]init];
    
    if ([[URL scheme] isEqualToString:@"yonghuxieyi"]) {
    webView.url = @"https://kuran.goumee.com/h5/agreements/user-agreement.html";
        NSLog(@"富文本点击 用户协议");
    [self.navigationController pushViewController:webView animated:YES];
    }else if ([[URL scheme] isEqualToString:@"yisizhengce"]) {

      webView.url = @"https://kuran.goumee.com/h5/agreements/privacy-policy.html";
       
    [self.navigationController pushViewController:webView animated:YES];

    }
    else if ([[URL scheme] isEqualToString:@"jiesuanxieyi"]) {

          webView.url = @"https://kuran.goumee.com/h5/agreements/live-policy.html";
          
        [self.navigationController pushViewController:webView animated:YES];

        }

    return YES;

}

-(void)login:(UIButton *)sender
{
    [phoneField resignFirstResponder];
    [pwdField resignFirstResponder];
    if (phoneField.text.length == 0) {
           [Network showMessage:@"请输入手机号" duration:2.0];
           return;
       }
       if (![Network checkTelephoneNumber:phoneField.text]) {
           [Network showMessage:@"手机号格式不正确，请重新输入" duration:2.0];
           return;
       }
    if (pwdField.text.length == 0) {
         [Network showMessage:@"请输入验证码" duration:2.0];
               return;
    }
     AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    sender.userInteractionEnabled = NO;
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    [parm setValue:phoneField.text forKey:@"mobile"];
    [parm setObject:pwdField.text forKey:@"code"];
    [parm setObject:@"2" forKey:@"platform"];
    if (isNotNull(appDelegate.deviceToken)) {
         [parm setObject:appDelegate.deviceToken forKey:@"device_token"];
    }
   
    [parm setObject:[self getCurrentDeviceModel] forKey:@"description"];

    NSString *ur;
    if (appDelegate.auditStatus == 0) {
        ur = @"api/v1/login/";
    }
    else
    {
        ur = @"api/consumer/v1/user-register/";
    }


    [Network POST:ur paramenters:parm success:^(id data) {
        if ([data[@"success"] intValue] == 1) {
            [[NSUserDefaults standardUserDefaults] setObject:phoneField.text forKey:@"login_phone"];
            [[NSUserDefaults standardUserDefaults]setObject:data[@"data"] forKey:@"isLogin"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            [self getUserInfo:data[@"data"][@"id"]];
        }
        else
        {
            [Network showMessage:data[@"message"] duration:2.0];
        }
        sender.userInteractionEnabled = YES;
    } error:^(id data) {
        sender.userInteractionEnabled = YES;
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
-(void)getUserInfo:(NSString *)userId
{
    [Network GET:[NSString stringWithFormat:@"api/v1/users/%@/",userId] paramenters:nil success:^(id data) {
        if ([data[@"success"] intValue] == 1) {
        if (isNotNull(data[@"data"][@"pid"])) {
            [[NSUserDefaults standardUserDefaults]setObject:data[@"data"][@"pid"] forKey:@"user_pid"];
            }
            [[NSUserDefaults standardUserDefaults]synchronize];
            AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];

            app.loginStatus = 0;
            if (self.pushType == 1) {
 [self.navigationController popViewControllerAnimated:YES];
            }
            else
            {
 [UIApplication sharedApplication].delegate.window.rootViewController = [[GouMee_TabbarViewController alloc]init];

            }
            }
        else
        {
                        
         [Network showMessage:data[@"message"] duration:2.0];
                           
        }
                       
    } error:^(id data) {
                   
                        }];
    
}
-(void)codeAction
{
    if (phoneField.text.length == 0) {
        [Network showMessage:@"请输入手机号" duration:2.0];
        return;
    }
    if (![Network checkTelephoneNumber:phoneField.text]) {
        [Network showMessage:@"手机号格式不正确，请重新输入" duration:2.0];
        return;
    }
    [Network POST:@"api/v1/codes/" paramenters:@{@"mobile":phoneField.text,@"action":@(0)} success:^(id data) {
        self->codeBtn.enabled = NO;
        codeBtn.layer.borderColor = COLOR_STR(0xBDBDBD).CGColor;
        [codeBtn setTitleColor:COLOR_STR(0xA7A7A7) forState:UIControlStateNormal];
        if ([data[@"success"] intValue] == 1) {
            [Network showMessage:@"验证码发送成功" duration:1.0];
            [self->codeBtn countdownWithSecond:61 completion:^{
                [self->codeBtn setTitle:@"重新获取" forState:(UIControlStateNormal)];
                self->codeBtn.enabled = YES;
                codeBtn.layer.borderColor = COLOR_STR(0xD72E51).CGColor;
                [codeBtn setTitleColor:COLOR_STR(0xD72E51) forState:UIControlStateNormal];
               }];
        }
        else
        {
            self->codeBtn.enabled = YES;
              [Network showMessage:data[@"message"] duration:2.0];
            codeBtn.layer.borderColor = COLOR_STR(0xD72E51).CGColor;
            [codeBtn setTitleColor:COLOR_STR(0xD72E51) forState:UIControlStateNormal];
        }
      
    } error:^(id data) {
        self->codeBtn.enabled = YES;
        codeBtn.layer.borderColor = COLOR_STR(0xD72E51).CGColor;
        [codeBtn setTitleColor:COLOR_STR(0xD72E51) forState:UIControlStateNormal];
    }];
    
    
    
   
}
-(void)registerAction
{
//    GouMee_RegisterViewController *vc = [[GouMee_RegisterViewController alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
    GoumeeRegisterWebViewController *vc = [[GoumeeRegisterWebViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
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
