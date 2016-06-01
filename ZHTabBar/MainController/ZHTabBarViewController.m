//
//  ZHTabBarViewController.m
//  ZHTabBar
//
//  Created by 周浩 on 16/6/1.
//  Copyright © 2016年 周浩. All rights reserved.
//


#import "ZHTabBarViewController.h"

/** View  */
#import "ZHTabBar.h"

/** Controller  */
#import "ZHFirstViewController.h"
#import "ZHSecondViewController.h"
#import "ZHThirdViewController.h"
#import "ZHFourthViewController.h"
#import "ZHMiddleViewController.h"

/** Navigation  */
#import "ZHNavigationViewController.h"

@interface ZHTabBarViewController ()<UITabBarControllerDelegate,UINavigationControllerDelegate,ZHTabBarDelegate>
/** 保存所有控制器对应itme的内容（UITabBarItem）*/
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) ZHTabBar *mytabbar;
@end

@implementation ZHTabBarViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //隐藏并移除系统自带的tabBar
    self.tabBar.hidden = true;
    [self.tabBar removeFromSuperview];
    //移除系统自带的tabBar上的items
    for (UIView *subView in self.tabBar.subviews) {
        if (![subView isKindOfClass:[ZHTabBar class]]) {
            [subView removeFromSuperview];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    [self addAllChildControllers];
    // 自定义tabBar
    [self setUpTabBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 自定义tabBar
- (void)setUpTabBar
{
    ZHTabBar *tabBar = [[ZHTabBar alloc] init];
    
    // 存储UITabBarItem
    tabBar.items = self.items;
    
    tabBar.delegate = self;
    
    tabBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tab_background"]];
    
    tabBar.frame = self.tabBar.frame;
    [self.view addSubview:tabBar];
    self.mytabbar = tabBar;
}

- (void)addAllChildControllers{
    ZHFirstViewController * FirstVC = [[ZHFirstViewController alloc] init];
    [self initChildVIewController:FirstVC title:@"第一页" imageName:@"icon_sy" selectedImageName:@"icon_sy_xz"];
    FirstVC.view.backgroundColor = [UIColor lightGrayColor];
    
    ZHSecondViewController * SecondVC = [[ZHSecondViewController alloc] init];
    [self initChildVIewController:SecondVC title:@"第二页" imageName:@"icon_jxgm2" selectedImageName:@"icon_jxgm2_xz"];
    SecondVC.view.backgroundColor = [UIColor grayColor];
    
    ZHMiddleViewController * MiddleVC = [[ZHMiddleViewController alloc] init];
    [self initChildVIewController:MiddleVC title:@"中间页" imageName:@"tabBar_publish_icon" selectedImageName:@"tabBar_publish_icon"];
    MiddleVC.view.backgroundColor = ZHRandomColor;
    
    ZHThirdViewController * ThirdVC = [[ZHThirdViewController alloc] init];
    [self initChildVIewController:ThirdVC title:@"第三页" imageName:@"icon_zc" selectedImageName:@"icon_zc_xz"];
    ThirdVC.view.backgroundColor = [UIColor magentaColor];
    
    ZHFourthViewController * FourthVC = [[ZHFourthViewController alloc] init];
    [self initChildVIewController:FourthVC title:@"第四页" imageName:@"icon_wd" selectedImageName:@"icon_wd_xz"];
    FourthVC.view.backgroundColor = [UIColor cyanColor];
    
}
- (void)initChildVIewController:(UIViewController*)viewController title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName{
    //tabBarItem的文字
    viewController.tabBarItem.title = title;
    
    //tabBarItem的图标
    viewController.tabBarItem.image = [UIImage imageNamed:imageName];
    
    //tabBarItem的文字样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [[UIColor alloc]initWithRed:113/255.0 green:109/255.0 blue:104/255.0 alpha:1];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    [viewController.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    //tabBarItem的文字选中颜色
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSForegroundColorAttributeName] = ZHColor(51, 135, 255);
    [viewController.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    
    //设置tabBarItem选中的图标
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    // 不要渲染
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage = selectedImage;
    
    //记录所有控制器对应按钮的内容
    [self.items addObject:viewController.tabBarItem];
    
    // 添加为tabbar控制器的子控制器
    ZHNavigationViewController *navigationController = [[ZHNavigationViewController alloc] initWithRootViewController:viewController];
    
    navigationController.delegate = self;
    [self addChildViewController:navigationController];
}

#pragma mark - ============ ZHTabBarDelegate方法 ============
// 监听tabBar上按钮的点击
- (void)tabBar:(ZHTabBar *)tabBar didSelectedBtnAtIndex:(NSInteger)index
{
    [super setSelectedIndex:index];
}

/**
 *  让myTabBar选中对应的按钮
 */
- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    // 通过mytabbar的通知处理页面切换
    self.mytabbar.seletedIndex = selectedIndex;
}

#pragma mark - ============ UINavigationController代理 ============
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    UIViewController *rootViewController = navigationController.viewControllers.firstObject;
    self.tabBar.hidden = YES;
    if (viewController != rootViewController) {
        //从FirstViewController移除
        [self.mytabbar removeFromSuperview];
        // 调整tabbar的Y值
        CGRect dockFrame = self.mytabbar.frame;
        
        dockFrame.origin.y = rootViewController.view.frame.size.height - kTabBarHeight;
        if ([rootViewController.view isKindOfClass:[UIScrollView class]]) { // 根控制器的view是否能滚动
            UIScrollView *scrollview = (UIScrollView *)rootViewController.view;
            dockFrame.origin.y += scrollview.contentOffset.y;
        }
        self.mytabbar.frame = dockFrame;
        // 添加dock到根控制器界面
        [rootViewController.view addSubview:self.mytabbar];
    }
}

// 完全展示完调用
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    UIViewController *rootViewController = navigationController.viewControllers.firstObject;
    ZHNavigationViewController *nav = (ZHNavigationViewController *)navigationController;
    if (viewController == rootViewController) {
        // 更改导航控制器view的frame
        navigationController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - kTabBarHeight);
        
        navigationController.interactivePopGestureRecognizer.delegate = nav.popDelegate;
        // 让Dock从root上移除
        [_mytabbar removeFromSuperview];
        
        //_mytabbar添加dock到HomeViewController
        _mytabbar.frame = self.tabBar.frame;
        [self.view addSubview:_mytabbar];
    }
}

- (NSMutableArray *)items {
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}
@end
