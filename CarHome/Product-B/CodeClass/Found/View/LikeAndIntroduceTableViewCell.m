//
//  LikeAndIntroduceTableViewCell.m
//  Product-B
//
//  Created by lanou on 16/7/20.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "LikeAndIntroduceTableViewCell.h"

@implementation LikeAndIntroduceTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)cellWithModel:(NSArray *)array{
    for (int i = 0; i < 4 ; i++) {
        SmallModel *model = array[i];
        NSMutableAttributedString *attrubute = [[NSMutableAttributedString alloc]initWithString:model.fctprice];
        NSDictionary *attributeDict = @{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleThick)};
        [attrubute addAttributes:attributeDict range:NSMakeRange(0, model.fctprice.length)];
        if (i == 0) {
            [self.image1 sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:[UIImage imageNamed:@"shipinbg"]];
            self.title1.text = model.title;
            self.adinfo1.text = model.adinfo;
            self.price1.text = model.price;
            self.fctprice1.attributedText = attrubute;
        }else if(i == 1){
            [self.image2 sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:[UIImage imageNamed:@"shipinbg"]];
            self.title2.text = model.title;
            self.adinfo2.text = model.adinfo;
            self.price2.text = model.price;
            self.fctprice12.attributedText = attrubute;
        }else if (i == 2){
            [self.image3 sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:[UIImage imageNamed:@"shipinbg"]];
            self.title3.text = model.title;
            self.adinfo3.text = model.adinfo;
            self.price3.text = model.price;
            self.fctprice13.attributedText = attrubute;
        }else{
            [self.image4 sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:[UIImage imageNamed:@"shipinbg"]];
            self.title4.text = model.title;
            self.adinfo4.text = model.adinfo;
            self.price4.text = model.price;
            self.fctprice14.attributedText = attrubute;
        }
        
    }
}






@end
