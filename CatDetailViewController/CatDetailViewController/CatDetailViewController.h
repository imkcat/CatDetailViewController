//
//  CatTableDetailViewController.h
//  Pettor Way
//
//  Created by K-cat on 15/6/12.
//  Copyright (c) 2015年 K-cat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CatDetailViewController : UIViewController

-(instancetype)initSingleSectionViewWithTitle:(NSString *)title
                                     sections:(NSArray *)sections
                            defaultSectionText:(NSString *)defaultSectionText
                                   saveHandle:(void(^)(NSString *saveResult))saveHandle;

-(instancetype)initTextFieldEnterViewWithTitle:(NSString *)title
                          textFieldDefaultText:(NSString *)textFieldDefaultText
                            textFieldPlaceholderText:(NSString *)textFieldPlaceholderText
                         textFieldKeyboardType:(UIKeyboardType)textFieldKeyboardType
                                    saveHandle:(void(^)(NSString *saveResult))saveHandle;

//-(instancetype)initDatePickerViewWithTitle:(NSString *)title
//                     datePickerDefaultDate:(NSDate *)datePickerDefaultDate
//                            datePickerMode:(UIDatePickerMode)datePickerMode
//                                saveHandle:(void(^)(NSString *saveResult))saveHandle;

@end
