//
//  CommonTableViewCell.h
//  Product-B
//
//  Created by lanou on 16/7/16.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonModel.h"
@interface CommonTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imageV;
@property (strong, nonatomic) IBOutlet UILabel *bbsnameL;
@property (strong, nonatomic) IBOutlet UILabel *introduceL;

- (void)cellConfigureModel:(CommonModel *)model;

@end
