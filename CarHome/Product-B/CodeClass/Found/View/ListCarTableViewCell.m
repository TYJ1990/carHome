//
//  ListCarTableViewCell.m
//  Product-B
//
//  Created by lanou on 16/7/20.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "ListCarTableViewCell.h"

@implementation ListCarTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)cellWithModel:(SmallModel *)model{
    
    [self.image sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:[UIImage imageNamed:@"shipinbg"]];
    self.title.text = model.title;
    self.adinfo.text = model.adinfo;
    self.price.text = model.price;
    // 设置label文本多种属性 Attributes
    NSMutableAttributedString *attrubute = [[NSMutableAttributedString alloc]initWithString:model.fctprice];
    
    // 批量设置文本属性 字典形式 大小  颜色  删除线
    NSDictionary *attributeDict = @{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleThick)};
    [attrubute addAttributes:attributeDict range:NSMakeRange(0, model.fctprice.length)];
    self.fctprice.attributedText = attrubute;
    
    
}




@end
