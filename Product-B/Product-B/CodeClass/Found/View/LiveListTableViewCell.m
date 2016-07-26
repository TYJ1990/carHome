//
//  LiveListTableViewCell.m
//  Product-B
//
//  Created by lanou on 16/7/24.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "LiveListTableViewCell.h"

@implementation LiveListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)cellWithDetailModel:(LiveModel *)model{
    self.album.text = model.album;
    self.time.text = model.programtime;
    [self.appointment.layer setBorderWidth:1];
    [self.appointment.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.appointment addTarget:self action:@selector(changeColor) forControlEvents:(UIControlEventTouchUpInside)];
}


- (void)changeColor{
    
}




@end
