//
//  ZHSecondViewController.m
//  ZHTabBar
//
//  Created by 周浩 on 16/6/1.
//  Copyright © 2016年 周浩. All rights reserved.
//

#import "ZHSecondViewController.h"

@interface ZHSecondViewController ()

@end

@implementation ZHSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"第二页";
    UIButton *pushBtn = [[UIButton alloc] init];
    pushBtn.frame = CGRectMake(100, 100, 100, 100);
    pushBtn.backgroundColor = [UIColor redColor];
    [pushBtn setTitle:@"跳转页面" forState:UIControlStateNormal];
    [pushBtn addTarget:self action:@selector(pushvC)];
    [self.view addSubview:pushBtn];
    self.tabBarItem.badgeValue = @"89";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushvC {
    ZHSecondViewController *new = [[ZHSecondViewController alloc] init];
    
    [self.navigationController pushViewController:new animated:YES];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"newCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"new -- %zd", indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.tabBarController.selectedIndex = 3;
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
