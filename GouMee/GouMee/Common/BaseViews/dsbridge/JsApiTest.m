//
//  JsApiTest.m
//
//  Created by 杜文 on 16/12/30.
//  Copyright © 2016年 杜文. All rights reserved.
//

#import "JsApiTest.h"

@interface JsApiTest(){
  NSTimer * timer ;
  void(^hanlder)(id value,BOOL isComplete);
  int value;
}
@end

@implementation JsApiTest

- (NSString *) pageBack: (NSString *) msg
{
    return [msg stringByAppendingString:@"[ syn call]"];
}

- (void) pageBack:(NSString *) msg :(JSCallback) completionHandler
{
    NSNotification *notification = [NSNotification notificationWithName:@"webBack"object:nil];
  [[NSNotificationCenter defaultCenter]postNotification:notification];

}

- (NSString *) go: (NSString *) msg
{
    return [msg stringByAppendingString:@"[ syn call]"];
}

- (void) go:(NSString *) msg :(JSCallback) completionHandler
{
    NSNotification *notification = [NSNotification notificationWithName:@"webPush"object:msg];
    [[NSNotificationCenter defaultCenter]postNotification:notification];

}


- (NSString *)getToken:(NSDictionary *) args
{
    return  @"testNoArgSyn called [ syn call]";
}

- ( void )getToken:(NSDictionary *) args :(JSCallback)completionHandler
{
     NSDictionary *loginModel = [[NSUserDefaults standardUserDefaults]objectForKey:@"isLogin"];
     NSString *token = [NSString stringWithFormat:@"%@",loginModel[@"token"]];
    completionHandler(token,YES);
}

- ( void )callProgress:(NSDictionary *) args :(JSCallback)completionHandler
{
    value=10;
    hanlder=completionHandler;
    timer =  [NSTimer scheduledTimerWithTimeInterval:1.0
                                              target:self
                                            selector:@selector(onTimer:)
                                            userInfo:nil
                                             repeats:YES];
}

-(void)onTimer:t{
    if(value!=-1){
        hanlder([NSNumber numberWithInt:value--],NO);
    }else{
        hanlder(0,YES);
        [timer invalidate];
    }
}

/**
 * Note: This method is for Fly.js
 * In browser, Ajax requests are sent by browser, but Fly can
 * redirect requests to native, more about Fly see  https://github.com/wendux/fly
 * @param requestInfo passed by fly.js, more detail reference https://wendux.github.io/dist/#/doc/flyio-en/native
 */
-(void)onAjaxRequest:(NSDictionary *) requestInfo  :(JSCallback)completionHandler{
   
}

@end
