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
    CatDetailViewControllerMoalCityPciker,
    /**
     *  Viewcontroller with textview
     */
    CatDetailViewControllerMoalTextInput
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
    UITableView *_sectionsTable;
    UITextField *_enterTextField;
    UIDatePicker *_datePicker;
    UIPickerView *_cityPicker;
    UITextView *_enterTextView;
    UIAlertView *_detailControllerAlertView;
    NSMutableArray *_sectionsArray;
    NSMutableArray *_provinceArray;
    NSMutableDictionary *_cityDict;
    NSMutableArray *_cityArray;
    NSIndexPath *_checkmarkIndexPath;
    NSString *_datePickerFormatString;
    UIBarButtonItem *_saveBarBtn;
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
        _sectionsTable=[[UITableView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:_sectionsTable];
        
        if (sections.count==0) {
            _detailControllerAlertView=[[UIAlertView alloc] initWithTitle:@"CatDetailViewController"
                                                                  message:@"Please make sure array is not empty"
                                                                 delegate:self
                                                        cancelButtonTitle:@"OK"
                                                        otherButtonTitles:nil];
            [_detailControllerAlertView setTag:CatDetailViewControllerAlertViewModalSectionEmpty];
            [_detailControllerAlertView show];
        }else{
            _sectionsArray=[[NSMutableArray alloc] initWithArray:sections];
            [_sectionsTable registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
            _sectionsTable.delegate=self;
            _sectionsTable.dataSource=self;
            
            if ([sections containsObject:defaultSectionText]) {
                _checkmarkIndexPath=[NSIndexPath indexPathForRow:[sections indexOfObject:defaultSectionText] inSection:0];
            }else{
                _checkmarkIndexPath=nil;
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
        
        _enterTextField=[[UITextField alloc] initWithFrame:CGRectMake(8, 64+8, CGRectGetWidth(self.view.bounds)-16, 30)];
        [_enterTextField setBorderStyle:UITextBorderStyleRoundedRect];
        [_enterTextField setText:textFieldDefaultText];
        [_enterTextField setPlaceholder:textFieldPlaceholderText];
        [_enterTextField setKeyboardType:textFieldKeyboardType];
        [self.view addSubview:_enterTextField];
        
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
        
        _datePicker=[[UIDatePicker alloc] init];
        if (datePickerDefaultDate==nil) {
            [_datePicker setDate:[NSDate date] animated:YES];
        }else{
            [_datePicker setDate:datePickerDefaultDate animated:YES];
        }
        [_datePicker setDatePickerMode:datePickerMode];
        _datePickerFormatString=dateFormatString;
        [_datePicker setCenter:self.view.center];
        [self.view addSubview:_datePicker];
        
        [self initBaseLayout];
        self.saveHandle=saveHandle;
    }
    return self;
}

-(instancetype)initChinaCityPickerViewWithTitle:(NSString *)title
                                     saveHandle:(void (^)(NSString *))saveHandle{
    self=[super init];
    if (self) {
        [self setTitle:title];
        
        self.modal=CatDetailViewControllerMoalCityPciker;
        
        NSString *cityPlistPath=[[NSBundle mainBundle] pathForResource:@"ChinaCity" ofType:@"plist"];
        _cityDict=[NSMutableDictionary dictionaryWithContentsOfFile:cityPlistPath];
        _provinceArray=[[NSMutableArray alloc] init];
        [_provinceArray addObjectsFromArray:[_cityDict allKeys]];
        _cityArray=[[NSMutableArray alloc] init];
        [_cityArray addObjectsFromArray:[_cityDict objectForKey:[_provinceArray firstObject]]];
        _cityPicker=[[UIPickerView alloc] init];
        [_cityPicker setCenter:self.view.center];
        [self.view addSubview:_cityPicker];
        
        _cityPicker.delegate=self;
        _cityPicker.dataSource=self;
        
        [self initBaseLayout];
        self.saveHandle=saveHandle;
    }
    return self;
}

-(instancetype)initTextInputViewWithTitle:(NSString *)title text:(NSString *)text saveHandle:(void (^)(NSString *))saveHandle{
    self=[super init];
    if (self) {
        [self setTitle:title];
        
        self.modal=CatDetailViewControllerMoalTextInput;
        
        _enterTextView=[[UITextView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
        [self.view addSubview:_enterTextView];
        if (text.length!=0) {
            [_enterTextView setText:text];
        }
        
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
    _saveBarBtn=[[UIBarButtonItem alloc] initWithTitle:_saveButtonTitle==nil?@"Save":_saveButtonTitle
                                                                 style:UIBarButtonItemStyleDone
                                                                target:self
                                                                action:action];
    [self.navigationItem setRightBarButtonItem:_saveBarBtn
                                      animated:YES];
}

#pragma mark - Action Method
-(void)detailViewShowOnViewController:(UIViewController *)viewcontroller{
    switch (self.modal) {
        case CatDetailViewControllerMoalDatePicker:{
            [viewcontroller.navigationController pushViewController:self
                                                           animated:YES];
        }
            break;
        case CatDetailViewControllerMoalSingleSection:{
            [viewcontroller.navigationController pushViewController:self
                                                           animated:YES];
        }
            break;
        case CatDetailViewControllerMoalTextFieldEnter:{
            [viewcontroller.navigationController pushViewController:self
                                                           animated:YES];
        }
            break;
        case CatDetailViewControllerMoalCityPciker:{
            [viewcontroller.navigationController pushViewController:self
                                                           animated:YES];
        }
            break;
        case CatDetailViewControllerMoalTextInput:{
            [viewcontroller.navigationController pushViewController:self
                                                           animated:YES];
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
    
    _detailControllerAlertView=[[UIAlertView alloc] initWithTitle:self.saveConfirmAlertViewTitle
                                                          message:self.saveConfirmAlertViewMessage
                                                         delegate:self cancelButtonTitle:@"No"
                                                otherButtonTitles:@"Yes", nil];
    [_detailControllerAlertView setTag:CatDetailViewControllerAlertViewModalConfirm];
    [_detailControllerAlertView show];
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
    _detailControllerAlertView=[[UIAlertView alloc] initWithTitle:self.emptyResultAlertViewTitle
                                                          message:self.emptyResultAlertViewMessage
                                                         delegate:self cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
    [_detailControllerAlertView setTag:CatDetailViewControllerAlertViewModalEmptyResult];
    [_detailControllerAlertView show];
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
            self.saveResult=_enterTextField.text;
        }
            break;
        case CatDetailViewControllerMoalDatePicker:{
            NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:_datePickerFormatString];
            self.saveResult=[dateFormatter stringFromDate:_datePicker.date];
        }
            break;
        case CatDetailViewControllerMoalCityPciker:{
            NSString *provinceString=[_provinceArray objectAtIndex:[_cityPicker selectedRowInComponent:0]];
            NSString *cityString=[_cityArray objectAtIndex:[_cityPicker selectedRowInComponent:1]];
            self.saveResult=[NSString stringWithFormat:@"%@-%@",provinceString,cityString];
        }
            break;
        case CatDetailViewControllerMoalTextInput:{
            self.saveResult=_enterTextView.text;
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

- (void)setSaveButtonTitle:(NSString *)saveButtonTitle {
    [_saveBarBtn setTitle:saveButtonTitle];
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell.textLabel setText:[_sectionsArray objectAtIndex:indexPath.row]];
    if (indexPath!=nil) {
        if ([indexPath isEqual:_checkmarkIndexPath]) {
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
    return _sectionsArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _checkmarkIndexPath=indexPath;
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
        return _provinceArray.count;
    } else{
        return _cityArray.count;
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component==0) {
        return [_provinceArray objectAtIndex:row];
    }else{
        return [_cityArray objectAtIndex:row];
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component==0) {
        NSString *provinceName=[_provinceArray objectAtIndex:row];
        [_cityArray removeAllObjects];
        [_cityArray addObjectsFromArray:[_cityDict objectForKey:provinceName]];
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
