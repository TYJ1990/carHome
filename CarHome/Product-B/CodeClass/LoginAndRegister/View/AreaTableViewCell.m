//
//  AreaTableViewCell.m
//  Product-B
//
//  Created by lanou on 16/7/21.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "AreaTableViewCell.h"

@implementation AreaTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)cellConfigureModel:(AreaModel *)model {
    self.nameL.text = model.name;
    if (model.isSelect) {
        self.imageV.hidden = NO;
        self.nameL.textColor = self.contentView.tintColor;
    } else {
        self.imageV.hidden = YES;
        self.nameL.textColor = [UIColor blackColor];
    }
}

@end
