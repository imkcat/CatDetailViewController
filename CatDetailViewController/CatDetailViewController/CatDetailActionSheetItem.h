//
//  CatDetailActionSheetItem.h
//  CatDetailViewController
//
//  Created by K-cat on 15/6/17.
//  Copyright (c) 2015年 K-cat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CatDetailActionSheetItem : NSObject

@property (nonatomic, copy) NSString *itemTitle;
@property (nonatomic, copy) void (^actionHandle)(CatDetailActionSheetItem *actionItem);

/**
 *  Init a new initialize item with title and action handle
 *
 *  @param title        Item title
 *  @param actionHandle Item action handle
 *
 *  @return New initialize item
 */
-(instancetype)initWithTitle:(NSString *)title actionHandle:(void (^)(CatDetailActionSheetItem *))actionHandle;

@end
