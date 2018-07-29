//
//  XZBButton.h
//  XZBActionSheet
//
//  Created by 肖志斌 on 2018/7/29.
//  Copyright © 2018年 xiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZBButton : UIButton
typedef void (^ClickActionBlock) (id obj);
@property (nonatomic,strong) ClickActionBlock caBlock;

- (void)initWithBlock:(ClickActionBlock)clickBlock for:(UIControlEvents)event;

+ (instancetype)btnWithBeginColor:(UIColor *)begin endColor:(UIColor *)end;
@end
