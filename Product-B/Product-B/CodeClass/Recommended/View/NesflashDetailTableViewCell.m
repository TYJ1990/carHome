//
//  NesflashDetailTableViewCell.m
//  Product-B
//
//  Created by lanou on 16/7/17.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "NesflashDetailTableViewCell.h"

@implementation NesflashDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
//    self.contentView.layer.borderColor
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}


- (void)cellWithNewsflashModel:(NewsflashModel *)model{
    self.headimg.userInteractionEnabled = YES;
    self.authorname.userInteractionEnabled = YES;
    [self.headimg sd_setImageWithURL:[NSURL URLWithString:model.headimg]];
    self.authorname.text = model.authorname;
    self.timeL.text = model.publishtime;
    self.contentL.text = model.content;
    self.Support.text = [NSString stringWithFormat:@"%@",model.replycount];
    self.commentL.text = [NSString stringWithFormat:@"%@",model.upcount];
    [self.Cheadimg sd_setImageWithURL:[NSURL URLWithString:model.headimg1] placeholderImage:[UIImage imageNamed:@"shipinbg"] ];
    [self.headimg2 sd_setImageWithURL:[NSURL URLWithString:model.headimg2] placeholderImage:[UIImage imageNamed:@"shipinbg"]];
    [self.headimg3 sd_setImageWithURL:[NSURL URLWithString:model.headimg3] placeholderImage:[UIImage imageNamed:@"shipinbg"]];
    if (model.headimg1.length < 1) {
        self.Cheadimg.image = [UIImage imageNamed:@"头像"];
    }
    if (model.headimg2.length < 1) {
        self.headimg2.image = [UIImage imageNamed:@"头像"];
    }
    if (model.headimg3.length < 1) {
        self.headimg3.image = [UIImage imageNamed:@"头像"];
    }
    self.username.text = model.username1;
    self.username2.text = model.username2;
    self.username3.text = model.username3;
    self.Ccontent.text = model.content1;
    self.ccomment2.text = model.content2;
    self.Ccomment3.text = model.content3;
    for (UIView *view in self.image.subviews) {
        [view removeFromSuperview];
    }
    [self getImagesWithArray:model.attachments view:self.image];
}

- (void)getImagesWithArray:(NSArray *)array view:(UIView *)view{
    for (int i = 0; i < array.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(-10, i * (kScreenWidth*5/7.0 + 10), kScreenWidth - 20, kScreenWidth*5/7.0)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:array[i][@"picurl"]] placeholderImage:[UIImage imageNamed:@"shipinbg"]];
        [view addSubview:imageView];
    }
}




@end
