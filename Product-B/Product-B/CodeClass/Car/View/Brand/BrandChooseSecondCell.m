//
//  BrandChooseSecondCell.m
//  Product-B
//
//  Created by super on 16/7/23.
//  Copyright © 2016年 wxl. All rights reserved.
//
#define W [UIScreen mainScreen].bounds.size.width
#define H [UIScreen mainScreen].bounds.size.height
#import "BrandChooseSecondCell.h"

@implementation BrandChooseSecondCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 100, 80)];
        [self.contentView addSubview:self.imageV];
        
        self.title = [[UILabel alloc]initWithFrame:CGRectMake(self.imageV.right + 10, self.imageV.top, W -self.imageV.right - 20, 40)];
        self.title.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:self.title];
        
        self.price = [[UILabel alloc]initWithFrame:CGRectMake(self.title.left, self.title.bottom, W - self.imageV.right - 20, 40)];
        self.price.font = [UIFont systemFontOfSize:14];
        self.price.textColor = [UIColor redColor];
        [self.contentView addSubview:self.price];
        
        self.downlabel = [[UILabel alloc]initWithFrame:CGRectMake(10, self.imageV.bottom + 10, W, 40)];
        self.downlabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:self.downlabel];
        
    }
    return self;
}
- (void)cellModel:(NSDictionary *)dic{
    
    
    
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"img"]]];
        self.title.text = [dic objectForKey:@"name"];
        self.price.text = [dic objectForKey:@"price"];
        self.downlabel.text = [NSString stringWithFormat:@"共%@款车型符合条件", [dic objectForKey:@"count"]];

}
@end
