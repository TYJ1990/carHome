//
//  BrandChooseSecondCell.h
//  Product-B
//
//  Created by super on 16/7/23.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BrandChooseSecondModel.h"

@interface BrandChooseSecondCell : UITableViewCell
@property (nonatomic, strong)UIImageView *imageV;
@property (nonatomic, strong)UILabel *title;
@property (nonatomic, strong)UILabel *price;
@property (nonatomic, strong)UILabel *downlabel;
- (void)cellModel:(NSDictionary *)dic;
@end
