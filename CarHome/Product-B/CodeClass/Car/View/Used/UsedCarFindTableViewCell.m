//
//  UsedCarFindTableViewCell.m
//  Product-B
//
//  Created by super on 16/7/15.
//  Copyright © 2016年 wxl. All rights reserved.
//
#define W [UIScreen mainScreen].bounds.size.width
#define H [UIScreen mainScreen].bounds.size.height
#import "UsedCarFindTableViewCell.h"

@implementation UsedCarFindTableViewCell

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
        NSArray *array = @[@"0-3万",@"3-5万",@"5-10万",@"10-15万",@"大众",@"宝马",@"奔驰",@"丰田",@"奥迪",@"本田",@"别克",@"福特",@"1年内",@"1-3年",@"3-5年",@"5-8年"];
        
        for (int i = 0; i < 4; i++) {
            for (int j = 0; j < 4; j++) {
                self.button = [[UIButton alloc]initWithFrame:CGRectMake(0 + ((W - 3)/4 + 1) * j, 0 + 40 * i + i, (W - 3)/4, 40)];
                [self.button setTitle:array[i * 4 + j] forState:(UIControlStateNormal)];
                [self.button setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
                [self.contentView addSubview:self.button];
            }
        }
    }
    return self;
}
@end
