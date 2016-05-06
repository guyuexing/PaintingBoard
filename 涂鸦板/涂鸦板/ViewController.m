//
//  ViewController.m
//  涂鸦板
//
//  Created by guyuexing on 16/5/6.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "ZHBodyView.h"

@interface ViewController ()

@property (nonatomic,weak) UIToolbar *toolBar;

@property (nonatomic,weak) ZHBodyView *bodyView;

@property (nonatomic,weak) UIView *bottomView;

@property (nonatomic,weak) UIImageView *bodyImg;

@property (nonatomic,weak) UISlider *slider;

@property (nonatomic,weak) UIButton *firstBtn;

@property (nonatomic,weak) UIBarButtonItem *cleanScreen;

@property (nonatomic,weak) UIBarButtonItem *back;

@property (nonatomic,weak) UIBarButtonItem *eraser;

@property (nonatomic,weak) UIBarButtonItem *save;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    
    [self changeTheLineWidth:self.slider];
    [self changeLineColor:self.firstBtn];
    
    self.bodyView.imgBlock = ^(ZHBodyView *bodyView,UIImage *image){
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
    };
    
    
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error == nil) {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示:" message:@"保存成功！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alertC addAction:confirm];
        
        [self presentViewController:alertC animated:YES completion:nil];
        
    }else{
        NSLog(@"保存失败");
    
    }
    
    
}


//改变线宽
- (void)changeTheLineWidth:(UISlider *)slider{
    
    self.bodyView.lineWidth = slider.value;
    
}

//改变线的颜色
- (void)changeLineColor:(UIButton *)sender{
    
    self.bodyView.lineColor = sender.backgroundColor;
    
}

//清屏
- (void)cleanScreenBtnClick{
    
    [self.bodyView cleanScreen];
    
}

//回退
- (void)backBtnClick{

    [self.bodyView back];

}

//橡皮擦
- (void)eraserBtnClick{

    self.bodyView.lineColor = self.bodyView.backgroundColor;
}

//保存
- (void)saveBtnClick{

    [self.bodyView saveImg];

}


- (void)setUI{
    
    
    UIToolbar *toolBar = [[UIToolbar alloc] init];
    self.toolBar = toolBar;
    [self.view addSubview:toolBar];
    [toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    UIBarButtonItem *clearScreen = [[UIBarButtonItem alloc] initWithTitle:@"清屏" style:UIBarButtonItemStylePlain target:self action:@selector(cleanScreenBtnClick)];
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"回退" style:UIBarButtonItemStylePlain target:self action:@selector(backBtnClick)];
    UIBarButtonItem *eraser = [[UIBarButtonItem alloc] initWithTitle:@"橡皮擦" style:UIBarButtonItemStylePlain target:self action:@selector(eraserBtnClick)];
    UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *saveBtn = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveBtnClick)];
    toolBar.items = @[clearScreen,back,eraser,flex,saveBtn];
    
    self.cleanScreen = clearScreen;
    self.back = back;
    self.eraser = eraser;
    self.save = saveBtn;
    
    
    ZHBodyView *bodyView = [[ZHBodyView alloc] init];
    self.bodyView = bodyView;
    bodyView.multipleTouchEnabled = YES;
    bodyView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:bodyView];
    [bodyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(toolBar.mas_bottom).offset(0);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(self.view.mas_height).offset(-130);
    }];
    
    UIView *bottomView = [[UIView alloc] init];
    self.bottomView = bottomView;
    [self.view addSubview:bottomView];
    bottomView.backgroundColor = [UIColor whiteColor];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.topMargin.equalTo(bodyView.mas_bottom).offset(0);
        make.left.right.equalTo(self.view);
        make.bottomMargin.equalTo(self.view).offset(0);
        
    }];
    
    
    UISlider *slider = [[UISlider alloc] init];
    self.slider = slider;
    slider.minimumValue = 1;
    slider.maximumValue = 50;
    [bottomView addSubview:slider];
    [slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(bottomView);
        make.top.equalTo(bottomView).offset(5);
        make.height.mas_equalTo(20);
    }];
    [slider addTarget:self action:@selector(changeTheLineWidth:) forControlEvents:UIControlEventValueChanged];
    
    UIButton *redBtn = [[UIButton alloc] init];
    redBtn.backgroundColor = [UIColor redColor];
    self.firstBtn = redBtn;
    UIButton *blueBtn = [[UIButton alloc] init];
    blueBtn.backgroundColor = [UIColor blueColor];
    UIButton *yellowBtn = [[UIButton alloc] init];
    yellowBtn.backgroundColor = [UIColor yellowColor];
    [bottomView addSubview:redBtn];
    [bottomView addSubview:blueBtn];
    [bottomView addSubview:yellowBtn];
    
    [blueBtn addTarget:self action:@selector(changeLineColor:) forControlEvents:UIControlEventTouchUpInside];
    [redBtn addTarget:self action:@selector(changeLineColor:) forControlEvents:UIControlEventTouchUpInside];
    [yellowBtn addTarget:self action:@selector(changeLineColor:) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *array = [NSArray arrayWithObjects:redBtn,blueBtn,yellowBtn, nil];
    [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:20 leadSpacing:20 tailSpacing:20];
    [array mas_makeConstraints:^(MASConstraintMaker *make) {
        make.topMargin.equalTo(slider.mas_bottom).offset(25);
        make.height.mas_equalTo(20);
    }];
    
}

- (BOOL)prefersStatusBarHidden{
    
    return YES;
}

@end
