//
//  AlbumDetailTableViewCell.h
//  Product-B
//
//  Created by lanou on 16/7/23.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlbumDetailModel.h"

@interface AlbumDetailTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *countL;
@property (strong, nonatomic) IBOutlet UILabel *time;
@property (strong, nonatomic) IBOutlet UILabel *byte;
@property (strong, nonatomic) IBOutlet UIButton *downLoad;
@property (strong, nonatomic) IBOutlet UILabel *downloadL;



- (void)cellWithDetailModel:(AlbumDetailModel *)model;




@end
