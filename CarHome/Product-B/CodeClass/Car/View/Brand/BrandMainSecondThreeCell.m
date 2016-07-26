//
//  BrandMainSecondThreeCell.m
//  Product-B
//
//  Created by super on 16/7/21.
//  Copyright © 2016年 wxl. All rights reserved.
//
#define W [UIScreen mainScreen].bounds.size.width
#define H [UIScreen mainScreen].bounds.size.height
#import "BrandMainSecondThreeCell.h"

@implementation BrandMainSecondThreeCell

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
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        
        self.titleL = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 300, 20)];
        self.titleL.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.titleL];
        
        self.label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, self.titleL.bottom + 10, 150, 10)];
        self.label1.textColor = [UIColor colorWithRed:100.0/255.0 green:149.0/255 blue:208.0/255.0 alpha:1];
        self.label1.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.label1];
        
        self.label2 = [[UILabel alloc]initWithFrame:CGRectMake(170, self.titleL.bottom + 10, 60, 10)];
        self.label2.textColor = [UIColor colorWithRed:100.0/255.0 green:149.0/255 blue:208.0/255.0 alpha:1];
        self.label2.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.label2];
        
        self.label3 = [[UILabel alloc]initWithFrame:CGRectMake(240, self.titleL.bottom + 10, 50, 10)];
        self.label3.textColor = [UIColor colorWithRed:100.0/255.0 green:149.0/255 blue:208.0/255.0 alpha:1];
        self.label3.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.label3];
        
        self.number = [[UIButton alloc]initWithFrame:CGRectMake(0, self.label3.bottom + 10, W/2, 40)];
        [self.number setTitleColor:[UIColor colorWithRed:100.0/255.0 green:149.0/255 blue:208.0/255.0 alpha:1] forState:(UIControlStateNormal)];
//        self.number.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:self.number];
        
        self.signUp = [[UIButton alloc]initWithFrame:CGRectMake(W/2, self.label3.bottom + 10, W/2, 40)];
        [self.signUp setTitleColor:[UIColor colorWithRed:100.0/255.0 green:149.0/255 blue:208.0/255.0 alpha:1] forState:(UIControlStateNormal)];
//        self.signUp.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:self.signUp];
    }
    return self;
}
- (void)cellModel:(BrandMainSecondModel *)model{
    if (model.manyvictors.count == 0) {
        [self.contentView removeFromSuperview];
    }
    self.titleL.text = model.manyvictors[@"title"];
    self.label1.text = model.manyvictors[@"shorttitle"];
    self.label2.text = model.manyvictors[@"sign"];
    self.label3.text = model.manyvictors[@"typesign"];
    
    [self.number setTitle:@"立即拨打" forState:(UIControlStateNormal)];
    [self.signUp setTitle:@"我要报名" forState:(UIControlStateNormal)];
    
}
@end
