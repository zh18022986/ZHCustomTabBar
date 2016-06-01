//
//  ZHTabBar.m
//  ZHTabBar
//
//  Created by 周浩 on 16/6/1.
//  Copyright © 2016年 周浩. All rights reserved.
//

#import "ZHTabBar.h"
#import "ZHTabBarButton.h"
#import "ZHTabBarBigButton.h"

@interface ZHTabBar ()
/**
 *  选中的按钮
 */
@property (nonatomic, weak) UIButton *selButton;

/** bigButton */
@property (nonatomic, weak) ZHTabBarBigButton *bigButton;

@end

@implementation ZHTabBar

/** tabBarTag */
static NSInteger const ZHTabBarTag = 12000;

- (void)setItems:(NSArray *)items
{
    _items = items;
    
    // UITabBarItem保存按钮上的图片
    for (int i = 0; i < items.count; i++) {
        UITabBarItem *item = items[i];
        if (i == 2) {
            ZHTabBarBigButton *btn = [ZHTabBarBigButton buttonWithType:UIButtonTypeCustom];
            
            btn.tag = self.subviews.count + ZHTabBarTag;
            
            // 设置图片
            [btn setImage:item.image forState:UIControlStateNormal];
            [btn setImage:item.selectedImage forState:UIControlStateSelected];
            btn.adjustsImageWhenHighlighted = NO;
            // 设置文字
            [btn setTitle:item.title forState:UIControlStateNormal];
            [btn setTitleColor:ZHColor(113, 109, 104) forState:UIControlStateNormal];
            [btn setTitleColor:ZHColor(51, 135, 255) forState:UIControlStateSelected];
            
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
            
            [self addSubview:btn];
            self.bigButton = btn;
            
        } else {
            ZHTabBarButton *btn = [ZHTabBarButton buttonWithType:UIButtonTypeCustom];
            
            btn.tag = self.subviews.count + ZHTabBarTag;
            
            // 设置图片
            [btn setImage:item.image forState:UIControlStateNormal];
            [btn setImage:item.selectedImage forState:UIControlStateSelected];
            btn.adjustsImageWhenHighlighted = NO;
            // 设置文字
            [btn setTitle:item.title forState:UIControlStateNormal];
            btn.item = item;
            [btn setTitleColor:ZHColor(113, 109, 104) forState:UIControlStateNormal];
            [btn setTitleColor:ZHColor(51, 135, 255) forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
            
            [self addSubview:btn];
            if (self.subviews.count == 1) {
                // 默认选中第一个
                [self btnClick:btn];
            }
            // 添加观察者
            [item addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:(__bridge void * _Nullable)(btn)];
        }
    }
}

/**
 *  实现数字的显示
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    ZHTabBarButton *btn = (__bridge ZHTabBarButton *)(context);
    UITabBarItem *item = object;
    btn.item = item;
}

- (void)btnClick:(UIButton *)button
{
    _selButton.selected = NO;
    
    button.selected = YES;
    
    _selButton = button;
    
    // 通知tabBarVc切换控制器
    if ([_delegate respondsToSelector:@selector(tabBar:didSelectedBtnAtIndex:)]) {
        [_delegate tabBar:self didSelectedBtnAtIndex:button.tag - ZHTabBarTag];
    }
}

/**
 *  外界设置索引页跟着跳转
 */
- (void)setSeletedIndex:(NSInteger)seletedIndex {
    _seletedIndex = seletedIndex;
    UIButton *button = [self viewWithTag:(ZHTabBarTag + seletedIndex)];
    [self btnClick:button];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger count = self.subviews.count;
    
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = [UIScreen mainScreen].bounds.size.width / count;
    
    CGFloat h = self.height;
    
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.subviews[i];
        
        x = i * w;
        
        if (i == 2) {
            y = -12;
            h = self.height + 12;
        } else {
            y = 0;
            h = self.height;
        }
        btn.frame = CGRectMake(x, y, w, h);
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    // 这里宽度应该跟突出部分的宽度一样，减少点击反应区域
    CGFloat pointW = 43;
    CGFloat pointH = 61;
    CGFloat pointX = (ZHScreenW - pointW) / 2;
    CGFloat pointY = -12;
    CGRect rect = CGRectMake(pointX, pointY, pointW, pointH);
    if (CGRectContainsPoint(rect, point)) {
        return self.bigButton;
    }
    return [super hitTest:point withEvent:event];
}


@end
