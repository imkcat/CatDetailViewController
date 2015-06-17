//
//  CatTableDetailViewController.h
//  Pettor Way
//
//  Created by K-cat on 15/6/12.
//  Copyright (c) 2015年 K-cat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CatDetailActionSheetItem.h"

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
 *  Return a new detailViewController base on alert modal
 *
 *  @param title                AlertView title
 *  @param message              AlertView message
 *  @param textfieldText        AlertView textfield text
 *  @param textfieldPlaceholder AlertView textfield placeholder
 *  @param cancelButtonTitle    AlertView cancel button title
 *  @param savelButtonTitle     AlertView save button title
 *  @param saveHandle           Save bar item action handle
 *
 *  @return New initialize detailviewcontroller
 */
-(instancetype)initEnterAlertViewWithTitle:(NSString *)title
                                   message:(NSString *)message
                             textfieldText:(NSString *)textfieldText
                      textfieldPlaceholder:(NSString *)textfieldPlaceholder
                              cancelButtonTitle:(NSString *)cancelButtonTitle
                              saveButtonTitle:(NSString *)savelButtonTitle
                                saveHandle:(void(^)(NSString *saveResult))saveHandle NS_AVAILABLE_IOS(8_0);


/**
 *  Return a new detailViewController base on action sheet modal
 *
 *  @param title           Action sheet title
 *  @param itemArray       Array contain action sheet item
 *  @param cancelItemTitle Text for action sheet cancel button
 *
 *  @return New initialize detailviewcontroller
 */
-(instancetype)initActionSheetWithTitle:(NSString *)title
                              itemArray:(NSArray *)itemArray
                        cancelItemTitle:(NSString *)cancelItemTitle;


/**
 *  Displaying a detailViewController on appoint viewcontroller
 *
 *  @param viewcontroller The viewcontroller for displaying
 */
-(void)detaiViewShowOnViewController:(UIViewController *)viewcontroller;

@end
