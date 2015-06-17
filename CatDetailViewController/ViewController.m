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

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>{
    CatDetailViewController *detailView1;
}

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
                    CatDetailViewController *detailView=[[CatDetailViewController alloc] initSingleSectionViewWithTitle:@"Select Color"
                                                                                                               sections:@[@"Red",@"Blue"]
                                                                                                     defaultSectionText:cell.detailTextLabel.text
                                                                                                             saveHandle:^(NSString *saveResult) {
                                                                                                                 [cell.detailTextLabel setText:saveResult];
                    }];
                    [detailView detaiViewShowOnViewController:self];
                }
                    break;
                case 1:{
                    CatDetailViewController *detailView=[[CatDetailViewController alloc] initTextFieldEnterViewWithTitle:@"Enter Something"
                                                                                                    textFieldDefaultText:cell.detailTextLabel.text
                                                                                                textFieldPlaceholderText:nil
                                                                                                   textFieldKeyboardType:UIKeyboardTypeDefault
                                                                                                              saveHandle:^(NSString *saveResult) {
                                                                                                                  [cell.detailTextLabel setText:saveResult];
                    }];
                    [detailView detaiViewShowOnViewController:self];
                }
                    break;
                case 2:{
                    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                    CatDetailViewController *detailView=[[CatDetailViewController alloc] initDatePickerViewWithTitle:@"Select Date"
                                                                                               datePickerDefaultDate:[dateFormatter dateFromString:cell.detailTextLabel.text]
                                                                                                    dateFormatString:@"yyyy-MM-dd"
                                                                                                      datePickerMode:UIDatePickerModeDate
                                                                                                          saveHandle:^(NSString *saveResult) {
                                                                                                              [cell.detailTextLabel setText:saveResult];
                    }];
                    [detailView detaiViewShowOnViewController:self];
                }
                    break;
                case 3:{
                    CatDetailViewController *detailView=[[CatDetailViewController alloc] initEnterAlertViewWithTitle:@"AlertView Enter"
                                                                                                             message:@"Please enter something"
                                                                                                       textfieldText:cell.detailTextLabel.text
                                                                                                textfieldPlaceholder:@"Email,phone and other"
                                                                                                   cancelButtonTitle:@"Cancel"
                                                                                                     saveButtonTitle:@"Save"
                                                                                                          saveHandle:^(NSString *saveResult) {
                                                                                                              [cell.detailTextLabel setText:saveResult];
                    }];
                    [detailView detaiViewShowOnViewController:self];
                }
                    break;
                case 4:{
                    CatDetailActionSheetItem *manItem=[[CatDetailActionSheetItem alloc] initWithTitle:@"Man" actionHandle:^(CatDetailActionSheetItem *item) {
                        [cell.detailTextLabel setText:item.itemTitle];
                    }];
                    CatDetailActionSheetItem *womanItem=[[CatDetailActionSheetItem alloc] initWithTitle:@"Woman" actionHandle:^(CatDetailActionSheetItem *item) {
                        [cell.detailTextLabel setText:item.itemTitle];
                    }];
                    detailView1=[[CatDetailViewController alloc] initActionSheetWithTitle:@"Choose one of them" itemArray:@[manItem, womanItem] cancelItemTitle:@"Cancel"];
                    [detailView1 detaiViewShowOnViewController:self];
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
