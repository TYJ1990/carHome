//
//  UsedCarTableViewCell.m
//  Product-B
//
//  Created by super on 16/7/15.
//  Copyright © 2016年 wxl. All rights reserved.
//
#define W [UIScreen mainScreen].bounds.size.width
#define H [UIScreen mainScreen].bounds.size.height
#import "UsedCarTableViewCell.h"

@implementation UsedCarTableViewCell

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
        self.imagev = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 100, 80)];
        [self.contentView addSubview:self.imagev];
        
        self.titleL = [[UILabel alloc]initWithFrame:CGRectMake(120, 10, W - 120 - 10, 40)];
        [self.contentView addSubview:self.titleL];
        
        self.yearL = [[UILabel alloc]initWithFrame:CGRectMake(120, 40, 200, 20)];
        [self.contentView addSubview:self.yearL];
        
        self.priceL = [[UILabel alloc]initWithFrame:CGRectMake(120, 60, 200, 20)];
        [self.contentView addSubview:self.priceL];
    }
    return self;
}
- (void)cellModel:(UsedCarModel *)model{
    
}

@end
