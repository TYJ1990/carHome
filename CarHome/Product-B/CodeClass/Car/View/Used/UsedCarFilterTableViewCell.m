//
//  UsedCarFilterTableViewCell.m
//  Product-B
//
//  Created by super on 16/7/15.
//  Copyright © 2016年 wxl. All rights reserved.
//
#define W [UIScreen mainScreen].bounds.size.width
#define H [UIScreen mainScreen].bounds.size.height
#import "UsedCarFilterTableViewCell.h"

@implementation UsedCarFilterTableViewCell

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
        
        NSArray *arr = @[@"默认排序",@"品牌",@"价格里程年龄"];
        CGFloat w = 0;//保存前一个button的宽以及前一个button距离屏幕边缘的距离
        CGFloat h = 0;//用来控制button距离父视图的高
        for (int i = 0; i < arr.count; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            button.tag = 100 + i;
            button.backgroundColor = [UIColor whiteColor];
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            //根据计算文字的大小
            
            NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
            CGFloat length = [arr[i] boundingRectWithSize:CGSizeMake(W, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
            //为button赋值
            [button setTitle:arr[i] forState:UIControlStateNormal];
            //设置button的frame
            button.frame = CGRectMake(10 + w, h, length + 20, 30);
            //当button的位置超出屏幕边缘时换行 320 只是button所在父视图的宽度
            if(10 + w + length + 15 > W){
                w = 0; //换行时将w置为0
                h = h + button.frame.size.height + 10;//距离父视图也变化
                button.frame = CGRectMake(10 + w, h, length + 15, 30);//重设button的frame
            }
            w = button.frame.size.width + button.frame.origin.x;
            [self.contentView addSubview:button];
        }
        
        UIButton *more = [[UIButton alloc]initWithFrame:CGRectMake(W - 100, 0, 100, 30)];
        [more setTitle:@"更多" forState:(UIControlStateNormal)];
        [more setTitleColor:[UIColor colorWithRed:100.0/255.0 green:149.0/255 blue:208.0/255.0 alpha:1] forState:(UIControlStateNormal)];
        [self.contentView addSubview:more];
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 30, W, 20)];
        view.backgroundColor = [UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1];
        [self.contentView addSubview:view];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
        label.textColor = [UIColor colorWithRed:134.0/255.0 green:134.0/255.0 blue:134.0/255.0 alpha:1];
        label.text = @"快速找车";
        [view addSubview:label];
        
        
    }
    
    return self;
}
@end
