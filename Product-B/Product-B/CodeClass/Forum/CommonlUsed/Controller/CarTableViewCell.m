//
//  CarTableViewCell.m
//  Product-B
//
//  Created by lanou on 16/7/19.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "CarTableViewCell.h"

@implementation CarTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)cellConfigureModel:(CarModel *)model {
    self.titleL.text = model.title;
    self.replyL.text = [NSString stringWithFormat:@"回复:%@", model.lastreplydate];
    self.nameL.text = [NSString stringWithFormat:@"%@  %@回", model.postusername, model.replycounts];
    if (model.jximgs.length != 0) {
        self.imageVA.hidden = NO;
        self.imageVB.hidden = NO;
        self.imageVC.hidden = NO;
        NSArray *arr = [model.jximgs componentsSeparatedByString:@","];
        [self.imageVA sd_setImageWithURL:[NSURL URLWithString:arr[0]] placeholderImage:[UIImage imageNamed:@"shipinbg.png"] completed:nil];
        [self.imageVB sd_setImageWithURL:[NSURL URLWithString:arr[1]] placeholderImage:[UIImage imageNamed:@"shipinbg.png"] completed:nil];
        [self.imageVC sd_setImageWithURL:[NSURL URLWithString:arr[2]] placeholderImage:[UIImage imageNamed:@"shipinbg.png"] completed:nil];
    } else {
        self.imageVA.hidden = YES;
        self.imageVB.hidden = YES;
        self.imageVC.hidden = YES;
    }
        if ([model.topictype isEqualToString:@"精"]) {
            self.jL.text = @"精";
            self.jL.textColor = [UIColor orangeColor];
            self.jL.layer.borderWidth = 1;
        } else if ([model.topictype isEqualToString:@"顶"]) {
            self.dL.text = @"顶";
            self.dL.textColor = [UIColor blueColor];
            self.dL.layer.borderWidth = 1;
        }
}

@end
