//
//  ListTableViewCell.m
//  Product-B
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "ListTableViewCell.h"

@implementation ListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)cellConfigureModel:(WonderfulModel *)model {
    self.columnL.text = model.name;
    if (model.isSelect) {
        self.columnL.textColor = self.contentView.tintColor;
        self.imageV.hidden = NO;
    } else {
        self.columnL.textColor = [UIColor grayColor];
        self.imageV.hidden = YES;
    }
    
    
    
}

@end
