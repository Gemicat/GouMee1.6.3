//
//  Goumee_AddAreaViewController.m
//  GouMee
//
//  Created by 白冰 on 2020/3/9.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "Goumee_AddAreaViewController.h"

#import "Network.h"
#import "BTAreaPickViewController.h"
@interface Goumee_AddAreaViewController ()<UITextFieldDelegate,UITextViewDelegate,BTAreaPickViewControllerDelegate>
{

    NSString *context;
    NSString *proStr;
    NSString *cityStr;
    NSString *areaStr;
    NSString *proID;
    NSString *cityID;
    NSString *areaID;
    UITextField *phoneField;
    UITextField *userField;
    UITextView *contextView;
    BOOL switchBool;
    UIButton *chooseAddress;
    UIButton *clearBtn;
}

@end

@implementation Goumee_AddAreaViewController
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
    
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        return NO;
    }
    if (textView.text.length > 0) {
        clearBtn.hidden = NO;
    }
    else
    {
        clearBtn.hidden = YES;
    }
    
    return YES;
}
-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
   
         clearBtn.hidden = YES;

   
    return YES;
}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
     if (textView.text.length > 0) {
    clearBtn.hidden = NO;
     }
    return YES;
}
-(void)backs
{
    if (self.model) {
        
    if ([contextView.text isEqualToString:self.model[@"address"]] && [proStr isEqualToString:self.model[@"province"]] &&[cityStr isEqualToString:self.model[@"city"]] && [areaStr isEqualToString:self.model[@"area"]] && [phoneField.text isEqualToString:self.model[@"mobile"]] && [userField.text isEqualToString:self.model[@"realname"]] && switchBool == [self.model[@"is_default"] boolValue]) {
        
        [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
        
        
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"信息还没保存，确定返回吗?" preferredStyle:UIAlertControllerStyleAlert];
              
              UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"继续填写" style:UIAlertActionStyleDefault handler:nil];
              UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                  
                  [self.navigationController popViewControllerAnimated:YES];
              }];
              [alertController addAction:cancelAction];
               [alertController addAction:okAction];
            
             
              [self presentViewController:alertController animated:YES completion:nil];
        }
    }
    else
    {
        if (contextView.text.length > 0 || proStr.length >0  ||cityStr.length >0  || areaStr.length > 0  || phoneField.text.length >0 || userField.text.length > 0) {
       UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"信息还没保存，确定返回吗?" preferredStyle:UIAlertControllerStyleAlert];
        
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
                [self.navigationController popViewControllerAnimated:YES];
            }];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"继续填写" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           
        }];
              [alertController addAction:cancelAction];
         [alertController addAction:okAction];
      
       
        [self presentViewController:alertController animated:YES completion:nil];
        }
        else
        {

            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}
-(void)clearAction
{
    contextView.text = @"";
    context = @"";
    clearBtn.hidden = YES;
}
-(void)viewWillAppear:(BOOL)animated
{
    
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (isNotNull(self.model)) {
       self.title = @"编辑收货地址";
    }
    else
    {
    self.title = @"新增收货地址";
    }
     UIImage *img = [[UIImage imageNamed:@"nav"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
       UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithImage:img style:UIBarButtonItemStyleDone target:self action:@selector(backs)];
       self.navigationItem.leftBarButtonItem = leftItem;
    self.view.backgroundColor = viewColor;
    UIView *topView = nil;
    [self.view addSubview:topView];
   
    NSArray *arr = @[@"收货人",@"手机号码",@"所在地区",@"详细地址",@"设置默认地址"];
    for (int i = 0; i < 5; i++) {
        UIView *views = [UIView new];
        [self.view addSubview:views];
        views.backgroundColor = [UIColor whiteColor];
        [views mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
           
            if (topView) {
                if (i== 4) {
                   make.top.mas_equalTo(topView.mas_bottom).offset(scale(10));
                }
                else
                {
                make.top.mas_equalTo(topView.mas_bottom).offset(1);
                }
            }
            else
            {
                make.top.mas_equalTo(self.view.mas_top).offset(1);
            }
            if (i == 3) {
                make.height.mas_equalTo(scale(88));
            }
            else
            {
              make.height.mas_equalTo(scale(44));
            }
        }];
        topView= views;
        
        UILabel *label = [UILabel new];
        [views addSubview:label];
        label.font = font(13);
        
        label.textColor = COLOR_STR(0x666666);
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(scale(15));
            if (i == 3) {
                make.top.mas_equalTo(scale(15));
                
            }
            else
            {
                 make.centerY.mas_equalTo(0);
                make.top.mas_equalTo(0);
            }
            make.width.mas_equalTo(scale(80));
        }];
        label.text = arr[i];
        if (i < 2) {
            UITextField *field = [UITextField new];
            [views addSubview:field];
            field.delegate = self;
            field.returnKeyType = UIReturnKeyDone;
            field.clearButtonMode = UITextFieldViewModeWhileEditing;
            field.font = font1(@"PingFangSC-Medium", scale(13));
            field.textColor = COLOR_STR(0x333333);
            [field mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(label.mas_centerY).offset(0);
                make.left.mas_equalTo(label.mas_right).offset(0);
                make.right.mas_equalTo(scale(-15));
                make.top.mas_equalTo(0);
            }];
            if (i == 0) {
                userField = field;
                 [userField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
            }
            else
            {
                phoneField = field;
                phoneField.keyboardType = UIKeyboardTypeNumberPad;
                 [userField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
            }
        }
        else if (i == 2)
        {
            chooseAddress = [UIButton new];
            [views addSubview:chooseAddress];
            [chooseAddress mas_makeConstraints:^(MASConstraintMaker *make) {
              make.centerY.mas_equalTo(label.mas_centerY).offset(0);
                              make.left.mas_equalTo(label.mas_right).offset(0);
                              make.right.mas_equalTo(scale(-15));
                              make.top.mas_equalTo(0);
            }];
            chooseAddress.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            chooseAddress.titleLabel.font =font1(@"PingFangSC-Medium", scale(13));
            [chooseAddress setTitleColor:COLOR_STR(0x333333) forState:UIControlStateNormal];
            [chooseAddress addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
        }
        else if (i == 3)
        {
            UITextView *textView = [UITextView new];
            [views addSubview:textView];
            textView.delegate = self;
            textView.returnKeyType = UIReturnKeyDone;
            textView.font = font1(@"PingFangSC-Medium", scale(13));
            [textView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(label.mas_top).offset(-10);
                make.left.mas_equalTo(label.mas_right).offset(-4);
                make.right.mas_equalTo(scale(-30));
                make.bottom.mas_equalTo(scale(-10));
            }];
            contextView = textView;
            clearBtn = [UIButton new];
            [views addSubview:clearBtn];
            [clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(views.mas_centerY).offset(0);
                make.left.mas_equalTo(textView.mas_right).offset(0);
                make.right.mas_equalTo(views.mas_right).offset(0);
                make.top.mas_equalTo(textView.mas_top).offset(0);
            }];
            [clearBtn setImage:[UIImage imageNamed:@"clear_aa"] forState:UIControlStateNormal];
   
            clearBtn.hidden = YES;
            [clearBtn addTarget:self action:@selector(clearAction) forControlEvents:UIControlEventTouchUpInside];
            
        }
        else
        {
            UISwitch *pushSwitch = [UISwitch new];
            [views addSubview:pushSwitch];
            [pushSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-15);
                make.centerY.mas_equalTo(label.mas_centerY).offset(-3);
                make.width.mas_equalTo(scale(55));
                make.height.mas_equalTo(scale(22));
            }];
            [pushSwitch setOnTintColor: COLOR_STR(0xD72E51)];
            if (self.model) {
                [pushSwitch setOn:[self.model[@"is_default"] boolValue]];
              switchBool = [self.model[@"is_default"] boolValue];
            }
            else
            {
            switchBool = false;
            }
             [pushSwitch addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
            
        }
            }
    
    UIButton *certainBtn = [UIButton new];
       [self.view addSubview:certainBtn];
    certainBtn.layer.cornerRadius = 22;
       certainBtn.layer.masksToBounds = YES;
       [certainBtn setTitle:@"保存" forState:UIControlStateNormal];
       [certainBtn setTitleColor:COLOR_STR(0xffffff) forState:UIControlStateNormal];
       certainBtn.titleLabel.font = font(12);
       certainBtn.backgroundColor = COLOR_STR(0xD72E51);
    [certainBtn addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
    if (self.model) {
           contextView.text = self.model[@"address"];
           proStr = self.model[@"province"];
           proID =[NSString stringWithFormat:@"%@",self.model[@"province_id"]]  ;
           cityStr = self.model[@"city"];
           cityID = [NSString stringWithFormat:@"%@",self.model[@"city_id"]]  ;
           areaStr = self.model[@"area"];
          areaID = [NSString stringWithFormat:@"%@",self.model[@"district_id"]]  ;
           phoneField.text = self.model[@"mobile"];
           userField.text = self.model[@"realname"];
        [chooseAddress setTitle:[NSString stringWithFormat:@"%@%@%@",proStr,cityStr,areaStr] forState:UIControlStateNormal];
        
        
        UIButton *deleteBtn = [UIButton new];
              [self.view addSubview:deleteBtn];
           deleteBtn.layer.cornerRadius = 22;
              deleteBtn.layer.masksToBounds = YES;
              [deleteBtn setTitle:@"删除地址" forState:UIControlStateNormal];
              [deleteBtn setTitleColor:COLOR_STR(0xD72E51) forState:UIControlStateNormal];
              deleteBtn.titleLabel.font = font(12);
            
        deleteBtn.layer.borderColor = COLOR_STR(0xD72E51).CGColor;
        deleteBtn.layer.borderWidth = 1;
              [deleteBtn addTarget:self action:@selector(del) forControlEvents:UIControlEventTouchUpInside];
        
        [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(scale(15));
            make.centerX.mas_equalTo(0);
            make.height.mas_equalTo(44);
             if (@available(iOS 11.0, *)) {
                             make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-scale(10));
                             } else {
                             make.bottom.equalTo(self.view.mas_bottom).offset(-scale(10));
                             }
        }];
        
        [certainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                   make.left.mas_equalTo(scale(15));
                   make.centerX.mas_equalTo(0);
                   make.height.mas_equalTo(44);
                   make.bottom.mas_equalTo(deleteBtn.mas_top).offset(scale(-10));
               }];
           
       }
    else
    {
         [certainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
               make.left.mas_equalTo(scale(15));
               make.centerX.mas_equalTo(0);
               make.height.mas_equalTo(44);
                 if (@available(iOS 11.0, *)) {
                                          make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-scale(10));
                                          } else {
                                          make.bottom.equalTo(self.view.mas_bottom).offset(-scale(10));
                                          }
           }];
        
    }
    
}
- (void)textFieldDidChanged:(UITextField *)textField {
 // 判断是否存在高亮字符，如果有，则不进行字数统计和字符串截断
 UITextRange *selectedRange = textField.markedTextRange;
 UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
 if (position) {
 return;
 }
 // 判断是否超过最大字数限制，如果超过就截断
    if (textField == userField) {
        if (textField.text.length > 10) {
        textField.text = [textField.text substringToIndex:10];
        }
       
    }
    if (textField == phoneField) {
           if (textField.text.length > 11) {
           textField.text = [textField.text substringToIndex:11];
           }
          
       }
  
 // 剩余字数显示 UI 更新
}
-(void)del
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"确认删除改地址?" preferredStyle:UIAlertControllerStyleAlert];
       
       UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
       UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           
           [Network DEL:[NSString stringWithFormat:@"api/v1/addresses/%@/",self.model[@"id"]] paramenters:nil success:^(id data) {
               if ([data[@"success"] intValue] == 1) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"delAddress" object:self.model];
                   [self.navigationController popViewControllerAnimated:YES];
               }
           } error:^(id data) {
               
           }];
           
           
       }];
       
       [alertController addAction:cancelAction];
       [alertController addAction:okAction];
       [self presentViewController:alertController animated:YES completion:nil];
    
}
-(void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"delAddress" object:nil];
   
}
-(void)choose:(UIButton *)sender
{
   
    BTAreaPickViewController * vc = [[BTAreaPickViewController alloc]initWithDragDismissEnabal:YES];
       vc.delegate = self;
       [self presentViewController:vc animated:YES completion:nil];
}

- (void)areaPickerView:(BTAreaPickViewController *)areaPickerView doneAreaModel:(BTAreaPickViewModel *)model{
    NSLog(@"doneAreaModel %@",model.description);
    context = model.description;
    [chooseAddress setTitle:context forState:UIControlStateNormal];
    proStr = model.selectedProvince.name;
    proID = model.selectedProvince.code;
    cityID = model.selectedCitie.code;
    cityStr = model.selectedCitie.name;
    areaID = model.selectedArea.code;
    areaStr = model.selectedArea.name;
    
}
-(void)add:(UIButton *)sender
{
  
    if (userField.text.length == 0) {
       return [Network showMessage:@"请填写真实姓名" duration:2.0];
    }
    if (phoneField.text.length == 0) {
        return  [Network showMessage:@"请填写手机号" duration:2.0];
    }
    if (![Network checkTelephoneNumber:phoneField.text]) {
         return  [Network showMessage:@"请填写正确的手机号" duration:2.0];
       }
    if (contextView.text.length == 0) {
            return  [Network showMessage:@"请填写详细地址" duration:2.0];
          }
    
    if (proStr.length == 0  || cityStr.length == 0  ||areaStr.length == 0 ) {
        return [Network showMessage:@"请选择地址" duration:2.0];
    }
    
      sender.userInteractionEnabled = NO;
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    [parm setObject:[self userId] forKey:@"user"];
    [parm setObject:proStr forKey:@"province"];
    [parm setObject:cityStr forKey:@"city"];
    [parm setObject:areaStr forKey:@"area"];
    [parm setObject:contextView.text forKey:@"address"];
    [parm setObject:phoneField.text forKey:@"mobile"];
    [parm setObject:userField.text forKey:@"realname"];
    [parm setObject:cityID   forKey:@"city_id"];
    [parm setValue:areaID forKey:@"district_id"];
    [parm setObject:proID forKey:@"province_id"];
    [parm setObject:@(switchBool) forKey:@"is_default"];
    
    
    if (self.model) {
    [Network PATCH:[NSString stringWithFormat:@"api/v1/addresses/%@/",self.model[@"id"]] paramenters:parm success:^(id data) {
         sender.userInteractionEnabled = YES;
        if ([data[@"success"] intValue] == 1) {
            [Network showMessage:@"添加成功" duration:2.0];
              [[NSNotificationCenter defaultCenter] postNotificationName:@"delAddresss" object:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [Network showMessage:data[@"message"] duration:2.0];
        }
    } error:^(id data) {
             sender.userInteractionEnabled = YES;
    }];
    }
    else
    {
    [Network POST:@"api/v1/addresses/" paramenters:parm success:^(id data) {
        if ([data[@"success"] intValue] == 1) {
            [Network showMessage:@"添加成功" duration:2.0];
            if (self.click) {
                          self.click(data[@"data"]);
                      }
             [[NSNotificationCenter defaultCenter] postNotificationName:@"delAddresss" object:nil];
            [self.navigationController popViewControllerAnimated:YES];
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
}
- (void) switchChange:(UISwitch*)sw {
    if(sw.on == YES) {
        switchBool = true;
        NSLog(@"开关切换为开");
    } else if(sw.on == NO) {
        switchBool = false;
        NSLog(@"开关切换为关");
    }
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
