//
//  WonContentTableViewCell.h
//  Product-B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WonContentModel.h"
@interface WonContentTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imageV;
@property (strong, nonatomic) IBOutlet UILabel *titleL;
@property (strong, nonatomic) IBOutlet UILabel *bbsnameL;
@property (strong, nonatomic) IBOutlet UILabel *replyL;

- (void)cellConfigureModel:(WonContentModel *)model;

@end
