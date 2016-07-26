//
//  BrandMainSecondOneCell.h
//  Product-B
//
//  Created by super on 16/7/20.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BrandMainSecondOneButton.h"
#import "BrandMainSecondModel.h"

@interface BrandMainSecondOneCell : UITableViewCell
@property (nonatomic, strong)BrandMainSecondOneButton *button;
@property (nonatomic, strong)UILabel *label;
@property (nonatomic, strong)UILabel *label1;
- (void)cellModel:(BrandMainSecondModel *)model;
@end
