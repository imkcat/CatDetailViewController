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
     *  Viewcontroller with citypicker
     */
    CatDetailViewControllerMoalCityPciker
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

@interface CatDetailViewController ()<UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate, UITextFieldDelegate, UIActionSheetDelegate, UIPickerViewDataSource, UIPickerViewDelegate>{
    UITableView *sectionsTable;
    UITextField *enterTextField;
    UIDatePicker *datePicker;
    UIPickerView *cityPicker;
    UIAlertView *detailControllerAlertView;
    NSMutableArray *sectionsArray;
    NSMutableArray *provinceArray;
    NSMutableDictionary *cityDict;
    NSMutableArray *cityArray;
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

-(instancetype)initChinaCityPickerViewWithTitle:(NSString *)title
                                     saveHandle:(void (^)(NSString *))saveHandle{
    self=[super init];
    if (self) {
        self.modal=CatDetailViewControllerMoalCityPciker;
        
        NSString *cityPlistPath=[[NSBundle mainBundle] pathForResource:@"ChinaCity" ofType:@"plist"];
        cityDict=[NSMutableDictionary dictionaryWithContentsOfFile:cityPlistPath];
        provinceArray=[[NSMutableArray alloc] init];
        [provinceArray addObjectsFromArray:[cityDict allKeys]];
        cityArray=[[NSMutableArray alloc] init];
        [cityArray addObjectsFromArray:[cityDict objectForKey:[provinceArray firstObject]]];
        cityPicker=[[UIPickerView alloc] init];
        [cityPicker setCenter:self.view.center];
        [self.view addSubview:cityPicker];
        
        cityPicker.delegate=self;
        cityPicker.dataSource=self;
        
        [self initBaseLayout];
        self.saveHandle=saveHandle;
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
-(void)detailViewShowOnViewController:(UIViewController *)viewcontroller{
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
        case CatDetailViewControllerMoalCityPciker:{
            [viewcontroller.navigationController pushViewController:self animated:YES];
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
        case CatDetailViewControllerMoalCityPciker:{
            NSString *provinceString=[provinceArray objectAtIndex:[cityPicker selectedRowInComponent:0]];
            NSString *cityString=[cityArray objectAtIndex:[cityPicker selectedRowInComponent:1]];
            self.saveResult=[NSString stringWithFormat:@"%@-%@",provinceString,cityString];
        }
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

#pragma mark - UIPickerViewDelegate
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component==0) {
        return provinceArray.count;
    } else{
        return cityArray.count;
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component==0) {
        return [provinceArray objectAtIndex:row];
    }else{
        return [cityArray objectAtIndex:row];
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component==0) {
        NSString *provinceName=[provinceArray objectAtIndex:row];
        [cityArray removeAllObjects];
        [cityArray addObjectsFromArray:[cityDict objectForKey:provinceName]];
        [pickerView reloadComponent:1];
    }
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
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
