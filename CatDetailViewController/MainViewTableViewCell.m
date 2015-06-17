//
//  MainViewTableViewCell.m
//  CatDetailViewController
//
//  Created by K-cat on 15/6/12.
//  Copyright (c) 2015年 K-cat. All rights reserved.
//

#import "MainViewTableViewCell.h"

@implementation MainViewTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

/**
 *  Load cell with special indexpath
 *
 *  @param indexPath Special indepath
 */
-(void)loadCellWithIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            switch (indexPath.row) {
                case 0:
                    [self.textLabel setText:@"Single Section"];
                    break;
                case 1:
                    [self.textLabel setText:@"TextField Enter"];
                    break;
                case 2:
                    [self.textLabel setText:@"DatePicker"];
                    break;
                case 3:
                    [self.textLabel setText:@"AlertController"];
                    break;
                case 4:
                    [self.textLabel setText:@"AlertSheet"];
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
