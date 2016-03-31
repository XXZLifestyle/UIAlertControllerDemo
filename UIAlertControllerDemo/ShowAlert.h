//
//  ShowAlert.h
//  UIAlertControllerDemo
//
//  Created by Zachary on 15/10/9.
//  Copyright © 2015年 www.xxzd.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface ShowAlert : NSObject

+ (void)defaultWithAlertView:(UIViewController *)vc title:(NSString *)title message:(NSString *)msg;

@end
