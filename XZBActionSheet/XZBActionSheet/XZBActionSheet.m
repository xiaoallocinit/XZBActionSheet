//
//  XZBActionSheet.m
//  XZBActionSheet
//
//  Created by 肖志斌 on 2018/7/29.
//  Copyright © 2018年 xiao. All rights reserved.
//

#import "XZBActionSheet.h"
#import "XZBButton.h"
#import "UIView+Extension.h"
// 宽高
#define XZBMargin 10
#define WIDTH  [UIScreen mainScreen].bounds.size.width - XZBMargin*2
#define TableWIDTH  [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define FontWithPingFangRegularSize(s) [UIFont fontWithName:@"PingFang-SC-Regular" size:s]
// 普通按钮的高度
#define BTN_HEIGHT 49
// 取消按钮的高度
#define CANCLE_BTN_HEIGHT ((HEIGHT == 812)? (BTN_HEIGHT + 34): BTN_HEIGHT)
// btn间分割线
#define BTN_SPACE_HEIGHT 0.5
// 分割线的高度
#define LINE_HEIGHT 15

// 动画时间
#define ANIMATION_TIME 0.25f
@implementation XZBActionSheet
static XZBButton *bgView;
static UIView *sheetView;
static UIView *topView;
+ (void)XZB_actionSheetWithActionTitles:(NSArray *)actionTitle
                           actionHander:(XZBActionHandler)actionHandler{
    
    if (actionTitle.count == 0) return;
    
    // 背景
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    bgView = [[XZBButton alloc] init];
    bgView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.3];
    bgView.center = CGPointMake([UIScreen mainScreen].bounds.size.width * 0.5, HEIGHT * 0.5);
    bgView.bounds = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, HEIGHT);
    [bgView initWithBlock:^(id obj) {
        
        // 移除界面
        [self removeView];
        
    } for:UIControlEventTouchUpInside];
    // 添加到窗口上
    [window addSubview:bgView];
    
    // 其他高度
    CGFloat OtherH = CANCLE_BTN_HEIGHT + LINE_HEIGHT;
    
    // sheetView高度
    CGFloat sheetViewH;
    if (actionTitle.count == 1) {
        
        sheetViewH = OtherH + BTN_HEIGHT;
    }else{
        
        sheetViewH = OtherH + actionTitle.count * (BTN_HEIGHT +BTN_SPACE_HEIGHT) - BTN_SPACE_HEIGHT;
    }
    
    // sheetView
    sheetView = [[UIView alloc] init];
    sheetView.frame = CGRectMake(XZBMargin, HEIGHT, WIDTH, sheetViewH);
    sheetView.backgroundColor = [UIColor clearColor];
    [bgView addSubview:sheetView];
    
    // topView
    topView = [[UIView alloc] init];
    topView.frame = CGRectMake(0, 0, WIDTH, sheetViewH - OtherH);
    topView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:0.8];
    topView.layer.cornerRadius = 10;
    topView.layer.masksToBounds      = true;
    [sheetView addSubview:topView];
    
    // 取消
    XZBButton *cancleBtn = [[XZBButton alloc] init];
    cancleBtn.backgroundColor = [UIColor whiteColor];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancleBtn.titleLabel.font = FontWithPingFangRegularSize(16);
    cancleBtn.layer.cornerRadius = 10;
    cancleBtn.layer.masksToBounds      = true;
    cancleBtn.frame = CGRectMake(0, sheetView.height - CANCLE_BTN_HEIGHT, WIDTH, CANCLE_BTN_HEIGHT);
    [cancleBtn initWithBlock:^(id obj) {
        
        // 移除界面
        [self removeView];
        
    } for:UIControlEventTouchUpInside];
    
    if (HEIGHT == 812) { // 适配iPhone X
        
        cancleBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 20, 0);
    }
    
    [sheetView addSubview:cancleBtn];
    
    for (NSUInteger i = 0; i<actionTitle.count; i++) {
        
        XZBButton *btn = [[XZBButton alloc] init];
        btn.backgroundColor = [UIColor whiteColor];
        btn.tag = i;
        [btn setTitle:actionTitle[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = FontWithPingFangRegularSize(16);
        if (actionTitle.count == 1) {
            
            btn.frame = CGRectMake(0, 0, WIDTH,BTN_HEIGHT);
        }else{
            
            btn.frame = CGRectMake(0, i * (BTN_HEIGHT + BTN_SPACE_HEIGHT), WIDTH,BTN_HEIGHT);
        }
        if (i == 0) {
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.titleLabel.font = FontWithPingFangRegularSize(14);
        }
        [btn initWithBlock:^(id obj) {
            
            actionHandler(i);
            // 移除界面
            [self removeView];
            
        } for:UIControlEventTouchUpInside];
        [topView addSubview:btn];
    }
    
    [UIView animateWithDuration:ANIMATION_TIME animations:^{
        
        sheetView.y = HEIGHT - sheetViewH;
    }];
}
+ (void)XZB_TableActionSheetWithActionTitles:(NSArray *)actionTitle
                                actionHander:(XZBActionHandler)actionHandler{
    
    if (actionTitle.count == 0) return;
    
    // 背景
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    bgView = [[XZBButton alloc] init];
    bgView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.3];
    bgView.center = CGPointMake([UIScreen mainScreen].bounds.size.width * 0.5, HEIGHT * 0.5);
    bgView.bounds = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, HEIGHT);
    
    [bgView initWithBlock:^(id obj) {
        
        // 移除界面
        [self removeView];
        
    } for:UIControlEventTouchUpInside];
    // 添加到窗口上
    [window addSubview:bgView];
    
    
    
    // sheetView高度
    CGFloat sheetViewH;
    sheetViewH =  120 + (actionTitle.count - 1 )* BTN_HEIGHT  + 60;
    
    // sheetView
    sheetView = [[UIView alloc] init];
    sheetView.frame = CGRectMake(0, HEIGHT, TableWIDTH, sheetViewH);
    sheetView.backgroundColor = [UIColor clearColor];
    [bgView addSubview:sheetView];
    
    
    // 取消
    XZBButton *cancleBtn = [[XZBButton alloc] init];
    
    [cancleBtn setImage:[UIImage imageNamed:@"xieyiquxiao"] forState:UIControlStateNormal];
    
    
    cancleBtn.frame = CGRectMake(TableWIDTH/2 - 20, 0, 40, 40);
    [cancleBtn initWithBlock:^(id obj) {
        
        // 移除界面
        [self removeView];
        
    } for:UIControlEventTouchUpInside];
    
    
    [sheetView addSubview:cancleBtn];
    
    
    topView = [[UIView alloc] init];
    topView.frame = CGRectMake(0, 60, TableWIDTH, sheetViewH - 60);
    topView.backgroundColor = [UIColor whiteColor];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:topView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(20, 20)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    //设置大小
    maskLayer.frame = topView.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    topView.layer.mask = maskLayer;
    
    [sheetView addSubview:topView];
    
    
    
    
    
    for (NSUInteger i = 0; i<actionTitle.count; i++) {
        if (i == 0) {
            UILabel *topLabel = [[UILabel alloc]init];
            topLabel.text = actionTitle[i];
            topLabel.textColor = [UIColor blackColor];
            topLabel.font = [UIFont boldSystemFontOfSize:25];
            topLabel.frame = CGRectMake(30, 50, TableWIDTH,30);
            [topView addSubview:topLabel];
        }else{
            UILabel *titleLabel = [[UILabel alloc]init];
            titleLabel.text = actionTitle[i];
            titleLabel.textColor = [UIColor blackColor];
            titleLabel.font = FontWithPingFangRegularSize(14);
            titleLabel.frame = CGRectMake(30, 100 + (i - 1)* (BTN_HEIGHT ), TableWIDTH,BTN_HEIGHT);
            [topView addSubview:titleLabel];
            UIImageView *arrow = [[UIImageView alloc]init];
            arrow.image = [UIImage imageNamed:@"youjiantou"];
            arrow.frame = CGRectMake(TableWIDTH - 30, BTN_HEIGHT/2 - 6 + 100 + (i - 1)* (BTN_HEIGHT ), 8, 12);
            [topView addSubview:arrow];
            XZBButton *btn = [[XZBButton alloc] init];
            btn.tag = i;
            btn.frame = CGRectMake(0, 100 + (i - 1)* (BTN_HEIGHT ), TableWIDTH,BTN_HEIGHT);
            
            [btn initWithBlock:^(id obj) {
                
                actionHandler(i);
                // 移除界面
                [self removeView];
                
            } for:UIControlEventTouchUpInside];
            [topView addSubview:btn];
            
            
            
        }
        
    }
    [UIView animateWithDuration:ANIMATION_TIME animations:^{
        
        sheetView.y = HEIGHT - sheetViewH;
    }];
    
    
    
}

#pragma mark - 移除
+ (void)removeView{
    
    [UIView animateWithDuration:ANIMATION_TIME animations:^{
        
        sheetView.y = HEIGHT;
    } completion:^(BOOL finished) {
        
        // 取消
        [bgView removeFromSuperview];
    }];
}
@end
