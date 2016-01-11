//
//  DetailViewController.m
//  CatDetailViewController
//
//  Created by K-cat on 16/1/11.
//  Copyright © 2016年 K-cat. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAlertViewCancelButtonTitle:@"取消"];
    [self setAlertViewConfirmButtonTitle:@"确定"];
    [self setEmptyResultAlertViewTitle:@"温馨提示"];
    [self setEmptyResultAlertViewMessage:@"请填写正确的内容"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
