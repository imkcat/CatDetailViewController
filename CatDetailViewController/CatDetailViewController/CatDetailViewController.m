//
//  CatTableDetailViewController.m
//  Pettor Way
//
//  Created by K-cat on 15/6/12.
//  Copyright (c) 2015年 K-cat. All rights reserved.
//

#import "CatDetailViewController.h"

#define USAGE_GAP 8

/**
 *  Modal to judge what modal is the viewcontroller
 */
typedef NS_ENUM(NSInteger, CatDetailViewControllerMoal){
    /**
     *  Viewcontroller with single section
     */
    CatDetailViewControllerMoalSingleSection,
    /**
     *  Viewcontroller with textfield
     */
    CatDetailViewControllerMoalTextFieldEnter,
    /**
     *  Viewcontroller with datepicker
     */
    CatDetailViewControllerMoalDatePicker,
    /**
     *  Viewcontroller with enter alertcontroller
     */
    CatDetailViewControllerMoalAlertController,
    /**
     *  ViewController with action sheet
     */
    CatDetailViewControllerMoalActionSheet
};

/**
 *  Modal to judge what alertview it is
 */
typedef NS_ENUM(NSInteger, CatDetailViewControllerAlertViewModal){
    /**
     *  Empty information alertview
     */
    CatDetailViewControllerAlertViewModalEmptyResult,
    /**
     *  Confirm information alertview
     */
    CatDetailViewControllerAlertViewModalConfirm,
    /**
     *  Section empty alertview
     */
    CatDetailViewControllerAlertViewModalSectionEmpty
};

static NSString *const cellIdentifier=@"SectionsTableViewCellIdentifier";

@interface CatDetailViewController ()<UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate, UITextFieldDelegate, UIActionSheetDelegate>{
    UITableView *sectionsTable;
    UITextField *enterTextField;
    UIDatePicker *datePicker;
    UIAlertView *detailControllerAlertView;
    NSMutableArray *sectionsArray;
    NSIndexPath *checkmarkIndexPath;
    NSString *datePickerFormatString;
}

/**
 *  The viewcontroller modal
 */
@property (nonatomic) CatDetailViewControllerMoal modal;

/**
 *  A block handler perform save action
 */
@property (nonatomic ,copy) void (^saveHandle)(NSString *saveResult);

/**
 *  The result string
 */
@property (nonatomic ,copy) NSString *saveResult;

/**
 *  The alertViewcontoll for enter
 */
@property(nonatomic ,retain) UIAlertController *enterAlertView NS_AVAILABLE_IOS(8_0);

/**
 *  The actionsheet for ios 7.0+
 */
@property(nonatomic ,retain) UIActionSheet *actionSheet;

/**
 *  Array contain all actionsheet item
 */
@property(nonatomic ,retain) NSMutableArray *actionSheetItemArray;

/**
 *  The alertcontroller for ios 8.0+
 */
@property(nonatomic ,retain) UIAlertController *alertController;

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
        
        if (sections.count==0) {
            detailControllerAlertView=[[UIAlertView alloc] initWithTitle:@"CatDetailViewController" message:@"Please make sure array is not empty" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [detailControllerAlertView setTag:CatDetailViewControllerAlertViewModalSectionEmpty];
            [detailControllerAlertView show];
        }else{
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
            self.saveHandle=saveHandle;
        }
    }
    return self;
}


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
        self.saveHandle=saveHandle;
    }
    return self;
}

-(instancetype)initDatePickerViewWithTitle:(NSString *)title
                     datePickerDefaultDate:(NSDate *)datePickerDefaultDate
                          dateFormatString:(NSString *)dateFormatString
                            datePickerMode:(UIDatePickerMode)datePickerMode
                                saveHandle:(void (^)(NSString *))saveHandle{
    self=[super init];
    if (self) {
        [self setTitle:title];
        
        self.modal=CatDetailViewControllerMoalDatePicker;
        
        datePicker=[[UIDatePicker alloc] init];
        if (datePickerDefaultDate==nil) {
            [datePicker setDate:[NSDate date] animated:YES];
        }else{
            [datePicker setDate:datePickerDefaultDate animated:YES];
        }
        [datePicker setDatePickerMode:datePickerMode];
        datePickerFormatString=dateFormatString;
        [datePicker setCenter:self.view.center];
        [self.view addSubview:datePicker];
        
        [self initBaseLayout];
        self.saveHandle=saveHandle;
    }
    return self;
}

-(instancetype)initEnterAlertViewWithTitle:(NSString *)title
                                   message:(NSString *)message
                             textfieldText:(NSString *)textfieldText
                      textfieldPlaceholder:(NSString *)textfieldPlaceholder
                         cancelButtonTitle:(NSString *)cancelButtonTitle
                           saveButtonTitle:(NSString *)savelButtonTitle
                                saveHandle:(void (^)(NSString *))saveHandle{
    self=[super init];
    if (self) {
        self.modal=CatDetailViewControllerMoalAlertController;
        
        self.enterAlertView=[UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        [self.enterAlertView addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            [textField setPlaceholder:textfieldPlaceholder];
            [textField setText:textfieldText];
        }];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alertControllerTextFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:[self.enterAlertView.textFields firstObject]];
        [self.enterAlertView addAction:[UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            [self.enterAlertView dismissViewControllerAnimated:YES completion:nil];
        }]];
        [self.enterAlertView addAction:[UIAlertAction actionWithTitle:savelButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self saveBarBtnAction];
        }]];
        
        [self alertControllerTextFieldTextDidChange:nil];
        self.saveHandle=saveHandle;
    }
    return self;
}

-(instancetype)initActionSheetWithTitle:(NSString *)title
                              itemArray:(NSArray *)itemArray
                        cancelItemTitle:(NSString *)cancelItemTitle{
    self=[super init];
    if (self) {
        self.modal=CatDetailViewControllerMoalActionSheet;
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0) {
            self.alertController=[UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            for (CatDetailActionSheetItem *item in itemArray) {
                [self.alertController addAction:[UIAlertAction actionWithTitle:item.itemTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    item.actionHandle(item);
                }]];
            }
            [self.alertController addAction:[UIAlertAction actionWithTitle:cancelItemTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                [self.alertController dismissViewControllerAnimated:YES completion:nil];
            }]];
        }else{
            self.actionSheet=[[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:nil destructiveButtonTitle:cancelItemTitle otherButtonTitles:nil];
            self.actionSheetItemArray=[[NSMutableArray alloc] initWithArray:itemArray];
            for (CatDetailActionSheetItem *item in itemArray) {
                [self.actionSheet addButtonWithTitle:item.itemTitle];
            }
        }
    }
    return self;
}

/**
 *  Init view base layout
 */
-(void)initBaseLayout{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    if (self.enableConfirmAlertView) {
        [self initSaveBarBtnWithAction:@selector(showConfirmAlertView)];
    } else {
        [self initSaveBarBtnWithAction:@selector(saveBarBtnAction)];
    }
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

#pragma mark - Action Method
-(void)detaiViewShowOnViewController:(UIViewController *)viewcontroller{
    switch (self.modal) {
        case CatDetailViewControllerMoalDatePicker:{
            [viewcontroller.navigationController pushViewController:self animated:YES];
        }
            break;
        case CatDetailViewControllerMoalSingleSection:{
            [viewcontroller.navigationController pushViewController:self animated:YES];
        }
            break;
        case CatDetailViewControllerMoalTextFieldEnter:{
            [viewcontroller.navigationController pushViewController:self animated:YES];
        }
            break;
        case CatDetailViewControllerMoalAlertController:{
            [viewcontroller presentViewController:self.enterAlertView animated:YES completion:nil];
        }
            break;
        case CatDetailViewControllerMoalActionSheet:{
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0) {
                [viewcontroller presentViewController:self.alertController animated:YES completion:nil];
            }else{
                [self.actionSheet showInView:viewcontroller.view];
            }
        }
            break;
        default:
            break;
    }
}

/**
 *  Show confirm information alert view
 */
-(void)showConfirmAlertView{
    if (!self.saveConfirmAlertViewTitle) {
        self.saveConfirmAlertViewTitle=@"Notice";
    }
    if (!self.saveConfirmAlertViewMessage) {
        self.saveConfirmAlertViewMessage=@"Do you confirm this information";
    }
    
    detailControllerAlertView=[[UIAlertView alloc] initWithTitle:self.saveConfirmAlertViewTitle message:self.saveConfirmAlertViewMessage delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [detailControllerAlertView setTag:CatDetailViewControllerAlertViewModalConfirm];
    [detailControllerAlertView show];
}

/**
 *  Show empty information alert view
 */
-(void)showEmptyAlertView{
    if (!self.emptyResultAlertViewTitle) {
        self.emptyResultAlertViewTitle=@"Notice";
    }
    if (!self.emptyResultAlertViewMessage) {
        self.emptyResultAlertViewMessage=@"You must confirm information is available";
    }
    detailControllerAlertView=[[UIAlertView alloc] initWithTitle:self.emptyResultAlertViewTitle message:self.emptyResultAlertViewMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [detailControllerAlertView setTag:CatDetailViewControllerAlertViewModalEmptyResult];
    [detailControllerAlertView show];
}

/**
 *  Save bar item action
 */
-(void)saveBarBtnAction{
    switch (self.modal) {
        case CatDetailViewControllerMoalSingleSection:{
            self.saveHandle(self.saveResult);
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case CatDetailViewControllerMoalTextFieldEnter:{
            self.saveResult=enterTextField.text;
        }
            break;
        case CatDetailViewControllerMoalDatePicker:{
            NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:datePickerFormatString];
            self.saveResult=[dateFormatter stringFromDate:datePicker.date];
        }
            break;
        case CatDetailViewControllerMoalAlertController:{
            self.saveResult=((UITextField *)[self.enterAlertView.textFields firstObject]).text;
        }
            break;
        default:
            break;
    }
    
    if (!self.allowResultEmpty) {
        if (![self.saveResult isEqualToString:@""]&&self.saveResult!=nil) {
            self.saveHandle(self.saveResult);
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [self showEmptyAlertView];
        }
    } else {
        self.saveHandle(self.saveResult);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - UIAlertController
-(void)alertControllerTextFieldTextDidChange:(id)sender{
    NSString *textFieldText=((UITextField *)[self.enterAlertView.textFields firstObject]).text;
    if (!self.allowResultEmpty) {
        if (textFieldText.length == 0) {
            [[self.enterAlertView.actions objectAtIndex:1] setEnabled:NO];
        }else{
            [[self.enterAlertView.actions objectAtIndex:1] setEnabled:YES];
        }
    }
}

#pragma mark - Properties getter and setter
-(void)setEnableConfirmAlertView:(BOOL)enableConfirmAlertView{
    if (enableConfirmAlertView) {
        [self initSaveBarBtnWithAction:@selector(showConfirmAlertView)];
    } else {
        [self initSaveBarBtnWithAction:@selector(saveBarBtnAction)];
    }
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

#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (alertView.tag) {
        case CatDetailViewControllerAlertViewModalSectionEmpty:{
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case CatDetailViewControllerAlertViewModalEmptyResult:{
        }
            break;
        case CatDetailViewControllerAlertViewModalConfirm:{
            if (buttonIndex==1) {
                [self saveBarBtnAction];
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark - UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex!=0) {
        CatDetailActionSheetItem *item=[self.actionSheetItemArray objectAtIndex:buttonIndex-1];
        item.actionHandle(item);
    }
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
