//
//  NesflashDetailTableViewCell.h
//  Product-B
//
//  Created by lanou on 16/7/17.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsflashModel.h"

@interface NesflashDetailTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *headimg;
@property (strong, nonatomic) IBOutlet UILabel *authorname;
@property (strong, nonatomic) IBOutlet UILabel *timeL;
@property (strong, nonatomic) IBOutlet UILabel *contentL;
@property (strong, nonatomic) IBOutlet UIView *image;
@property (strong, nonatomic) IBOutlet UILabel *Support;
@property (strong, nonatomic) IBOutlet UILabel *commentL;
@property (strong, nonatomic) IBOutlet UILabel *username;
@property (strong, nonatomic) IBOutlet UIImageView *Cheadimg;
@property (strong, nonatomic) IBOutlet UILabel *Ccontent;
@property (strong, nonatomic) IBOutlet UIImageView *headimg2;
@property (strong, nonatomic) IBOutlet UILabel *username2;
@property (strong, nonatomic) IBOutlet UILabel *ccomment2;
@property (strong, nonatomic) IBOutlet UIImageView *headimg3;
@property (strong, nonatomic) IBOutlet UILabel *username3;
@property (strong, nonatomic) IBOutlet UILabel *Ccomment3;
@property (strong, nonatomic) IBOutlet UITextField *textFeild;




- (void)cellWithNewsflashModel:(NewsflashModel *)model;



@end
