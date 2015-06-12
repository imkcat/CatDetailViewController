//
//  CatTableDetailViewController.m
//  Pettor Way
//
//  Created by K-cat on 15/6/12.
//  Copyright (c) 2015年 K-cat. All rights reserved.
//

#import "CatDetailViewController.h"

#define USAGE_GAP 8

typedef NS_ENUM(NSInteger, CatDetailViewControllerMoal) {
    CatDetailViewControllerMoalSingleSection,
    CatDetailViewControllerMoalTextFieldEnter
};

static NSString *const cellIdentifier=@"SectionsTableViewCellIdentifier";

@interface CatDetailViewController ()<UITableViewDelegate, UITableViewDataSource>{
    UITableView *sectionsTable;
    NSMutableArray *sectionsArray;
    NSIndexPath *checkmarkIndexPath;
    UITextField *enterTextField;
}

@property (nonatomic) CatDetailViewControllerMoal modal;
@property (nonatomic ,copy) void (^saveHandle)(NSString *saveResult);
@property (nonatomic ,copy) NSString *saveResult;

@end

@implementation CatDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Init method
/**
 *  Return a new detailViewController base on single section modal
 *
 *  @param title      ViewController title
 *  @param sections   Array contains all sections
 *  @param defaultSectionText Default section text
 *  @param saveHandle Save bar item action handle
 *
 *  @return New initialize detailviewcontroller
 */
-(instancetype)initSingleSectionViewWithTitle:(NSString *)title
                                     sections:(NSArray *)sections
                            defaultSectionText:(NSString *)defaultSectionText
                                   saveHandle:(void (^)(NSString *))saveHandle{
    self=[super init];
    if (self) {
        self.modal=CatDetailViewControllerMoalSingleSection;
        
        [self setTitle:title];
        sectionsTable=[[UITableView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:sectionsTable];
        
        sectionsArray=[[NSMutableArray alloc] initWithArray:sections];
        [sectionsTable registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
        sectionsTable.delegate=self;
        sectionsTable.dataSource=self;
        
        if ([sections containsObject:defaultSectionText]) {
            checkmarkIndexPath=[NSIndexPath indexPathForRow:[sections indexOfObject:defaultSectionText] inSection:0];
        }else{
            checkmarkIndexPath=nil;
        }
        
        [self initBaseLayout];
        [self initSaveBarBtnWithAction:@selector(saveBarBtnAction)];
        
        self.saveHandle=saveHandle;
    }
    return self;
}

/**
 *  Return a new detailViewController base on textfield enter modal
 *
 *  @param title                  ViewController title
 *  @param textFieldDefaultText   TextField defaultText
 *  @param textFieldPlaceholderText TextField placeholder
 *  @param textFieldKeyboardType  TextField appear keyboard type
 *  @param saveHandle             Save bar item action handle
 *
 *  @return New initialize detailviewcontroller
 */
-(instancetype)initTextFieldEnterViewWithTitle:(NSString *)title
                          textFieldDefaultText:(NSString *)textFieldDefaultText
                        textFieldPlaceholderText:(NSString *)textFieldPlaceholderText
                         textFieldKeyboardType:(UIKeyboardType)textFieldKeyboardType
                                    saveHandle:(void (^)(NSString *))saveHandle{
    self=[super init];
    if (self) {
        [self setTitle:title];
        
        self.modal=CatDetailViewControllerMoalTextFieldEnter;
        
        enterTextField=[[UITextField alloc] initWithFrame:CGRectMake(8, 64+8, CGRectGetWidth(self.view.bounds)-16, 30)];
        [enterTextField setBorderStyle:UITextBorderStyleRoundedRect];
        [enterTextField setText:textFieldDefaultText];
        [enterTextField setPlaceholder:textFieldPlaceholderText];
        [enterTextField setKeyboardType:textFieldKeyboardType];
        [self.view addSubview:enterTextField];
        
        [self initBaseLayout];
        [self initSaveBarBtnWithAction:@selector(saveBarBtnAction)];
        
        self.saveHandle=saveHandle;
    }
    return self;
}

//-(instancetype)initDatePickerViewWithTitle:(NSString *)title
//                     datePickerDefaultDate:(NSDate *)datePickerDefaultDate
//                            datePickerMode:(UIDatePickerMode)datePickerMode
//                                saveHandle:(void (^)(NSString *))saveHandle{
//    
//}

/**
 *  Init view base layout
 */
-(void)initBaseLayout{
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

/**
 *  Set save bar button item with special action
 *
 *  @param action Special action
 */
-(void)initSaveBarBtnWithAction:(SEL)action{
    UIBarButtonItem *saveBarBtn=[[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:action];
    [self.navigationItem setRightBarButtonItem:saveBarBtn animated:YES];
}

/**
 *  Save bar item action
 */
-(void)saveBarBtnAction{
    if (self.saveHandle) {
        switch (self.modal) {
            case CatDetailViewControllerMoalSingleSection:{
                self.saveHandle(self.saveResult);
            }
                break;
            case CatDetailViewControllerMoalTextFieldEnter:{
                self.saveHandle(enterTextField.text);
            }
                break;
            default:
                break;
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell.textLabel setText:[sectionsArray objectAtIndex:indexPath.row]];
    if (indexPath!=nil) {
        if ([indexPath isEqual:checkmarkIndexPath]) {
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        }else{
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        }
    }else{
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return sectionsArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    checkmarkIndexPath=indexPath;
    [tableView reloadData];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.saveResult=[tableView cellForRowAtIndexPath:indexPath].textLabel.text;
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
