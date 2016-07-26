//
//  PicTableViewCell.m
//  Product-B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 wxl. All rights reserved.
//
//http://www3.autoimg.cn/newsdfs/g9/M0F/C5/52/400x300_0_autohomecar__wKgH31d9zsKAef22AACOyfxnv5A835.jpg㊣http://www2.autoimg.cn/newsdfs/g9/M13/C4/C7/400x300_0_autohomecar__wKgH0Fd9zsaAJ-c4AACCIB2XaMo338.jpg㊣http://www2.autoimg.cn/newsdfs/g9/M05/BB/75/400x300_0_autohomecar__wKjBzld9zsqAMG-kAABI3Ace8Rs870.jpg
#import "PicTableViewCell.h"

@implementation PicTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)cellWithModel:(RecommendModel *)model{
    self.titleL.text = model.title;
    NSArray *arr = [model.indexdetail componentsSeparatedByString:@","];
    NSArray *arr2 = [model.indexdetail componentsSeparatedByString:@"㊣"];
    if (arr.count < 2) {
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:arr2[0]] placeholderImage:[UIImage imageNamed:@"shipinbg"]];
        [self.iamgeV2 sd_setImageWithURL:[NSURL URLWithString:arr2[1]] placeholderImage:[UIImage imageNamed:@"shipinbg"]];
        [self.imaeV3 sd_setImageWithURL:[NSURL URLWithString:arr2[2]] placeholderImage:[UIImage imageNamed:@"shipinbg"] ];
    }else{
        
        NSString *url1 = [arr[0] substringFromIndex:10];
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:url1] placeholderImage:[UIImage imageNamed:@"shipinbg"]];
        [self.iamgeV2 sd_setImageWithURL:[NSURL URLWithString:arr[1]] placeholderImage:[UIImage imageNamed:@"shipinbg"]];
        [self.imaeV3 sd_setImageWithURL:[NSURL URLWithString:arr[2]] placeholderImage:[UIImage imageNamed:@"shipinbg"]];
    }
    self.timeL.text = model.time;
    self.countl.text = [NSString stringWithFormat:@"%@图片",model.replycount];
}



@end
