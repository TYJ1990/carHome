//
//  CommonTableViewCell.m
//  Product-B
//
//  Created by lanou on 16/7/16.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "CommonTableViewCell.h"

@implementation CommonTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)cellConfigureModel:(CommonModel *)model {
    self.imageV.image = [UIImage imageNamed:model.image];
    self.bbsnameL.text = model.bbsname;
    self.introduceL.text = model.introduce;
}

@end
