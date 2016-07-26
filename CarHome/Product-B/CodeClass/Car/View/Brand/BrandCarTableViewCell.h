//
//  BrandCarTableViewCell.h
//  Product-B
//
//  Created by super on 16/7/13.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BrandCarModel.h"
@interface BrandCarTableViewCell : UITableViewCell
@property (nonatomic, strong)UIImageView *imageV;
@property (nonatomic, strong)UILabel *label;
- (void)cellDic:(NSDictionary *)dic;
@end
