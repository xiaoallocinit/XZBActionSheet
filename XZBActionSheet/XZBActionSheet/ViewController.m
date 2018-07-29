//
//  ViewController.m
//  XZBActionSheet
//
//  Created by 肖志斌 on 2018/7/29.
//  Copyright © 2018年 xiao. All rights reserved.
//

#import "ViewController.h"
#import "XZBActionSheet.h"
#import "XZBButton.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    XZBButton *btn = [XZBButton btnWithBeginColor:[self colorWithHexWithLong:0x8ba2eb] endColor:[self colorWithHexWithLong:0xbb80d9]];
    [btn setTitle:@"点我更多" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:20];
    
    [btn addTarget:self action:@selector(CLICK) forControlEvents:UIControlEventTouchUpInside];
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    btn.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height/2);
    [self.view addSubview:btn];
    
    XZBButton *btn2 = [XZBButton btnWithBeginColor:[self colorWithHexWithLong:0x8ba2eb] endColor:[self colorWithHexWithLong:0xbb80d9]];
    [btn2 setTitle:@"点我弹出" forState:UIControlStateNormal];
    btn2.titleLabel.font = [UIFont systemFontOfSize:20];
    btn2.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height/2, [UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height/2);
    [btn2 addTarget:self action:@selector(CLICK2) forControlEvents:UIControlEventTouchUpInside];
    btn2.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:btn2];
    
    
    
    
//    NSArray <NSLayoutConstraint *> *firstH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[btn(btn2)]-0-[btn2]-0-|" options:0 metrics:nil views:@{@"btn" : btn,@"btn2" : btn2}];
//    [self.view addConstraints:firstH];
}
-(void)CLICK{
    NSArray *ARR = @[@"更多",@"复制",@"分享",@"评论"];
    [XZBActionSheet XZB_TableActionSheetWithActionTitles:ARR actionHander:^(NSUInteger index) {
        NSLog(@"点击了%@",ARR[index]);
        if (index == 1) {
            
        }else if (index == 2){
            
        }else if (index == 3){
            
        }
    }];
}

-(void)CLICK2{
    NSArray *ARR = @[@"更多",@"复制",@"分享",@"评论"];
    [XZBActionSheet XZB_actionSheetWithActionTitles:ARR actionHander:^(NSUInteger index) {
        NSLog(@"点击了%@",ARR[index]);
    }];
    
}
- (UIColor *)colorWithHexWithLong:(long)hexColor
{
    float red = ((float)((hexColor & 0xFF0000) >> 16))/255.0;
    float green = ((float)((hexColor & 0xFF00) >> 8))/255.0;
    float blue = ((float)(hexColor & 0xFF))/255.0;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
