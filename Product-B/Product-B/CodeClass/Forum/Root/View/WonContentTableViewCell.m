//
//  WonContentTableViewCell.m
//  Product-B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "WonContentTableViewCell.h"

@implementation WonContentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)cellConfigureModel:(WonContentModel *)model {
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.smallpic] placeholderImage:kImage completed:nil];
    self.titleL.text = model.title;
    self.bbsnameL.text = model.bbsname;
    self.replyL.text = [NSString stringWithFormat:@"%@回", model.replycounts];
}

@end
