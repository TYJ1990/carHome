//
//  MusicPlayViewController.h
//  Product-B
//
//  Created by lanou on 16/7/22.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BottomView.h"
#import "ListViewController.h"

@interface MusicPlayViewController : UIViewController

@property(nonatomic,strong)BottomView *bottomView;
@property(nonatomic,strong)UIImage *picurl;
@property(nonatomic,strong)NSString *album;

@property(nonatomic,strong)UIView *ListView;


@end
