//
//  BrandTableViewCell.m
//  Product-B
//
//  Created by super on 16/7/13.
//  Copyright © 2016年 wxl. All rights reserved.
//
#define W [UIScreen mainScreen].bounds.size.width
#define H [UIScreen mainScreen].bounds.size.height
#import "BrandTableViewCell.h"

@implementation BrandTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        CustomButton *button = [[CustomButton alloc]initWithFrame:CGRectMake((W - 50*3)/4, 10, 50, 50)];
        [button image:@"carshoucang" title:@"我的收藏" imgurl:nil];
        [self.contentView addSubview:button];
        
        CustomButton *button1 = [[CustomButton alloc]initWithFrame:CGRectMake(button.frame.origin.x * 2 + 50, 10, 50, 50)];
        [button1 image:@"carlishi" title:@"浏览历史" imgurl:nil];
        [self.contentView addSubview:button1];
        
        CustomButton *button2 = [[CustomButton alloc]initWithFrame:CGRectMake(button.frame.origin.x * 3 + 50 * 2, 10, 50, 50)];
        [button2 image:@"carpaihang" title:@"热销排行" imgurl:nil];
        [self.contentView addSubview:button2];

    }
    return self;
}

@end
