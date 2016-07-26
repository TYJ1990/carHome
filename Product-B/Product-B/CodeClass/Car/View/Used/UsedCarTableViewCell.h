//
//  UsedCarTableViewCell.h
//  Product-B
//
//  Created by super on 16/7/15.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UsedCarModel.h"
@interface UsedCarTableViewCell : UITableViewCell
@property (nonatomic, strong)UIImageView *imagev;
@property (nonatomic, strong)UILabel *titleL;
@property (nonatomic, strong)UILabel *yearL;
@property (nonatomic, strong)UILabel *priceL;
- (void)cellModel:(UsedCarModel *)model;
@end
