//
//  ZHTabBar.h
//  ZHTabBar
//
//  Created by 周浩 on 16/6/1.
//  Copyright © 2016年 周浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZHTabBar;

@protocol ZHTabBarDelegate <NSObject>

@optional

- (void)tabBar:(ZHTabBar *)tabBar didSelectedBtnAtIndex:(NSInteger)index;

@end

@interface ZHTabBar : UIView

/** 选中的索引 */
@property (nonatomic, assign) NSInteger seletedIndex;

// 模型数组(UITabBarItem)
@property (nonatomic, strong) NSArray *items;

@property (nonatomic, weak) id<ZHTabBarDelegate> delegate;

@end
