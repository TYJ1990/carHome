//
//  LikeAndIntroduceTableViewCell.h
//  Product-B
//
//  Created by lanou on 16/7/20.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmallModel.h"

@interface LikeAndIntroduceTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *image1;
@property (strong, nonatomic) IBOutlet UIImageView *image2;
@property (strong, nonatomic) IBOutlet UIImageView *image3;
@property (strong, nonatomic) IBOutlet UIImageView *image4;
@property (strong, nonatomic) IBOutlet UILabel *adinfo1;
@property (strong, nonatomic) IBOutlet UILabel *adinfo2;
@property (strong, nonatomic) IBOutlet UILabel *adinfo3;
@property (strong, nonatomic) IBOutlet UILabel *adinfo4;
@property (strong, nonatomic) IBOutlet UILabel *title1;
@property (strong, nonatomic) IBOutlet UILabel *title2;
@property (strong, nonatomic) IBOutlet UILabel *title3;
@property (strong, nonatomic) IBOutlet UILabel *title4;
@property (strong, nonatomic) IBOutlet UILabel *price1;
@property (strong, nonatomic) IBOutlet UILabel *price2;
@property (strong, nonatomic) IBOutlet UILabel *price3;
@property (strong, nonatomic) IBOutlet UILabel *price4;
@property (strong, nonatomic) IBOutlet UILabel *fctprice1;
@property (strong, nonatomic) IBOutlet UILabel *fctprice12;
@property (strong, nonatomic) IBOutlet UILabel *fctprice13;
@property (strong, nonatomic) IBOutlet UILabel *fctprice14;

- (void)cellWithModel:(NSArray *)array;













@end
