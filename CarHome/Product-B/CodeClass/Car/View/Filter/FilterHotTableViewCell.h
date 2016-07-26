//
//  FilterHotTableViewCell.h
//  Product-B
//
//  Created by super on 16/7/16.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterModel.h"
#import "BrandCarSecondModel.h"
@interface FilterHotTableViewCell : UITableViewCell
@property (nonatomic, strong)UIImageView *imageV;
@property (nonatomic, strong)UILabel *titleL;
@property (nonatomic, strong)UILabel *priceL;
@property (nonatomic, strong)UILabel *hotL;
- (void)cellModel:(FilterModel *)model;
- (void)BrandCarSecondDic:(NSDictionary *)dic;

@end
