//
//  LiveListTableViewCell.h
//  Product-B
//
//  Created by lanou on 16/7/24.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveModel.h"


@interface LiveListTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *album;
@property (strong, nonatomic) IBOutlet UILabel *time;
@property (strong, nonatomic) IBOutlet UIButton *appointment;
@property (strong, nonatomic) IBOutlet UILabel *play;


- (void)cellWithDetailModel:(LiveModel *)model;



@end
