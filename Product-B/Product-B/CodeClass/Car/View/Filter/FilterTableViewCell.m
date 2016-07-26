//
//  FilterTableViewCell.m
//  Product-B
//
//  Created by super on 16/7/14.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "FilterTableViewCell.h"

@implementation FilterTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 80, 60)];
        [self.contentView addSubview:self.imageV];
        
        self.titleL = [[UILabel alloc]initWithFrame:CGRectMake(100, 10, 200, 30)];
        [self.contentView addSubview:self.titleL];
        
        self.priceL = [[UILabel alloc]initWithFrame:CGRectMake(100, 40, 200, 30)];
        self.priceL.textColor = [UIColor redColor];
        self.priceL.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:self.priceL];
        
    }
    return self;
}
- (void)cellModel:(FilterModel *)model{
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.thumburl]];
    self.titleL.text = model.seriesname;
    self.priceL.text = model.pricerange;
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
