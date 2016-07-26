//
//  NewsflashTableViewCell.h
//  Product-B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendModel.h"

@interface NewsflashTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleL;
@property (strong, nonatomic) IBOutlet UILabel *barLabel;
@property (strong, nonatomic) IBOutlet UILabel *countL;
@property (strong, nonatomic) IBOutlet UILabel *timeL;
@property (strong, nonatomic) IBOutlet UIImageView *imageV;


- (void)cellWithModel:(RecommendModel *)model;



@end
