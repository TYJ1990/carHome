//
//  FilterTableViewCell.h
//  Product-B
//
//  Created by super on 16/7/14.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterModel.h"
@interface FilterTableViewCell : UITableViewCell
@property (nonatomic, strong)UIImageView *imageV;
@property (nonatomic, strong)UILabel *titleL;
@property (nonatomic, strong)UILabel *priceL;
- (void)cellModel:(FilterModel *)model;
@end
