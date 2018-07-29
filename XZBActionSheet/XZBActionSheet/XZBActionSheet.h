//
//  XZBActionSheet.h
//  XZBActionSheet
//
//  Created by 肖志斌 on 2018/7/29.
//  Copyright © 2018年 xiao. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^XZBActionHandler)(NSUInteger index);
@interface XZBActionSheet : NSObject
+ (void)XZB_actionSheetWithActionTitles:(NSArray *)actionTitle
                           actionHander:(XZBActionHandler)actionHandler;

+ (void)XZB_TableActionSheetWithActionTitles:(NSArray *)actionTitle
                                actionHander:(XZBActionHandler)actionHandler;
@end
