//
//  BrandMainSecondTwoCell.m
//  Product-B
//
//  Created by super on 16/7/21.
//  Copyright © 2016年 wxl. All rights reserved.
//
#define W [UIScreen mainScreen].bounds.size.width
#define H [UIScreen mainScreen].bounds.size.height
#import "BrandMainSecondTwoCell.h"

@implementation BrandMainSecondTwoCell

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

        self.uplabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 200, 30)];
        [self.contentView addSubview:self.uplabel];
        
//        self.grayview = [[UIView alloc]initWithFrame:CGRectMake(0, self.uplabel.bottom + 10, W, 10)];
//        self.grayview.backgroundColor = [UIColor grayColor];
//        [self.contentView addSubview:self.grayview];
//        
//        
//        self.titleL = [[UILabel alloc]initWithFrame:CGRectMake(10, self.grayview.bottom+10, 300, 20)];
//        [self.contentView addSubview:self.titleL];
//        
//        self.label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, self.titleL.bottom + 10, 150, 10)];
//        self.label1.font = [UIFont systemFontOfSize:12];
//        [self.contentView addSubview:self.label1];
//        
//        self.label2 = [[UILabel alloc]initWithFrame:CGRectMake(170, self.titleL.bottom + 10, 60, 10)];
//        self.label2.font = [UIFont systemFontOfSize:12];
//        [self.contentView addSubview:self.label2];
//        
//        self.label3 = [[UILabel alloc]initWithFrame:CGRectMake(240, self.titleL.bottom + 10, 50, 10)];
//        self.label3.font = [UIFont systemFontOfSize:12];
//        [self.contentView addSubview:self.label3];
//        
//        self.number = [[UIButton alloc]initWithFrame:CGRectMake(0, self.label3.bottom + 10, W/2, 50)];
//        self.number.backgroundColor = [UIColor grayColor];
//        [self.contentView addSubview:self.number];
//        
//        self.signUp = [[UIButton alloc]initWithFrame:CGRectMake(W/2, self.label3.bottom + 10, W/2, 50)];
//        self.signUp.backgroundColor = [UIColor grayColor];
//        [self.contentView addSubview:self.signUp];
    }
    return self;
}
- (void)cellModel:(BrandMainSecondModel *)model{
    
    if (model.teambuyinginfo.count == 0) {
        [self.contentView removeFromSuperview];
    }
    self.uplabel.text = model.teambuyinginfo[@"title"];
//    self.titleL.text = model.manyvictors[@"title"];
//    self.label1.text = model.manyvictors[@"shorttitle"];
//    self.label2.text = model.manyvictors[@"sign"];
//    self.label3.text = model.manyvictors[@"typesign"];
//    [self.number setTitle:@"立即拨打" forState:(UIControlStateNormal)];
//    [self.signUp setTitle:@"我要报名" forState:(UIControlStateNormal)];
    
    
}

@end
