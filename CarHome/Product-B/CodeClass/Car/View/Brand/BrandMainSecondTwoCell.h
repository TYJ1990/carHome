//
//  BrandMainSecondTwoCell.h
//  Product-B
//
//  Created by super on 16/7/21.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BrandMainSecondModel.h"
@interface BrandMainSecondTwoCell : UITableViewCell
- (void)cellModel:(BrandMainSecondModel *)model;
@property (nonatomic, strong)UILabel *uplabel;
@property (nonatomic, strong)UIView *grayview;
@property (nonatomic, strong)UILabel *titleL;
@property (nonatomic, strong)UILabel *label1;
@property (nonatomic, strong)UILabel *label2;
@property (nonatomic, strong)UILabel *label3;
@property (nonatomic, strong)UIButton *number;
@property (nonatomic, strong)UIButton *signUp;
@end
