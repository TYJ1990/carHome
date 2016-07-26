//
//  CarTableViewCell.h
//  Product-B
//
//  Created by lanou on 16/7/19.
//  Copyright © 2016年 wxl. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import "CarModel.h"
@interface CarTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleL;
@property (strong, nonatomic) IBOutlet UIImageView *imageVA;
@property (strong, nonatomic) IBOutlet UIImageView *imageVB;
@property (strong, nonatomic) IBOutlet UIImageView *imageVC;
@property (strong, nonatomic) IBOutlet UILabel *replyL;
@property (strong, nonatomic) IBOutlet UILabel *jL;
@property (strong, nonatomic) IBOutlet UILabel *dL;
@property (strong, nonatomic) IBOutlet UILabel *nameL;

- (void)cellConfigureModel:(CarModel *)model;

@end
