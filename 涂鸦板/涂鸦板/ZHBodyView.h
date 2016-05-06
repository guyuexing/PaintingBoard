//
//  ZHBodyView.h
//  画板界面搭建
//
//  Created by guyuexing on 16/5/5.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHBodyView : UIView

@property (nonatomic,assign) CGFloat lineWidth;

@property (nonatomic,strong) UIColor *lineColor;

- (void)cleanScreen;


@end
