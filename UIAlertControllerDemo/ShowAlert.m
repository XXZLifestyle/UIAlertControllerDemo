//
//  ShowAlert.m
//  UIAlertControllerDemo
//
//  Created by Zachary on 15/10/9.
//  Copyright © 2015年 www.xxzd.com. All rights reserved.
//

#import "ShowAlert.h"

@implementation ShowAlert

#pragma mark - alert view
+ (void)defaultWithAlertView:(UIViewController *)vc title:(NSString *)title message:(NSString *)msg {
    /*创建时,确定样式*/
    
    //1 - 创建弹窗管理器以及确定样式
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    //2 - 创建按钮
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //点击按钮响应的事件
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:nil];
    
    //3 - 将按钮加入管理器中;一般取消按钮在左边,否则异常
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    //4 - 显示对话框视图控制器
    [vc presentViewController:alertController animated:YES completion:nil];
}

@end
