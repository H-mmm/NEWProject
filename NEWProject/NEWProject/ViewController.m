//
//  ViewController.m
//  NEWProject
//
//  Created by Saada_cnjp on 2017/3/18.
//  Copyright © 2017年 Oraganization XXX. All rights reserved.
//

#import "ViewController.h"
#import "ViewController_1.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prefersStatusBarHidden];
    [self.view setBackgroundColor:[UIColor redColor]];
    [self preferredStatusBarStyle];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width- 50, 20+44, 50, 50)];
    [btn addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchDown];
    [btn setTitle:@"跳转" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:btn];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden{
    return NO;
}
-(UIStatusBarStyle)preferredStatusBarStyle

{
    
    return UIStatusBarStyleLightContent;
    
}

- (void)pop{
    NSLog(@"123");
//    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
//    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    [self.navigationController pushViewController:[[ViewController_1 alloc]init] animated:YES];
//    [self presentModalViewController:[[ViewController_1 alloc]init] animated:YES];
}
@end
