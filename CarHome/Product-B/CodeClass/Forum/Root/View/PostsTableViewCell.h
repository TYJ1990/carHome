//
//  PostsTableViewCell.h
//  Product-B
//
//  Created by lanou on 16/7/14.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostsModel.h"
@interface PostsTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleL;
@property (strong, nonatomic) IBOutlet UILabel *placeAndDateL;
@property (strong, nonatomic) IBOutlet UILabel *replyL;
@property (strong, nonatomic) IBOutlet UIImageView *imageV;


- (void)cellConfigureModel:(PostsModel *)model;

@end
