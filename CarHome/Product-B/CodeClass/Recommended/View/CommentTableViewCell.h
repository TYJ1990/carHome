//
//  CommentTableViewCell.h
//  Product-B
//
//  Created by lanou on 16/7/16.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"

@interface CommentTableViewCell : UITableViewCell


@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UILabel *uname;
@property(nonatomic,strong)UILabel *carName;
@property(nonatomic,strong)UILabel *floor;
@property(nonatomic,strong)UILabel *content;
@property(nonatomic,strong)UIView *background;
@property(nonatomic,strong)UILabel *oldComment;
@property(nonatomic,strong)UILabel *oldConent;
@property(nonatomic,strong)UILabel *time;
@property(nonatomic,strong)UILabel *support;
@property(nonatomic,strong)UIButton *supportBtn;
@property(nonatomic,strong)UIButton *answer;
@property(nonatomic,strong)UIButton *answer2;


- (void)cellConfigureModel:(CommentModel *)model;



@end
