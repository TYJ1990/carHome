//
//  PicTableViewCell.h
//  Product-B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendModel.h"

@interface PicTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleL;
@property (strong, nonatomic) IBOutlet UIImageView *imageV;
@property (strong, nonatomic) IBOutlet UIImageView *iamgeV2;
@property (strong, nonatomic) IBOutlet UIImageView *imaeV3;
@property (strong, nonatomic) IBOutlet UILabel *timeL;
@property (strong, nonatomic) IBOutlet UILabel *countl;

- (void)cellWithModel:(RecommendModel *)model;


@end
