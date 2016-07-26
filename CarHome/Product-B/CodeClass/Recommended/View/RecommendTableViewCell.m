//
//  RecommendTableViewCell.m
//  Product-B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "RecommendTableViewCell.h"

@implementation RecommendTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)cellWithModel:(RecommendModel *)model{
    if (model.smallpic) {
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.smallpic] placeholderImage:[UIImage imageNamed:@"shipinbg"]];
    } else{
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.smallimg] placeholderImage:[UIImage imageNamed:@"shipinbg"]];
    }
    self.titleL.text = model.title;
    self.timeL.text = model.time;
    if (model.skisfirst) {
        self.barL.text = @"首发";
        [self.barL.layer setBorderWidth:0.5];
        [self.barL.layer setBorderColor:[UIColor greenColor].CGColor];
    }
    if ([model.mediatype integerValue] == 1 || [model.mediatype integerValue] == 0 || model.lastid != nil || [model.mediatype integerValue] > 9) {
        self.countL.text = [NSString stringWithFormat:@"%@评论",model.replycount];
    } else if ([model.mediatype integerValue] == 3) {
        self.countL.text = [NSString stringWithFormat:@"%@播放",model.replycount];
    } else if ([model.mediatype integerValue] == 5){
        self.countL.text = [NSString stringWithFormat:@"%@回帖",model.replycount];
    }else{
        self.countL.text = [NSString stringWithFormat:@"%@",model.replycount];
    }
    if (!model.mediatype) {
        self.countL.text = [NSString stringWithFormat:@"%@播放",model.playcount];
    }
}


-(void)cellWithModel2:(RecommendModel *)model{
    if (model.skisfirst) {
        self.barL.text = @"首发";
        [self.barL.layer setBorderWidth:0.5];
        [self.barL.layer setBorderColor:[UIColor greenColor].CGColor];
    }
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.smallpic] placeholderImage:[UIImage imageNamed:@"shipinbg"]];
    self.titleL.text = model.title;
    self.timeL.text = model.time;
}

-(void)cellWithModel3:(RecommendModel *)model{
    if (model.skisfirst) {
        self.barL.text = @"首发";
        [self.barL.layer setBorderWidth:0.5];
        [self.barL.layer setBorderColor:[UIColor greenColor].CGColor];
    }
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.smallpic] placeholderImage:[UIImage imageNamed:@"shipinbg"]];
    self.titleL.text = model.title;
    self.timeL.text = model.time;
    self.countL.text = [NSString stringWithFormat:@"%@评论",model.replycount];
}





@end
