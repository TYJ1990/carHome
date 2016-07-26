//
//  BrandMainSecondSixCell.h
//  Product-B
//
//  Created by super on 16/7/22.
//  Copyright © 2016年 wxl. All rights reserved.
//
#define W [UIScreen mainScreen].bounds.size.width
#define H [UIScreen mainScreen].bounds.size.height
#import <UIKit/UIKit.h>
#import "BrandMainSecondSixButton.h"
#import "BrandMainSecondRecommendModel.h"
@interface BrandMainSecondSixCell : UITableViewCell
@property (nonatomic, strong)BrandMainSecondSixButton *button;
@property (nonatomic, strong)UILabel *titleLabel;
- (void)cellModelArray:(NSMutableArray *)modelArray;
@end
