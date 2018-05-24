//
//  MMZCViewController.m
//  MMR
//
//  Created by qianfeng on 15/6/30.
//  Copyright © 2015年 MaskMan. All rights reserved.
//

#import "MMZCViewController.h"
#import "forgetPassWardViewController.h"
#import "AppDelegate.h"
#import "MMZCHMViewController.h"
#import "SVProgressHUD.h"
#import "Header.h"
#import "WJMMViewController.h"
#import "UITextField+Shake.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "QMDTabBarVC.h"
#import "LoginModel.h"

#define Btn_H 50.0f
@interface MMZCViewController ()
{
    UIImageView *View;
    UIView *bgView;
    UITextField *pwd;
    UITextField *user;
    UIButton *QQBtn;
    UIButton *weixinBtn;
    UIButton *xinlangBtn;
    UILabel * _label;
    UILabel *_labelB;
    UIButton * _landBtn;
}
@property(copy,nonatomic) NSString * accountNumber;
@property(copy,nonatomic) NSString * mmmm;
@property(copy,nonatomic) NSString * _user;

@property (nonatomic ,strong)UITextField *phoneTextFiled;
@property (nonatomic ,strong)UITextField *passwordTextFiled;
@end

@implementation MMZCViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //self.view.backgroundColor=[UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1];
    //设置NavigationBar背景颜色
    View=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    //View.backgroundColor=[UIColor redColor];

    [self.view addSubview:View];
    
    

    //为了显示背景图片自定义navgationbar上面的三个按钮
    UIButton *but =[[UIButton alloc]initWithFrame:CGRectMake(5, 27+100, 35, 35)];
    //    [but setImage:[UIImage imageNamed:@"goback_back_orange_on"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(clickaddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
    
    UIButton *zhuce =[[UIButton alloc]initWithFrame:CGRectMake(10,self.view.frame.size.height - 100 , self.view.frame.size.width-20, Btn_H)];
    [zhuce setTitle:@"没有账号? 请注册" forState:UIControlStateNormal];
    [zhuce setTitleColor:DEF_RGB_COLOR(30 , 144, 255) forState:UIControlStateNormal];
    
    zhuce.layer.cornerRadius = 5.0f;
    zhuce.backgroundColor = [UIColor whiteColor];
    [zhuce.layer setBorderColor:DEF_RGB_COLOR(30 , 144, 255).CGColor];
    [zhuce.layer setBorderWidth:1];
    [zhuce.layer setMasksToBounds:YES];
    
    zhuce.font=[UIFont systemFontOfSize:17];
    [zhuce addTarget:self action:@selector(zhuce) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:zhuce];
    
    UIImageView *headImage =  [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 3 , 70 , self.view.frame.size.width / 3, 50)];
    [headImage setImage:[UIImage imageNamed:@"qqmd"]];
    [self.view addSubview:headImage];

    
    [self createButtons];
    //    [self createImageViews];
    [self createTextFields];
    
//        [self createLabel];
}



-(void)clickaddBtn:(UIButton *)button
{
    //      [kAPPDelegate appDelegateInitTabbar];
    self.view.backgroundColor=[UIColor whiteColor];
    exit(0);
}

-(void)createTextFields
{
    CGRect frame=[UIScreen mainScreen].bounds;
    bgView=[[UIView alloc]initWithFrame:CGRectMake(10, 75 +100, frame.size.width-20, 100)];
    bgView.layer.cornerRadius=3.0;
    bgView.alpha=0.7;
    bgView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:bgView];
    
    user=[self createTextFielfFrame:CGRectMake(75, 10, 271, 30) font:[UIFont systemFontOfSize:17] placeholder:@"手机号/抢买单会员名"];
    //user.text=@"13419693608";
//    user.delegate = self;
    user.keyboardType=UIKeyboardTypeNumberPad;
    user.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    pwd=[self createTextFielfFrame:CGRectMake(75, 60, 271, 30) font:[UIFont systemFontOfSize:17]  placeholder:@"请输入登录密码" ];
    pwd.clearButtonMode = UITextFieldViewModeWhileEditing;
    //pwd.text=@"123456";
    //密文样式
    pwd.secureTextEntry=YES;
    //pwd.keyboardType=UIKeyboardTypeNumberPad;
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 40, 25)];
    _label.text = @"账号";
    _label.textAlignment = NSTextAlignmentLeft;
   _labelB = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, 40, 25)];
    _labelB.textAlignment = NSTextAlignmentLeft;
    _labelB.text = @"密码";
    
    //
    //    UIImageView *userImageView=[self createImageViewFrame:CGRectMake(20, 10, 25, 25) imageName:@"ic_landing_nickname" color:nil];
    //    UIImageView *pwdImageView=[self createImageViewFrame:CGRectMake(20, 60, 25, 25) imageName:@"mm_normal" color:nil];
    UIImageView *line1=[self createImageViewFrame:CGRectMake(0, 50, bgView.frame.size.width + 20, 1) imageName:nil color:[UIColor colorWithRed:180/255.0f green:180/255.0f blue:180/255.0f alpha:.3]];
    UIImageView *line2 = [self createImageViewFrame:CGRectMake(0, 95, bgView.frame.size.width +20, 1) imageName:nil color:DEF_RGBA_COLOR(180, 180, 180, 0.3) ];
    [bgView addSubview:user];
    [bgView addSubview:pwd];
    
    [bgView addSubview:_labelB];
    [bgView addSubview:_label];
    
    //    [bgView addSubview:userImageView];
    //    [bgView addSubview:pwdImageView];
    [bgView addSubview:line1];
    [bgView addSubview: line2];
    
}


-(void)touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    [user resignFirstResponder];
    [pwd resignFirstResponder];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [user resignFirstResponder];
    [pwd resignFirstResponder];
}

-(void)createButtons
{
    _landBtn=[self createButtonFrame:CGRectMake(10, 190+100+40, self.view.frame.size.width-20, Btn_H) backImageName:nil title:@"登录" titleColor:DEF_RGB_COLOR(255, 255, 255)  font:[UIFont systemFontOfSize:20] target:self action:@selector(landClick)];
    _landBtn.backgroundColor = DEF_RGB_COLOR(30 , 144, 255);
    _landBtn.layer.cornerRadius=5.0f;
    
    UIButton *forgotPwdBtn=[self createButtonFrame:CGRectMake(10, _landBtn.frame.origin.y + Btn_H, self.view.frame.size.width-20, Btn_H) backImageName:nil title:@"忘记密码" titleColor:DEF_RGB_COLOR(30 , 144, 255) font:[UIFont systemFontOfSize:20] target:self action:@selector(fogetPwd:)];
    forgotPwdBtn.backgroundColor = [UIColor clearColor];
    forgotPwdBtn.layer.cornerRadius=5.0f;
    
    
#define Start_X 60.0f           // 第一个按钮的X坐标
#define Start_Y 540.0f           // 第一个按钮的Y坐标
#define Width_Space 50.0f        // 2个按钮之间的横间距
#define Height_Space 20.0f      // 竖间距
#define Button_Height 50.0f    // 高
#define Button_Width 50.0f      // 宽
    
       [self.view addSubview:_landBtn];
    [self.view addSubview:forgotPwdBtn];
    
 
    
}







-(UITextField *)createTextFielfFrame:(CGRect)frame font:(UIFont *)font placeholder:(NSString *)placeholder
{
    UITextField *textField=[[UITextField alloc]initWithFrame:frame];
    
    textField.font=font;
    
    textField.textColor=[UIColor blackColor];
    
    textField.borderStyle=UITextBorderStyleNone;
    
    textField.placeholder=placeholder;
    
    return textField;
}

-(UIImageView *)createImageViewFrame:(CGRect)frame imageName:(NSString *)imageName color:(UIColor *)color
{
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:frame];
    
    if (imageName)
    {
        imageView.image=[UIImage imageNamed:imageName];
    }
    if (color)
    {
        imageView.backgroundColor=color;
    }
    
    return imageView;
}

-(UIButton *)createButtonFrame:(CGRect)frame backImageName:(NSString *)imageName title:(NSString *)title titleColor:(UIColor *)color font:(UIFont *)font target:(id)target action:(SEL)action
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=frame;
    if (imageName)
    {
        [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    
    if (font)
    {
        btn.titleLabel.font=font;
    }
    
    if (title)
    {
        [btn setTitle:title forState:UIControlStateNormal];
    }
    if (color)
    {
        [btn setTitleColor:color forState:UIControlStateNormal];
    }
    if (target&&action)
    {
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return btn;
}


//登录
-(void)landClick
{
    
//    NSString *sign = @"7ff13fffb954630662777173faa7ff8f";
//    NSUserDefaults *publicSign = [NSUserDefaults standardUserDefaults];
//    [publicSign setObject:sign forKey:@"privateSign"];
//    QMDTabBarVC *qmd = [[QMDTabBarVC alloc]init];
//    AppDelegate * dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    dele.window.rootViewController = qmd;

    if (user.text.length == 11 && pwd.text.length <= 16 && pwd.text.length >= 6) {
        [self postDate];
    }
    
    if (pwd.text.length < 6 || pwd.text.length > 16) {
        [pwd shake];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请输入正确的密码格式" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
    if (user.text.length != 11) {
        [user shake];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请输入正确的手机号码" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

-(void)postDate
{
    NSDictionary *params = @{
                         @"account"  :  user.text,
                         @"password" :  pwd.text,
                         };
    [SVProgressHUD show];
    [ZSNetWorkRequest POST:Login params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        if ([[responseObject objectForKey:@"status"] integerValue] == 1) {//进一步判断登陆状态，不是请求成功才为登陆成功。
//            LoginModel * model= [[LoginModel alloc] initWithDictionary:responseObject[@"data"]];
            
            
            LoginModel * mode =   [LoginModel sharedLoginModel];
            [mode intLoginSourceWithDict:responseObject[@"data"]];
            
            
            
       
            
//            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//            
//            NSString *username = [defaults stringForKey:@"username"];
//            
//            float textSize = [defaults floatForKey:@"text_size"];
//            
//            BOOL autoLogin = [defaults boolForKey:@"auto_login"];
            
            NSUserDefaults *loginData = [NSUserDefaults standardUserDefaults];
            [loginData setObject:mode.ID forKey:@"loginID"];
            [loginData setObject:mode.iconUrl forKey:@"loginIcon"];
            [loginData setObject:mode.account forKey:@"loginAccount"];
            [loginData setObject:mode.username forKey:@"loginName"];
//            QMDTabBarVC *qmd = [[QMDTabBarVC alloc]init];
//            [self presentViewController:qmd animated:YES completion:nil];
            //1.此时进入主页，显示用户的信息
            //2.例如model带着icon的url，然后调用下载的方法，去下载icon（image）
//          将签名sign对象存储到 NSUserDefaults中 后面中有调用
            NSString *sign = mode.sign;
            NSUserDefaults *publicSign = [NSUserDefaults standardUserDefaults];
            [publicSign setObject:sign forKey:@"privateSign"];
            
            
//            建立新的ID作为全宏变量
            NSString *IDD = mode.ID;
            NSUserDefaults *publicIDD = [NSUserDefaults standardUserDefaults];
            [publicIDD setObject:IDD forKey:@"privateIDD"];
            
            [[NSUserDefaults standardUserDefaults] setObject:@"loginSuccess" forKey:@"loginSuccess"];
            //  这个是上次你帮我改的根视图  还有帮我看下注册那块儿的界面跳转 感觉也是有问题
           QMDTabBarVC *qmd = [[QMDTabBarVC alloc]init];
           AppDelegate * dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
           dele.window.rootViewController = qmd;
            
        }else{
            UIAlertController * alertActionSheet = [UIAlertController alertControllerWithTitle:nil message:@"账号密码错误或网络超时" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction * alertActionTwo = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alertActionSheet addAction:alertActionTwo];
            [self presentViewController:alertActionSheet animated:YES completion:nil];
            
        }
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        UIAlertController * alertActionSheet = [UIAlertController alertControllerWithTitle:nil message:@"登录超时请重新登录" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * alertActionTwo = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertActionSheet addAction:alertActionTwo];
        [self presentViewController:alertActionSheet animated:YES completion:nil];
        [SVProgressHUD dismiss];

        
        
    }];
    

    
}

//注册
-(void)zhuce
{
    // 雷子 这个是注册 用的是模态 么有navigationController 不能push  完了就不会搞了
    MMZCHMViewController *mmhm = [[MMZCHMViewController alloc]init];
    UINavigationController *ptVC = [[UINavigationController alloc]initWithRootViewController:mmhm];
    [self presentViewController:ptVC animated:YES completion:nil];
}

-(void)registration:(UIButton *)button
{
    
    MMZCHMViewController *mmhm = [[MMZCHMViewController alloc]init];
    UINavigationController *ptVC = [[UINavigationController alloc]initWithRootViewController:mmhm];
    [self presentViewController:ptVC animated:YES completion:nil];
}

-(void)fogetPwd:(UIButton *)button
{
    [self presentViewController:[[WJMMViewController alloc]init] animated:YES completion:nil];
}

#pragma mark - 工具
//手机号格式化
-(NSString*)getHiddenStringWithPhoneNumber:(NSString*)number middle:(NSInteger)countHiiden{
    
    if (number.length<countHiiden) {
        return number;
    }
    NSInteger count=countHiiden;
    NSInteger leftCount=number.length/2-count/2;
    NSString *xings=@"";
    for (int i=0; i<count; i++) {
        xings=[NSString stringWithFormat:@"%@%@",xings,@"*"];
    }
    NSString *chuLi=[number stringByReplacingCharactersInRange:NSMakeRange(leftCount, count) withString:xings];
    return chuLi;
}

//手机号格式化后还原
-(NSString*)getHiddenStringWithPhoneNumber1:(NSString*)number middle:(NSInteger)countHiiden{
    // if (number.length>6) {
    if (number.length<countHiiden) {
        return number;
    }
    NSString *xings=@"";
    for (int i=0; i<1; i++) {
    }
    
    NSString *chuLi=[number stringByReplacingCharactersInRange:NSMakeRange(0, 0) withString:@""];
    
    return chuLi;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
