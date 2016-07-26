//
//  ComListTableViewCell.h
//  Product-B
//
//  Created by lanou on 16/7/17.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarsModel.h"
#import "RTModel.h"
@interface ComListTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *bbsnameL;

- (void)cellConfigureCarsModel:(CarsModel *)model;
- (void)cellConfigureRTModel:(RTModel *)model;
//- (void)cellConfigureThemeModel:(RTModel *)model;

@end
