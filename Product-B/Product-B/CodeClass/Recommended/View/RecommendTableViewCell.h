//
//  RecommendTableViewCell.h
//  Product-B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendModel.h"

@interface RecommendTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imageV;
@property (strong, nonatomic) IBOutlet UILabel *titleL;
@property (strong, nonatomic) IBOutlet UILabel *timeL;
@property (strong, nonatomic) IBOutlet UILabel *countL;
@property (strong, nonatomic) IBOutlet UILabel *barL;


- (void)cellWithModel:(RecommendModel *)model;
-(void)cellWithModel2:(RecommendModel *)model;
-(void)cellWithModel3:(RecommendModel *)model;
@end
