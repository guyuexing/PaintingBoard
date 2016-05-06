//
//  ZHBodyView.h
//  画板界面搭建
//
//  Created by guyuexing on 16/5/5.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHBodyView;

typedef void (^saveImgBlock) (ZHBodyView *, UIImage *image);

@interface ZHBodyView : UIView

@property (nonatomic,assign) CGFloat lineWidth;

@property (nonatomic,strong) UIColor *lineColor;

@property (nonatomic,copy) saveImgBlock imgBlock;

- (void)cleanScreen;

- (void)back;

- (void)eraser;

- (void)saveImg;

@end
