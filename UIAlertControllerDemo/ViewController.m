//
//  ViewController.m
//  UIAlertControllerDemo
//
//  Created by Zachary on 15/10/9.
//  Copyright © 2015年 www.xxzd.com. All rights reserved.
//

#import "ViewController.h"
#import "ShowAlert.h"

@interface ViewController ()

- (IBAction)alertViewAction:(id)sender;
- (IBAction)actionSheetAction:(id)sender;

@property (nonatomic, strong) NSMutableArray *arr;
@property (nonatomic, strong) NSMutableArray *arrData;

NS_ASSUME_NONNULL_BEGIN
/*
    1 - 在Audited Regions里面声明默认都是nonnull, 如果可以为NULL or nil, 加nullable
    2 - 添加在方法中的方式:
        1>在类型前面添加,不用加两个下划线
        2>在*后面添加,需要加上两个下划线
       - 添加在属性中的方式: 见下文案例
    3 - 特殊情况
        - typedef定义的类型不会继承nullability特性—它们会轻松地根据上下文选择nullable或non-nullable，所以，就算是在审查区域(Audited Regions)内，typedef定义的类型也不会被当作nonnull。
 
        - 像id *这样更复杂的指针类型必须被显式地注解，比如，你要指定一个nonnull的指针为一个nullable的对象引用，那么需要使用__nullable id * __nonnull。
 
        - 像NSError **这些特殊的、通过方法参数返回错误对象的类型，将总是被当作是一个nullable的指针指向一个nullable的指针：__nullable NSError ** __nullable。
 */
- (NSString *)dataWithName:(NSString *)name;
- (NSString * __nullable)dataWithAge:(NSString * __nullable)age;
- (nullable NSString *)dataWithSex:(nullable NSString *)sex;

@property (nonatomic, strong, nonnull) NSArray * nameItems;//一般用这种方式,格式上比较整洁
@property (nonatomic, strong) NSArray * __nonnull ageItems;

NS_ASSUME_NONNULL_END


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _arr = nil;
    
    [self dataWithName:@"name"];
}

- (NSString *)dataWithName:(NSString *)name {
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)alertViewAction:(id)sender {
    NSLog(@"alertViewAction");
    
    [self alertView];
}

- (IBAction)actionSheetAction:(id)sender {
    NSLog(@"actionSheetAction");
    [ShowAlert defaultWithAlertView:self title:nil message:@"actionSheet"];
}

#pragma mark - alert view
- (void)alertView {
    /*创建时,确定样式*/
    
    //1 - 创建弹窗管理器以及确定样式
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"alertView" message:@"咋了?" preferredStyle:UIAlertControllerStyleAlert];
    
    //1.1 - 添加textField
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"登录";
        
        //1.2 - 检查输入的内容
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alertTextFieldDidChange:) name:UITextFieldTextDidChangeNotification object:textField];
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"密码";
        textField.secureTextEntry = YES;
    }];
    
    //2 - 创建按钮
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //点击按钮响应的事件
        NSLog(@"click 'ok' button");
        
        //2.1 接受输入的内容
        UITextField *login = alertController.textFields.firstObject;
        UITextField *password = alertController.textFields.lastObject;
        
        NSLog(@"login.text = %@, password.text = %@", login.text, password.text);
        
        //2.2 - 移除检查的通知
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    }];
    //2.2.1 -
    okAction.enabled = NO;
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:nil];
    
    //3 - 将按钮加入管理器中;一般取消按钮在左边,否则异常
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    //4 - 显示对话框视图控制器
    [self presentViewController:alertController animated:YES completion:^{
        //5s后取消弹窗
        [self performSelector:@selector(removeAlertController:) withObject:alertController afterDelay:5.0f];
    }];
    
}

#pragma mark - action
//取消弹窗
- (void)removeAlertController:(UIAlertController *)alertController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//检查输入的内容
- (void)alertTextFieldDidChange:(NSNotification *)notification{
    UIAlertController *alertController = (UIAlertController *)self.presentedViewController;
    
    UITextField *login = notification.object;
    NSLog(@"login.text = %@", login.text);
    
    if (alertController) {
        //判断符合条件后,打开控件事件
        UITextField *login = alertController.textFields.firstObject;
        UIAlertAction *okAction = alertController.actions.lastObject;
        okAction.enabled = login.text.length > 5;
    }
}

#pragma mark - action sheet



#pragma mark - dealloc
- (void)dealloc {
    
}

@end
