//
//  ViewController_1.m
//  NEWProject
//
//  Created by Saada_cnjp on 2017/3/18.
//  Copyright © 2017年 Oraganization XXX. All rights reserved.
//

#import "ViewController_1.h"
#import "mTableViewCell.h"
#define CELLHEIGHT 60
@interface ViewController_1 ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;
    
}
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation ViewController_1

- (void)viewDidLoad {
    [super viewDidLoad];
    //注册广播
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(startPlaying:) name:@"startPlaying" object:nil];
    [nc addObserver:self selector:@selector(stopPlaying:) name:@"stopPlaying" object:nil];
    _dataSource = [NSMutableArray new];
    for (int i = 0 ; i <25 ; i++) {
        NSString *str = [NSString stringWithFormat:@"第%d行",i];
        [_dataSource addObject:str];
    }
    //
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 50, 44)];
    [btn setBackgroundColor:[UIColor blueColor]];
    [btn addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchDown];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [self.view setBackgroundColor:[UIColor yellowColor]];
    // Do any additional setup after loading the view.
    
    //创建一个TableView
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width,self.view.bounds.size.height - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = NO;//取消分割线
    _tableView.bounces = NO;//取消弹性效果
    [self.view addSubview:_tableView];
    
}
- (void) startPlaying:(NSNotification *)notify
{
    NSDictionary *dict = [notify userInfo];
    NSString *name = [dict objectForKey:@"A"];
    NSLog(@"%@",name);
}
- (void) stopPlaying:(NSNotification *)notify
{
    NSDictionary *dict = [notify userInfo];
    NSString *name = [dict objectForKey:@"A"];
    NSLog(@"%@",name);
}
- (void) pop{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataSource count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    mTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"cell"];
//    if (!cell) {
//        cell = [[mTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//        cell.i = indexPathse.row;
//        cell.str = _dataSource[indexPathse.row];
//        cell.cellHeight = CELLHEIGHT;
//    }
    //不复用设置
    mTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[mTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.i = indexPath.row;
        cell.str = _dataSource[indexPath.row];
        cell.cellHeight = CELLHEIGHT;
    } else {
        
    }
    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
//    }
//    cell.backgroundColor = [UIColor grayColor];
//    [cell.textLabel setText:[NSString stringWithFormat:@"第%ld行",(long)indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CELLHEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"ViewControl拿到点击事件，点击的第%ld",(long)indexPath.section);
    NSLog(@"打开这次点击的语音");
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"ViewControl拿到点击事件，上次点的%ld",(long)indexPath.section);
    NSLog(@"关闭上次点击的语音");
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_dataSource removeObjectAtIndex:indexPath.section];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView reloadData];
    }
}
@end
