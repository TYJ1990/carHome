//
//  VideoTableViewCell.m
//  Product-B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "VideoTableViewCell.h"
#import "videoView.h"
#import "LabelAndImageView.h"

@implementation VideoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)cellWithModel:(RecommendModel *)model{
    CGFloat hight = [UILabel getHeightByWidth:kScreenWidth - 20 title:model.title font:[UIFont systemFontOfSize:15.0]];
    if ([model.mediatype integerValue] == 3) {
        for (UIView *view in self.contentView.subviews) {
            if ([view isKindOfClass:[LabelAndImageView class]] || [view isKindOfClass:[videoView class]]) {
                [view removeFromSuperview];
            }
        }
        self.vieoView = [[videoView alloc] initWithFrame:CGRectMake(10, 55, kScreenWidth - 20, (kScreenWidth - 20) / 2 + hight) height:hight + 10];
        self.vieoView.titleL.frame = CGRectMake(0, 0, kScreenWidth - 20, hight);
        self.vieoView.titleL.text = model.title;
        [self.vieoView.start sd_setImageWithURL:[NSURL URLWithString:model.thumbnailpics] placeholderImage:[UIImage imageNamed:@"shipinbg"]];
        
        [RequestManager requestWithUrlString:[NSString stringWithFormat:@"http://newsnc.app.autohome.com.cn/news_v6.0.0/newspf/npgetvideoaudiosource.ashx?pm=1&mids=%@&mt=1&ft=m3u8",model.videoid] requestType:requestGET parDic:nil finish:^(NSData *data) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
            NSArray *array = [dic[@"result"] firstObject][@"copieslist"];
            NSString *url = array[0][@"playurl"];
            AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:url]];
            [self.vieoView.player replaceCurrentItemWithPlayerItem:item];
        } error:^(NSError *error) {
            
        }];
        
       
        
        [self.contentView addSubview:self.vieoView];
    }else{
        for (UIView *view in self.contentView.subviews) {
            if ([view isKindOfClass:[videoView class]] || [view isKindOfClass:[LabelAndImageView class]]) {
                [view removeFromSuperview];
            }
        }
        LabelAndImageView *labelView = [[LabelAndImageView alloc] initWithFrame:CGRectMake(10, 55, kScreenWidth - 20, 60)];
        [labelView.thumbpics sd_setImageWithURL:[NSURL URLWithString:model.thumbnailpics] placeholderImage:[UIImage imageNamed:@"shipinbg"]];
        labelView.titleL.text = model.title;
        labelView.barImage.hidden = YES;
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:model.title ];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:7];//调整行间距
        if ([model.mediatype integerValue] == 1) {
            paragraphStyle.firstLineHeadIndent = 23;
            labelView.barImage.hidden = NO;
        }
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [model.title length])];
        labelView.titleL.attributedText = attributedString;
        [self.contentView addSubview:labelView];
    }
    [self.iconImageV sd_setImageWithURL:[NSURL URLWithString:model.userpic] placeholderImage:[UIImage imageNamed:@"shipinbg"]];
    self.titleL.text = model.username;
    self.titmeL.text = model.publishtime;
    self.supportL.text = [NSString stringWithFormat:@"%@",model.praisenum];
    self.commentL.text = [NSString stringWithFormat:@"%@",model.replycount];
    
}




- (void)getPlayUrl{
    
}


@end
