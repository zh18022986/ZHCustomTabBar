//
//  ZHFirstViewController.m
//  ZHTabBar
//
//  Created by 周浩 on 16/6/1.
//  Copyright © 2016年 周浩. All rights reserved.
//

#import "ZHFirstViewController.h"
#import "ZHSecondViewController.h"

@interface ZHFirstViewController ()<UITableViewDelegate,UITableViewDataSource>
/** <#注释#> */
@property (nonatomic, strong) UITableView * tableView;
@end

@implementation ZHFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"第一页";
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *pushBtn = [[UIButton alloc] init];
    pushBtn.frame = CGRectMake(100, 100, 100, 100);
    pushBtn.backgroundColor = [UIColor redColor];
    [pushBtn setTitle:@"跳转页面" forState:UIControlStateNormal];
    [pushBtn addTarget:self action:@selector(pushvC)];
    self.tabBarItem.badgeValue = @"1";
    
    [self.view addSubview:self.tableView];
    
    [self.view addSubview:pushBtn];
}

- (void)pushvC {
    ZHSecondViewController *vc = [[ZHSecondViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"homeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"home -- %zd", indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.tabBarController.selectedIndex = 4;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.height = ZHScreenH - 64 - kTabBarHeight;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}
@end
