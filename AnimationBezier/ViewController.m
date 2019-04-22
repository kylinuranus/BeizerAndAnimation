//
//  ViewController.m
//  AnimationAndBizier
//
//  Created by 赵申侃 on 2017/11/14.
//  Copyright © 2019 赵申侃. All rights reserved.
//

#import "ViewController.h"
#import "SKWaveViewController.h"
#import "SKHoopViewController.h"
#import "SKDragHoopViewController.h"
#import "SKTemperatureCircleViewController.h"
#import "SKChartViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy) NSArray *dataArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArr = @[@"波浪效果",@"填充环",@"环拖动",@"刻度表",@"表单"];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 40;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.view addSubview:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = self.dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = self.dataArr[indexPath.row];
    if ([str isEqualToString:@"波浪效果"]) {
        SKWaveViewController *vc = [[SKWaveViewController alloc] init];
        vc.navigationItem.title = str;
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([str isEqualToString:@"填充环"]) {
        SKHoopViewController *vc = [[SKHoopViewController alloc] init];
        vc.navigationItem.title = str;
        [self.navigationController pushViewController:vc animated:YES];
    } else if([str isEqualToString:@"环拖动"]) {
        SKDragHoopViewController *vc = [[SKDragHoopViewController alloc] init];
        vc.navigationItem.title = str;
        [self.navigationController pushViewController:vc animated:YES];
    } else if([str isEqualToString:@"刻度表"]) {
        SKTemperatureCircleViewController *vc = [[SKTemperatureCircleViewController alloc] init];
        vc.navigationItem.title = str;
        [self.navigationController pushViewController:vc animated:YES];
    } else if([str isEqualToString:@"表单"]) {
        SKChartViewController *vc = [[SKChartViewController alloc] init];
        vc.navigationItem.title = str;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}



@end
