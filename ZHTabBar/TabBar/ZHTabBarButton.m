//
//  ZHTabBarButton.m
//  ZHTabBar
//
//  Created by 周浩 on 16/6/1.
//  Copyright © 2016年 周浩. All rights reserved.
//

#import "ZHTabBarButton.h"
#import "ZHBadgeView.h"

@interface ZHTabBarButton ()
/**
 *  提醒数字
 */
@property (strong, nonatomic) ZHBadgeView *badgeView;
@end

@implementation ZHTabBarButton
/**
 *  小红点
 */
- (ZHBadgeView *)badgeView {
    if (!_badgeView) {
        ZHBadgeView *badgeView = [[ZHBadgeView alloc] init];
        [self addSubview:badgeView];
        self.badgeView = badgeView;
    }
    return _badgeView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 1.设置字体
        self.titleLabel.font = [UIFont systemFontOfSize:10];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.adjustsImageWhenHighlighted = NO;
        // 2.图片的内容模式
        self.imageView.contentMode = UIViewContentModeCenter;
    }
    return self;
}

- (void)setItem:(UITabBarItem *)item {
    _item = item;
    self.badgeView.badgeValue = item.badgeValue;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // 文字位置
    self.titleLabel.x = 0;
    self.titleLabel.width = self.width;
    self.titleLabel.height = 16;
    self.titleLabel.y = self.height - self.titleLabel.height;
    
    // 图片位置
    //    self.imageView.width = 35;
    //    self.imageView.height = 35;
    //    self.imageView.x = (self.width - self.imageView.width) / 2;
    //    self.imageView.y = 0;
    self.imageView.width = self.currentImage.size.width;
    self.imageView.height = self.currentImage.size.height;
    self.imageView.x = (self.width - self.imageView.width) / 2;
    self.imageView.y = self.titleLabel.y - self.imageView.height - 4;
    
    
    // 小红点位置
    self.badgeView.x = CGRectGetMaxX(self.imageView.frame) - 5;
    self.badgeView.y = 2;
    //    self.badgeView.width = ;
    //    self.badgeView.height = ;
}

- (void)setHighlighted:(BOOL)highlighted {
    
}

@end
