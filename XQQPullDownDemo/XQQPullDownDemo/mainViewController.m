//
//  mainViewController.m
//  XQQPullDownDemo
//
//  Created by XQQ on 16/8/17.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import "mainViewController.h"
#define iphoneWidth  [UIScreen mainScreen].bounds.size.width
#define iphoneHeight [UIScreen mainScreen].bounds.size.height
@interface mainViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
/**
 *  数据源
 */
@property(nonatomic, strong) NSMutableArray     * dataArr;
/**
 *  tabelView
 */
@property(nonatomic, strong)  UITableView       *  myTabelView;
/**
 *  头视图
 */
@property(nonatomic, strong)  UIImageView       *  topView;


@end


@implementation mainViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(itemDidPress)];
    //设置导航栏透明
    [self setNavgationBar];
    //组织数据源
    for (NSInteger i = 0; i < 20; i ++) {
        NSString * str = [NSString stringWithFormat:@"我是第%ld行",i];
        [self.dataArr addObject:str];
    }
    [self.view addSubview:self.myTabelView];
    
}

#pragma mark - actievty

- (void)itemDidPress{
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    CGFloat y = scrollView.contentOffset.y;
    if (y < -250) {
        CGRect frame = _topView.frame;
        frame.origin.y = y;
        frame.size.height = -y;
        _topView.frame = frame;
    }
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * idStr = @"myCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:idStr];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idStr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.textColor = [UIColor blueColor];
    cell.textLabel.text = self.dataArr[indexPath.row];
    return cell;
}

#pragma mark - setNavgationBar

- (void)setNavgationBar{
    //设置导航栏半透明
    self.navigationController.navigationBar.translucent = YES;
    //设置导航栏背景图片
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    //去掉线
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc]init];
}

#pragma mark - setter&getter
- (UIImageView *)topView{
    if (!_topView) {
        _topView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -250, iphoneWidth, 250)];
        _topView.image = [UIImage imageNamed:@"5.jpg"];
        _topView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _topView;
}
- (UITableView *)myTabelView{
    if (!_myTabelView) {
        _myTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, -64, iphoneWidth, iphoneHeight + 64) style:UITableViewStylePlain];
        _myTabelView.delegate = self;
        _myTabelView.dataSource = self;
        _myTabelView.contentInset = UIEdgeInsetsMake(250, 0, 0, 0);
        [_myTabelView insertSubview:self.topView atIndex:0];
    }
    return _myTabelView;
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = @[].mutableCopy;
    }
    return _dataArr;
}


- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

@end
