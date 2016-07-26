//
//  AreaTableViewCell.h
//  Product-B
//
//  Created by lanou on 16/7/21.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AreaModel.h"
@interface AreaTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *nameL;
@property (strong, nonatomic) IBOutlet UIImageView *imageV;
- (void)cellConfigureModel:(AreaModel *)model;
@end
