
//
//  RadioPlayerView.m
//  Product-B
//
//  Created by lanou on 16/7/22.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "RadioPlayerView.h"
#import "ListViewController.h"


@implementation RadioPlayerView

- (IBAction)share:(id)sender {
}
- (IBAction)timing:(id)sender {
}
- (IBAction)back:(id)sender {
    [self.vc dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)playAndPause:(id)sender {
}

- (IBAction)list:(id)sender {
    
   [UIView animateWithDuration:0.2 animations:^{
       self.vc.ListView.frame =CGRectMake(0, 0, kScreenWidth, kScreenHeight);
   }];
    
}

- (IBAction)comment:(id)sender {
}












@end
