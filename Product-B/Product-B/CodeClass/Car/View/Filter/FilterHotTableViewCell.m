//
//  FilterHotTableViewCell.m
//  Product-B
//
//  Created by super on 16/7/16.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "FilterHotTableViewCell.h"

@implementation FilterHotTableViewCell
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
        
        
        self.hotL = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 30, 0, 20, 20)];
        [self.hotL setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"carremen"]]];
        
        //   [self.hotL sizeToFit];
        self.hotL.textAlignment = NSTextAlignmentCenter;
        self.hotL.textColor = [UIColor whiteColor];
        self.hotL.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:self.hotL];
    }
    return self;
}
- (void)cellModel:(FilterModel *)model{
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.thumburl]];
    self.titleL.text = model.seriesname;
    self.priceL.text = model.pricerange;
    self.hotL.text = model.cornericon;
    
}
- (void)BrandCarSecondDic:(NSDictionary *)dic{
    self.titleL.text = dic[@"name"];
    self.priceL.text = dic[@"price"];
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:dic[@"imgurl"]]];
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
