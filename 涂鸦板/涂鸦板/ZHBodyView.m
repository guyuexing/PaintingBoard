//
//  ZHBodyView.m
//  画板界面搭建
//
//  Created by guyuexing on 16/5/5.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "ZHBodyView.h"
#import "ZHBezierPath.h"

@interface ZHBodyView ()

@property (nonatomic,strong) ZHBezierPath *path;

@property (nonatomic,strong) NSMutableArray<ZHBezierPath *> *arrM;

@property (nonatomic) CGContextRef ctxRef;

@end

@implementation ZHBodyView

//清屏
- (void)cleanScreen{

    [self.arrM removeAllObjects];
    [self setNeedsDisplay];
    
}

//回退
- (void)back{

    [self.arrM removeLastObject];
    [self setNeedsDisplay];
    
}

//橡皮擦
- (void)eraser{
    //xiang
}

//保存图片
- (void)saveImg{

    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.0);
    CGContextRef ctxRef = UIGraphicsGetCurrentContext();
    
    [self.layer renderInContext:ctxRef];
    
    UIImage *screenImg = UIGraphicsGetImageFromCurrentImageContext();
    
    if (self.imgBlock) {
        self.imgBlock(self,screenImg);
    }
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    UITouch *spotT = [touches anyObject];
    
    CGPoint loc = [spotT locationInView:self];
    
    //由于每一条路径的线宽和颜色可能不一致，所以每一条路径应是重新定义的
    ZHBezierPath *path = [ZHBezierPath bezierPath];
    
    [path moveToPoint:loc];
    
    //将每一条路径保存进数组中
    path.lineC = self.lineColor;
    
    path.lineWidth = self.lineWidth;
    
    [self.arrM addObject:path];
    
    [self setNeedsDisplay];

}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

        UITouch *touch = touches.anyObject;
    
        CGPoint loc = [touch locationInView:self];
    
        [self.arrM.lastObject addLineToPoint:loc];
    
        [self setNeedsDisplay];
    
    //NSLog(@"2");

}

- (void)drawRect:(CGRect)rect{
/*
    CGContextRef ctxRef = UIGraphicsGetCurrentContext();
    
    CGContextAddPath(ctxRef, self.path.CGPath);
    
    CGContextSetLineWidth(ctxRef, 30);
    
    CGContextSetLineCap(ctxRef,  kCGLineCapButt);
    
    CGContextDrawPath(ctxRef, kCGPathStroke);
*/
    //将path的线宽和线条颜色属性在Path加入到数组中的时候同时加入
    //self.arrM.lastObject.lineWidth = self.lineWidth;
    //self.arrM.lastObject.lineC = self.lineColor;
    
    //使用这种方法设置线条颜色会把所有的线条全部设置成一种颜色
    //因此可以自定义UIBezierPath的线条颜色
    //[self.lineColor setStroke];

    
    [self.arrM enumerateObjectsUsingBlock:^(ZHBezierPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj.lineC setStroke];
        [obj stroke];
    }];
    
   
}


-(ZHBezierPath *)path{

    if (_path == nil) {
        _path = [ZHBezierPath bezierPath];
            }
    return _path;
}

-(NSMutableArray *)arrM{

    if (_arrM == nil) {
        _arrM = [NSMutableArray array];
    }
    return _arrM;
}

@end
