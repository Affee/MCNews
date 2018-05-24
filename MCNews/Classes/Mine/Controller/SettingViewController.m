//
//  SettingViewController.m
//  LovePet
//
//  Created by Affee on 2017/10/9.
//  Copyright © 2017年 affee. All rights reserved.
//

#import "SettingViewController.h"
#import "ChangePasswordViewController.h"
#import "SDImageCache.h"
#import "forgetPassWardViewController.h"
@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *labelArray;//标签数组

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的设置";
    _labelArray = @[@"清除缓存",@"修改密码"];

    [self initBuildUI];
}


-(void)initBuildUI
{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KKscreen_width, KKscreen_height-64) style:UITableViewStylePlain];
    
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = [UIView new];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = [UIColor whiteColor];;
    self.tableView.scrollEnabled = NO;
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    [self.view addSubview:self.tableView];
    
    UIButton *exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    exitBtn.frame = CGRectMake(15, KKscreen_height-220, KKscreen_width-30, 40);
    [exitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [exitBtn setBackgroundColor:KKColorPurple];
    exitBtn.layer.cornerRadius = 5.0;
    [exitBtn addTarget:self action:@selector(exitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:exitBtn];
}
#pragma mark ----- 退出登录按钮
-(void)exitBtnClick
{
    UIAlertController *alertContr = [UIAlertController alertControllerWithTitle:@"温馨提示!" message:@"确定要退出此账号吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSUserDefaults *loginData = [NSUserDefaults standardUserDefaults];
        NSDictionary *dictionary = [loginData dictionaryRepresentation];
        for(NSString *key in [dictionary allKeys]){
            [loginData removeObjectForKey:key];
            [loginData synchronize];
        }
        
        //清空本地信息
//        NSUserDefaults *loginData = [NSUserDefaults standardUserDefaults];
//        NSDictionary *dic = [loginData dictionaryRepresentation];
//        for (id key in [dic allKeys]) {
//            [loginData removeObjectForKey:key];
//            [loginData synchronize];
//        }
        //清理缓存    clearDisk----是添加了SDImageView的方法获取到的
        [[SDImageCache sharedImageCache] clearDisk];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertContr addAction:okAction];
    [alertContr addAction:cancelAction];
    [self presentViewController:alertContr animated:YES completion:nil];
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.labelArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell1"];
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    cell.selectionStyle = NO;
    
    if (indexPath.row == 1) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = self.labelArray[indexPath.row];
    
    if (indexPath.row == 0) {
        long long size = [[SDImageCache sharedImageCache] getSize];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2fM",size/1024.0/1024.0];
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        //修改密码
        forgetPassWardViewController *editPVC = [forgetPassWardViewController new];
        [self.navigationController pushViewController:editPVC animated:YES];
        
    }else if (indexPath.row == 0){
        //清理缓存    clearDisk----是添加了SDImageView的方法获取到的
        [[SDImageCache sharedImageCache] clearDisk];
        [SVProgressHUD showSuccessWithStatus:@"清除成功"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
        NSIndexPath *currentIP = [NSIndexPath indexPathForRow:1 inSection:0];
        [tableView reloadRowsAtIndexPaths:@[currentIP] withRowAnimation:UITableViewRowAnimationNone];
        
        
    }
}

@end
