//
//  BrandMainSecondFiveCell.m
//  Product-B
//
//  Created by super on 16/7/21.
//  Copyright © 2016年 wxl. All rights reserved.
//
#define W [UIScreen mainScreen].bounds.size.width
#define H [UIScreen mainScreen].bounds.size.height
#import "BrandMainSecondFiveCell.h"

@implementation BrandMainSecondFiveCell

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

        self.title = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 300, 20)];
        [self.contentView addSubview:self.title];
        
        self.price = [[UILabel alloc]initWithFrame:CGRectMake(10, 40, 150, 20)];
        self.price.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.price];
        
        self.attention = [[UILabel alloc]initWithFrame:CGRectMake(10, 70, 50, 20)];
        self.attention.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.attention];
        
        self.downview = [[UIView alloc]initWithFrame:CGRectMake(70, 79, 100, 2)];
        self.downview.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:self.downview];
        
        self.upview = [[UIView alloc]init];
        self.upview.backgroundColor = [UIColor colorWithRed:100.0/255.0 green:149.0/255 blue:208.0/255.0 alpha:1];
        [self.contentView addSubview:self.upview];
        
        self.minprice = [[UILabel alloc]initWithFrame:CGRectMake(W - 160, 40, 150, 20)];
        self.minprice.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.minprice];
        
        self.button1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 100, W/3, 47)];
        [self.button1 setTitleColor:[UIColor colorWithRed:100.0/255.0 green:149.0/255 blue:208.0/255.0 alpha:1] forState:(UIControlStateNormal)];
        self.button1.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.button1];
        
        self.button2 = [[UIButton alloc]initWithFrame:CGRectMake(W/3, 100, W/3, 47)];
        self.button2.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.button2 setTitleColor:[UIColor colorWithRed:100.0/255.0 green:149.0/255 blue:208.0/255.0 alpha:1] forState:(UIControlStateNormal)];
        [self.contentView addSubview:self.button2];
        
        self.button3 = [[UIButton alloc]initWithFrame:CGRectMake(W/3*2, 100, W/3, 47)];
        self.button3.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.button3 setTitleColor:[UIColor colorWithRed:100.0/255.0 green:149.0/255 blue:208.0/255.0 alpha:1] forState:(UIControlStateNormal)];
        [self.contentView addSubview:self.button3];
//        NSLog(@"cell 宽 %f",self.contentView.frame.size.width);
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, self.button1.bottom, W, 3)];
        view.backgroundColor = [UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1];
        [self.contentView addSubview:view];
    }
    return self;
}
- (void)cellModel:(NSDictionary *)dic{
    self.title.text = dic[@"name"];
    self.price.text = [NSString stringWithFormat:@"%@%@",dic[@"pricename"], dic[@"price"]];
    self.attention.text = @"关注度";
    
    self.upview.frame = CGRectMake(70, 79, [dic[@"attention"] floatValue], 2);
    self.minprice.text = [NSString stringWithFormat:@"参考价：%@", dic[@"minprice"]];
    [self.button1 setTitle:@"购车计算" forState:(UIControlStateNormal)];
    [self.button2 setTitle:@"添加对比" forState:(UIControlStateNormal)];
    [self.button3 setTitle:@"家家买车" forState:(UIControlStateNormal)];
    
}
@end
