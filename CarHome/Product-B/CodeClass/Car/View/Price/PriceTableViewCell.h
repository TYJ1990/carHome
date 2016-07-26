//
//  PriceTableViewCell.h
//  Product-B
//
//  Created by super on 16/7/14.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PriceModel.h"
@interface PriceTableViewCell : UITableViewCell
@property (nonatomic, strong)UIImageView *imageV;
@property (nonatomic, strong)UILabel *title;
@property (nonatomic, strong)UILabel *dealerprice;
@property (nonatomic, strong)UILabel *fctprice;
@property (nonatomic, strong)UILabel *upprice;
@property (nonatomic, strong)UILabel *city;
@property (nonatomic, strong)UILabel *shortname;
@property (nonatomic, strong)UILabel *distance;
@property (nonatomic, strong)UILabel *orderrange;
@property (nonatomic, strong)UIButton *calculate;
@property (nonatomic, strong)UIButton *phone;
@property (nonatomic, strong)UIButton *floorprice;
- (void)cellModel:(PriceModel *)model;
@end
