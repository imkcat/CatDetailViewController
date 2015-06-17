//
//  CatDetailActionSheetItem.m
//  CatDetailViewController
//
//  Created by K-cat on 15/6/17.
//  Copyright (c) 2015年 K-cat. All rights reserved.
//

#import "CatDetailActionSheetItem.h"

@implementation CatDetailActionSheetItem

-(instancetype)init{
    self=[super init];
    if (self) {
        self.itemTitle=@"No title";
        self.actionHandle=nil;
    }
    return self;
}

-(instancetype)initWithTitle:(NSString *)title actionHandle:(void (^)(CatDetailActionSheetItem *))actionHandle{
    self=[super init];
    if (self) {
        self.itemTitle=title;
        self.actionHandle=actionHandle;
    }
    return self;
}

@end
