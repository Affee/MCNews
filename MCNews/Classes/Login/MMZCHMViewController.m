//
//  DLCGViewController.h
//  qqqqqqqqq
//
//  Created by 墨炎 on 2016/12/16.
//  Copyright © 2016年 hyc. All rights reserved.
//
#import "MMZCHMViewController.h"
#import "settingPassWardViewController.h"
#import "MMZCViewController.h"
#import "Header.h"
#import "UITextField+Shake.h"
#import "settinhHeaderViewController.h"
#import "QMDTabBarVC.h"
#import "AFNetworking.h"
#import "NSString+MD5.h"
#import "AffeeBaseRequest.h"


@interface MMZCHMViewController ()
{
    UIView *bgView;
    UITextField *phone;
    UITextField *code;
    UINavigationBar *customNavigationBar;
    UIButton *yzButton;
}

@property(nonatomic, copy) NSString *oUserPhoneNum;
@property(assign, nonatomic) NSInteger timeCount;
@property(strong, nonatomic) NSTimer *timer;
//验证码
@property(copy, nonatomic) NSString *smsId;
@end

@implementation MMZCHMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title=@"注册";
//    修改title的颜色 和字体大小
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = DEF_RGB_COLOR(246, 246, 250);
    // 设置左右按钮（UIBarButton）
    // 设置文字
    UIBarButtonItem * leftBarItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(clickLeftBarItem)];
    leftBarItem.tintColor = DEF_RGB_COLOR(30, 144, 255);
    self.navigationItem.leftBarButtonItem = leftBarItem;
    
    [self createTextFields];

}

-(void)clickaddBtn
{
    [self.navigationController popViewControllerAnimated:YES];
    //[self.navigationController pushViewController:[[MMZCViewController alloc]init] animated:YES];
}

-(void)createTextFields
{
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(15, 75, self.view.frame.size.width-90, 30)];
    label.text=@"请输入您的手机号码";
    label.textColor=[UIColor grayColor];
    label.textAlignment=NSTextAlignmentLeft;
    label.font=[UIFont systemFontOfSize:14];
    
    [self.view addSubview:label];

   
        bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 110, SCR_W, 100)];
        bgView.layer.cornerRadius=3.0;
        bgView.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:bgView];
        
        phone=[self createTextFielfFrame:CGRectMake(75, 10, SCR_W-75, 30) font:[UIFont systemFontOfSize:15] placeholder:@"11位手机号"];
        phone.clearButtonMode = UITextFieldViewModeWhileEditing;
        phone.keyboardType=UIKeyboardTypeNumberPad;
  
    
        code=[self createTextFielfFrame:CGRectMake(75, 60, SCR_W - 75, 30) font:[UIFont systemFontOfSize:15]  placeholder:@"请输入6位以上密码" ];
        code.clearButtonMode = UITextFieldViewModeWhileEditing;
        //密文样式
        code.secureTextEntry=YES;
        
    UILabel *phonelabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 12, 75, 30)];
    phonelabel.text=@"手机号";
    phonelabel.textColor=[UIColor blackColor];
    phonelabel.textAlignment=UITextAlignmentCenter;
//    phonelabel.font=[UIFont systemFontOfSize:15];
    
    UILabel *codelabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 62, 75, 25)];
    codelabel.text=@"密码";
    codelabel.textColor=[UIColor blackColor];
    codelabel.textAlignment=UITextAlignmentCenter;
//    codelabel.font=[UIFont systemFontOfSize:15];
    
    
    

    UIImageView *line1=[self createImageViewFrame:CGRectMake(0, 50, SCR_W, 1) imageName:nil color:[UIColor colorWithRed:180/255.0f green:180/255.0f blue:180/255.0f alpha:.3]];
    
    UIButton *landBtn=[self createButtonFrame:CGRectMake(10, bgView.frame.size.height+bgView.frame.origin.y+50,self.view.frame.size.width-20, 50) backImageName:nil title:@"下一步" titleColor:[UIColor whiteColor]  font:[UIFont systemFontOfSize:17] target:self action:@selector(next)];
    landBtn.backgroundColor = DEF_RGB_COLOR(30 , 144, 255) ;
    landBtn.layer.cornerRadius=5.0f;

        
    [bgView addSubview:phone];
    [bgView addSubview:code];
        
    [bgView addSubview:phonelabel];
    [bgView addSubview:codelabel];
    [bgView addSubview:line1];
    [self.view addSubview:landBtn];
    
}

- (void)getValidCode:(UIButton *)sender
{
    if ([phone.text isEqualToString:@""])
    {
        return;
    }
    else if (phone.text.length <11)
    {
        return;
    }
    _oUserPhoneNum =phone.text;
    sender.userInteractionEnabled = NO;
    self.timeCount = 60;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(reduceTime:) userInfo:sender repeats:YES];
    
  }


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [phone resignFirstResponder];
    [code  resignFirstResponder];
    
}

-(UITextField *)createTextFielfFrame:(CGRect)frame font:(UIFont *)font placeholder:(NSString *)placeholder
{
    UITextField *textField=[[UITextField alloc]initWithFrame:frame];
    
    textField.font=font;
    
    textField.textColor=[UIColor grayColor];
    
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

//验证码
-(void)next
{
    if (phone.text.length == 11 && code.text.length >= 6) {
        [self postData];

        //        UINavigationController *detailVC = [[UINavigationController alloc]initWithRootViewController:_ptDetailsVC];
        //        [self presentViewController:detailVC animated:YES completion:nil];
//        settinhHeaderViewController *setin = [[settinhHeaderViewController alloc]init];
//        
//        UINavigationController *headerVC = [[UINavigationController alloc]initWithRootViewController:setin];
//        [self presentViewController:headerVC animated:YES completion:nil];
        
        
    [self presentViewController:[[ settinhHeaderViewController alloc]init] animated:YES completion:nil];
    
    }
    if (phone.text.length != 11) {
        [phone shake];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请输入正确的手机号码" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
    if (code.text.length < 6 ) {
        [code shake];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请输入6位以上密码" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    
    }
}

-(void)postData
{
    
    
    
            NSString *pswMD5 = [phone.text MD5];

    NSDictionary *params = @{
                            @"account":phone.text,
                            @"password":code.text,
                            @"sign":pswMD5,
                            @"role":@"1"
                            };
  

    [ZSNetWorkRequest POST:Register params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSString *sign = responseObject[@"sign"];
        NSUserDefaults *user =  [NSUserDefaults standardUserDefaults];
        [user setObject:sign forKey:@"sign"];
        
        // 解析成功
        NSLog(@"JSON: %@", responseObject);
      
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
       
        // 解析失败
        NSLog(@"error:++++%@",error.localizedDescription);
    }];
    NSLog(@"%@",params);
    
}

- (void)clickLeftBarItem {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 
}



@end
