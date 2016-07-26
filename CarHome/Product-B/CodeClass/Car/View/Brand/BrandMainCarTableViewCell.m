//
//  BrandMainCarTableViewCell.m
//  Product-B
//
//  Created by super on 16/7/13.
//  Copyright © 2016年 wxl. All rights reserved.
//
#define W ([UIScreen mainScreen].bounds.size.width - 10)
#define H [UIScreen mainScreen].bounds.size.height
#import "BrandMainCarTableViewCell.h"
@implementation BrandMainCarTableViewCell

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

        
        for (int i = 0; i < 3; i++) {
            CustomButton *button = [[CustomButton alloc]initWithFrame:CGRectMake(i * W / 3, 10, W / 3, W/3/5*4)];
            button.tag = i + 1;
        
            [self.contentView addSubview:button];
        }
    }
    return self;
}
- (void)cellModel:(NSMutableArray *)modelArray{
    for (int i = 0; i < modelArray.count; i++) {
        BrandMainModel *model = modelArray[i];
        CustomButton *button = [self.contentView viewWithTag:i + 1];
        [button image:nil title:model.seriesname imgurl:model.img];
    }
}
@end
