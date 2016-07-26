//
//  CommentTableViewCell.m
//  Product-B
//
//  Created by lanou on 16/7/16.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "CommentTableViewCell.h"

@implementation CommentTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.icon = [[UIImageView alloc] init];
        self.icon.layer.masksToBounds = YES;
        self.icon.layer.cornerRadius = 15;
        self.icon.image = [UIImage imageNamed:@"头像"];
        [self.contentView addSubview:self.icon];
        
        self.uname = [[UILabel alloc] init];
        self.uname.font = [UIFont systemFontOfSize:14.0];
        self.uname.textColor = self.contentView.tintColor;
        [self.contentView addSubview:self.uname];
        
        self.carName = [[UILabel alloc] init];
        self.carName.font = [UIFont systemFontOfSize:12.0];
        self.carName.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.carName];
        
        self.floor = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 60, 24, 50, 12)];
        self.floor.font = [UIFont systemFontOfSize:12.0];
        self.floor.textColor = [UIColor lightGrayColor];
        self.floor.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.floor];
        
        self.content = [[UILabel alloc] init];
        self.content.font = [UIFont systemFontOfSize:17.0];
        self.content.numberOfLines = 0;
        [self.content sizeToFit];
        [self.contentView addSubview:self.content];
        
        self.background = [[UIView alloc] init];
        self.background.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
        [self.contentView addSubview:self.background];
        
        self.oldComment = [[UILabel alloc] init];
        self.oldComment.font = [UIFont systemFontOfSize:12.0];
        self.oldComment.textColor = [UIColor lightGrayColor];
        [self.background addSubview:self.oldComment];
        
        self.oldConent = [[UILabel alloc] init];
        self.oldConent.font = [UIFont systemFontOfSize:14.0];
        self.oldConent.numberOfLines = 0;
        self.oldConent.textColor = [UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1];
        [self.background addSubview:self.oldConent];
        
        self.time = [[UILabel alloc] init];
        self.time.font = [UIFont systemFontOfSize:13.0];
        self.time.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.time];
        
        self.supportBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [self.supportBtn setImage:[UIImage imageNamed:@"点赞"] forState:(UIControlStateNormal)];
        [self.contentView addSubview:self.supportBtn];
        
        self.support = [[UILabel alloc] init];
        self.support.font = [UIFont systemFontOfSize:12.0];
        self.support.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.support];
        
        self.answer = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [self.answer setImage:[UIImage imageNamed:@"评论"] forState:(UIControlStateNormal)];
//        self.answer.imageEdgeInsets = UIEdgeInsetsMake(0, self.answer.frame.size.width - 10, 0, 0);
//         self.answer.titleEdgeInsets = UIEdgeInsetsMake(0, - 30, 0, 0);
        [self.contentView addSubview:self.answer];
        
        self.answer2 = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [self.answer2 setTitle:@"回复" forState:(UIControlStateNormal)];
        self.answer2.titleLabel.font = [UIFont systemFontOfSize:13.0];
        [self.contentView addSubview:self.answer2];
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    self.answer2.frame = CGRectMake(self.answer.right, self.answer.top, 27, 13);
    
}



- (void)cellConfigureModel:(CommentModel *)model{
    if (model.namepic.length < 1) {
        self.icon.image = [UIImage imageNamed:@"头像"];
    } else{
        [self.icon sd_setImageWithURL:[NSURL URLWithString:model.namepic] placeholderImage:[UIImage imageNamed:@"shipinbg"]];
    }
    self.uname.text = model.name;
    self.carName.text = model.carname;
    self.floor.text = [NSString stringWithFormat:@"%@",model.floor];
    self.content.text = model.content;
    self.oldComment.text = [NSString stringWithFormat:@"▎原评论: %@",model.sourcename];
    self.oldConent.text = model.sourcecontent;
    self.time.text = model.time;
    self.support.text = [NSString stringWithFormat:@"%@",model.upcount];
    self.icon.frame = CGRectMake(10, 15, 30, 30);
    self.uname.frame = CGRectMake(self.icon.right + 5, 23, 0, 14);
    [self.uname sizeToFit];
    self.carName.frame = CGRectMake(self.uname.right + 2, 24, 0, 12);
    [self.carName sizeToFit];
    self.content.frame = CGRectMake(self.icon.right + 5, self.icon.bottom + 10, kScreenWidth - 20 - self.icon.right - 5, 0);
    [self.content sizeToFit];
    self.oldComment.frame = CGRectMake(10, 15, 0, 13);
    [self.oldComment sizeToFit];
    self.oldConent.frame = CGRectMake(10, self.oldComment.bottom + 10, kScreenWidth - self.content.left - 10 - 40, 0);
    [self.oldConent sizeToFit];
    if (model.sourcecontent.length < 1) {
        self.background.hidden = YES;
        self.time.frame = CGRectMake(self.content.left, self.content.bottom + 20, 60, 12);
        self.supportBtn.frame = CGRectMake(kScreenWidth*2/3.0, self.time.top, 13, 13);
        self.support.frame = CGRectMake(self.supportBtn.right +3, self.supportBtn.top+2, 12, 12);
        self.answer.frame = CGRectMake(kScreenWidth- 60, self.supportBtn.top, 13, 13);
    } else{
        self.background.hidden = NO;
        self.background.frame = CGRectMake(self.content.left, self.content.bottom + 10, kScreenWidth - self.content.left - 10, self.oldConent.height + self.oldComment.height + 40);
        self.time.frame = CGRectMake(self.content.left, self.background.bottom + 20, 60, 12);
        self.supportBtn.frame = CGRectMake(kScreenWidth*2/3.0, self.time.top, 13, 13);
        self.support.frame = CGRectMake(self.supportBtn.right+3, self.supportBtn.top+2, 12, 12);
        self.answer.frame = CGRectMake(kScreenWidth- 60, self.supportBtn.top, 13, 13);
    }
}





@end
