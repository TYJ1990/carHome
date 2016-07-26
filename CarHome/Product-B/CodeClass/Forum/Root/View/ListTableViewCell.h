//
//  ListTableViewCell.h
//  Product-B
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WonderfulModel.h"
@interface ListTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *columnL;
@property (strong, nonatomic) IBOutlet UIImageView *imageV;
- (void)cellConfigureModel:(WonderfulModel *)model;
@end
