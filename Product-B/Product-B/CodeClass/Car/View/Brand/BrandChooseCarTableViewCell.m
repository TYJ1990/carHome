//
//  BrandChooseCarTableViewCell.m
//  Product-B
//
//  Created by super on 16/7/13.
//  Copyright © 2016年 wxl. All rights reserved.
//
#define W ([UIScreen mainScreen].bounds.size.width - 10)
#define H [UIScreen mainScreen].bounds.size.height
#import "BrandChooseCarTableViewCell.h"
#import "BrandChooseModel.h"
@implementation BrandChooseCarTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state

}

- (UIButton *)button:(NSArray *)arr{
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    if (!_button) {
        
        
        CGFloat w = 0;//保存前一个button的宽以及前一个button距离屏幕边缘的距离
        CGFloat h = 0;//用来控制button距离父视图的高
        
        for (int i = 0; i < arr.count; i++) {
            _button = [UIButton buttonWithType:UIButtonTypeSystem];
            _button.tag = 100 + i;
            _button.titleLabel.font = [UIFont systemFontOfSize:12];
            _button.layer.cornerRadius = 10;
            _button.backgroundColor = [UIColor colorWithRed:228.0/255.0 green:236.0/255 blue:248.0/255.0 alpha:1];
            [_button setTitleColor:[UIColor colorWithRed:81.0/255.0 green:134.0/255 blue:207.0/255.0 alpha:1] forState:UIControlStateNormal];
            
            // button边框
            _button.layer.borderWidth = 1;
            _button.layer.borderColor = [UIColor colorWithRed:81.0/255.0 green:134.0/255 blue:207.0/255.0 alpha:1].CGColor;
            [_button.layer setMasksToBounds:YES];
            
            
            //根据计算文字的大小
            NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
            CGFloat length = [arr[i] boundingRectWithSize:CGSizeMake(W, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
            //为button赋值
            [_button setTitle:arr[i] forState:UIControlStateNormal];
            //设置button的frame
            _button.frame = CGRectMake(10 + w, h + 10, length + 20, 20);
            //当button的位置超出屏幕边缘时换行 320 只是button所在父视图的宽度
            if(10 + w + length + 20 > W){
                w = 0; //换行时将w置为0
                h = h + _button.frame.size.height + 10;//距离父视图也变化
                _button.frame = CGRectMake(10 + w, h + 10, length + 15, 20);//重设button的frame
            }
            w = _button.frame.size.width + _button.frame.origin.x;
            [self.contentView addSubview:_button];
        }
    
        
    }
    
    
    return _button;
}

- (void)cellModelArray:(NSMutableArray *)array{
    BrandChooseModel *model = array[0];
    
    NSArray *arr = model.list;

    NSMutableArray *namearray = [NSMutableArray array];
    for (int i = 0; i < arr.count; i++) {
        NSDictionary *dic = arr[i];
        [namearray addObject:dic[@"name"]];
    }
//    NSMutableArray *arr = [@[@"商务行政",@"入门代步车",@"都市白领",@"节能先锋",@"爱越野",@"7座大空间",@"撩妹利器",@"适合女性"] mutableCopy];
    [self button:namearray];
}
@end
