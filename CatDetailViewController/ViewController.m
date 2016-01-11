//
//  ViewController.m
//  DetailViewController
//
//  Created by K-cat on 15/6/12.
//  Copyright (c) 2015年 K-cat. All rights reserved.
//

#import "ViewController.h"
#import "MainViewTableViewCell.h"
#import "DetailViewController.h"

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
                    DetailViewController *detailView=[[DetailViewController alloc] initSingleSectionViewWithTitle:@"Select Color"
                                                                                                         sections:@[@"Red",@"Blue"]
                                                                                               defaultSectionText:cell.detailTextLabel.text
                                                                                                       saveHandle:^(NSString *saveResult) {
                                                                                                           [cell.detailTextLabel setText:saveResult];
                                                                                                       }];
                    [detailView detailViewShowOnViewController:self];
                }
                    break;
                case 1:{
                    DetailViewController *detailView=[[DetailViewController alloc] initTextFieldEnterViewWithTitle:@"Enter Something"
                                                                                              textFieldDefaultText:cell.detailTextLabel.text
                                                                                          textFieldPlaceholderText:nil
                                                                                             textFieldKeyboardType:UIKeyboardTypeDefault
                                                                                                        saveHandle:^(NSString *saveResult) {
                                                                                                            [cell.detailTextLabel setText:saveResult];
                                                                                                        }];
                    [detailView detailViewShowOnViewController:self];
                }
                    break;
                case 2:{
                    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                    DetailViewController *detailView=[[DetailViewController alloc] initDatePickerViewWithTitle:@"Select Date"
                                                                                         datePickerDefaultDate:[dateFormatter dateFromString:cell.detailTextLabel.text]
                                                                                              dateFormatString:@"yyyy-MM-dd"
                                                                                                datePickerMode:UIDatePickerModeDate
                                                                                                    saveHandle:^(NSString *saveResult) {
                                                                                                        [cell.detailTextLabel setText:saveResult];
                                                                                                    }];
                    [detailView detailViewShowOnViewController:self];
                }
                    break;
                case 3:{
                    DetailViewController *detailView=[[DetailViewController alloc] initChinaCityPickerViewWithTitle:@"Select city"
                                                                                                         saveHandle:^(NSString *saveResult) {
                                                                                                             [cell.detailTextLabel setText:saveResult];
                                                                                                         }];
                    [detailView detailViewShowOnViewController:self];
                }
                    break;
                case 4:{
                    DetailViewController *detailView=[[DetailViewController alloc] initTextInputViewWithTitle:@"Enter Something" text:cell.detailTextLabel.text saveHandle:^(NSString *saveResult) {
                        [cell.detailTextLabel setText:saveResult];
                    }];
                    [detailView detailViewShowOnViewController:self];
                }
                    break;
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
    return 5;
}

@end
