//
//  CatTableDetailViewController.h
//  Pettor Way
//
//  Created by K-cat on 15/6/12.
//  Copyright (c) 2015年 K-cat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CatDetailViewController : UIViewController

/**
 *  A boolean value that the confirm information alertview show(Default is NO)
 */
@property(nonatomic) BOOL enableConfirmAlertView;

/**
 *  A boolean value that the empty information alertview show(Default is NO)
 */
@property(nonatomic) BOOL allowResultEmpty;

/**
 *  The text for save alertview message
 */
@property(nonatomic ,copy) NSString *saveConfirmAlertViewMessage;

/**
 *  The text for save alertview title
 */
@property(nonatomic ,copy) NSString *saveConfirmAlertViewTitle;

/**
 *  The text for empty alertview message
 */
@property(nonatomic ,copy) NSString *emptyResultAlertViewMessage;

/**
 *  The text for empty alertview title
 */
@property(nonatomic ,copy) NSString *emptyResultAlertViewTitle;

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
                                   saveHandle:(void(^)(NSString *saveResult))saveHandle;

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
                                    saveHandle:(void(^)(NSString *saveResult))saveHandle;


/**
 *  Return a new detailViewController base on datepicker modal
 *
 *  @param title                 ViewController title
 *  @param datePickerDefaultDate DatePicker default date
 *  @param dateFormatString      Format date string
 *  @param datePickerMode        DatePicker mode
 *  @param saveHandle            Save bar item action handle
 *
 *  @return New initialize detailviewcontroller
 */
-(instancetype)initDatePickerViewWithTitle:(NSString *)title
                     datePickerDefaultDate:(NSDate *)datePickerDefaultDate
                          dateFormatString:(NSString *)dateFormatString
                            datePickerMode:(UIDatePickerMode)datePickerMode
                                saveHandle:(void(^)(NSString *saveResult))saveHandle;

/**
 *  Return a new detailViewController base on citypicker modal
 *
 *  @param title      ViewController title
 *  @param saveHandle Save bar item action handle
 *
 *  @return New initialize detailviewcontroller
 */
-(instancetype)initChinaCityPickerViewWithTitle:(NSString *)title
                                     saveHandle:(void(^)(NSString *saveResult))saveHandle;

/**
 *  Return a new detailViewController base on textview modal
 *
 *  @param title      ViewController title
 *  @param text       Textview default text
 *  @param saveHandle Save bar item action handle
 *
 *  @return New initialize detailviewcontroller
 */
-(instancetype)initTextInputViewWithTitle:(NSString *)title text:(NSString *)text saveHandle:(void(^)(NSString *saveResult))saveHandle;

/**
 *  Displaying a detailViewController on appoint viewcontroller
 *
 *  @param viewcontroller The viewcontroller for displaying
 */
-(void)detailViewShowOnViewController:(UIViewController *)viewcontroller;

@end
