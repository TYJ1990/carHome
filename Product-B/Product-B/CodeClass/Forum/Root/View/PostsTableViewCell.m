//
//  PostsTableViewCell.m
//  Product-B
//
//  Created by lanou on 16/7/14.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "PostsTableViewCell.h"

@implementation PostsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (void)cellConfigureModel:(PostsModel *)model {
    self.titleL.text = model.title;
    self.placeAndDateL.text = [NSString stringWithFormat:@"%@ %@", model.bbsname, [model.postdate substringWithRange:NSMakeRange(6, 10)]];
    self.replyL.text = [NSString stringWithFormat:@"%@回帖", model.replycounts];
    
    if ([model.ispictopic integerValue] == 1) {
        self.imageV.hidden = NO;
    } else {
        self.imageV.hidden = YES;
    }
}

@end
