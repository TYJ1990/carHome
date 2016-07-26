//
//  HeadView.h
//  Product-B
//
//  Created by lanou on 16/7/18.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadView : UIView
@property (strong, nonatomic) IBOutlet UIButton *forum;
@property (strong, nonatomic) IBOutlet UIButton *basePrice;
@property (strong, nonatomic) IBOutlet UIImageView *carPic;
@property (strong, nonatomic) IBOutlet UILabel *carname;
@property (strong, nonatomic) IBOutlet UILabel *carprice;
@property (strong, nonatomic) IBOutlet UILabel *authName;
@property (strong, nonatomic) IBOutlet UILabel *replayCount;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UIView *backView;

@end
