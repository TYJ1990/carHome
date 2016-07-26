//
//  VideoTableViewCell.h
//  Product-B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendModel.h"
#import "videoView.h"

@interface VideoTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *iconImageV;
@property (strong, nonatomic) IBOutlet UILabel *titleL;
@property (strong, nonatomic) IBOutlet UIImageView *titleImageV;
@property (strong, nonatomic) IBOutlet UILabel *contentL;
@property (strong, nonatomic) IBOutlet UILabel *titmeL;
@property (strong, nonatomic) IBOutlet UIButton *supportBtn;
@property (strong, nonatomic) IBOutlet UIButton *commentBtn;
@property (strong, nonatomic) IBOutlet UILabel *supportL;
@property (strong, nonatomic) IBOutlet UILabel *commentL;
@property (strong, nonatomic) IBOutlet UIImageView *barImageV;

@property(nonatomic,strong)videoView *vieoView;

- (void)cellWithModel:(RecommendModel *)model;


@end
