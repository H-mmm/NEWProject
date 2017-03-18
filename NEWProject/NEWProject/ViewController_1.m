//
//  ViewController_1.m
//  NEWProject
//
//  Created by Saada_cnjp on 2017/3/18.
//  Copyright © 2017年 Oraganization XXX. All rights reserved.
//

#import "ViewController_1.h"

@interface ViewController_1 ()

@end

@implementation ViewController_1

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 64, 50, 50)];
    [btn setBackgroundColor:[UIColor blueColor]];
    [btn addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchDown];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [self.view setBackgroundColor:[UIColor yellowColor]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) pop{
    NSLog(@"返回方法");
    [self.navigationController popViewControllerAnimated:YES];
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
