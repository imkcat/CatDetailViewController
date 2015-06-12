//
//  ViewController.m
//  CatDetailViewController
//
//  Created by K-cat on 15/6/12.
//  Copyright (c) 2015年 K-cat. All rights reserved.
//

#import "ViewController.h"
#import "MainViewTableViewCell.h"
#import "CatDetailViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ViewController
@synthesize mainTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initBaseLayout];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Init method
-(void)initBaseLayout{
    [self setTitle:@"Select modal"];
    
    mainTableView.delegate=self;
    mainTableView.dataSource=self;
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MainViewTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"MainViewTableViewCell" forIndexPath:indexPath];
    [cell loadCellWithIndexPath:indexPath];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    switch (indexPath.section) {
        case 0:{
            switch (indexPath.row) {
                case 0:{
                    CatDetailViewController *detailView=[[CatDetailViewController alloc] initSingleSectionViewWithTitle:@"Select Color" sections:@[@"Red",@"Blue"] defaultSectionText:cell.detailTextLabel.text saveHandle:^(NSString *saveResult) {
                        [cell.detailTextLabel setText:saveResult];
                    }];
                    [self.navigationController pushViewController:detailView animated:YES];
                }
                    break;
                case 1:{
                    CatDetailViewController *detailView=[[CatDetailViewController alloc] initTextFieldEnterViewWithTitle:@"Enter Something" textFieldDefaultText:cell.detailTextLabel.text textFieldPlaceholderText:nil textFieldKeyboardType:UIKeyboardTypeDefault saveHandle:^(NSString *saveResult) {
                        [cell.detailTextLabel setText:saveResult];
                    }];
                    [self.navigationController pushViewController:detailView animated:YES];
                }
                default:
                    break;
            }
        }
            break;
        default:
            break;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

@end
