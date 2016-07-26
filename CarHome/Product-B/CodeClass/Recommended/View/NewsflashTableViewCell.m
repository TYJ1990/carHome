//
//  NewsflashTableViewCell.m
//  Product-B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "NewsflashTableViewCell.h"

@implementation NewsflashTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)cellWithModel:(RecommendModel *)model{
    self.titleL.text = model.title;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"shipinbg"]];
    self.barLabel.text = @"播报结束";
    self.barLabel.tintColor = [UIColor lightGrayColor];
//    [self.barLabel.layer setBorderWidth:1];
    self.countL.text = [NSString stringWithFormat:@"%@人浏览",model.reviewcount];
    self.timeL.text = model.createtime;
}





@end
