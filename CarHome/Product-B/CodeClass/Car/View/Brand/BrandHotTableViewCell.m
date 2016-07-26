//
//  BrandHotTableViewCell.m
//  Product-B
//
//  Created by super on 16/7/13.
//  Copyright © 2016年 wxl. All rights reserved.
//
#define W [UIScreen mainScreen].bounds.size.width - 10
#define H [UIScreen mainScreen].bounds.size.height
#import "BrandHotTableViewCell.h"

@implementation BrandHotTableViewCell

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

        for (int i = 0; i < 2; i++) {
            for (int j = 0; j < 5; j++) {
                self.button = [[CustomButton alloc]initWithFrame:CGRectMake((W - 50*5)/6 + j * ((W - 50*5)/6 + 50),10 + i * (50 + 10), 50, 50)];
//                self.button.backgroundColor = [UIColor redColor];
                self.button.tag = j + i * 5 + 1;
                
                [self.contentView addSubview:self.button];
            }
        }
        
        
    }
    return self;
}
- (void)cellModelArray:(NSMutableArray *)modelArray{

    for (int i = 0; i < modelArray.count; i++) {
        BrandHotModel *model = modelArray[i];
        self.button = [self.contentView viewWithTag:i + 1];
        [self.button image:nil title:model.name imgurl:model.img];
    }
}


@end
