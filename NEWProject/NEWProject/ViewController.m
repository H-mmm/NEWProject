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
@property (nonatomic,strong) UIView *arrowView;
@property (nonatomic,strong) UIImageView *animationview;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prefersStatusBarHidden];
    [self.view setBackgroundColor:[UIColor redColor]];
    [self preferredStatusBarStyle];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 20+44, 150, 40)];
    [btn addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchDown];
    [btn setTitle:@"跳转" forState:UIControlStateNormal];
    [btn.layer setCornerRadius:5.0];
    [btn setBackgroundColor:[UIColor orangeColor]];
    _arrowView = [self arrowView:btn];
    _animationview = [self animationview:btn];
    [btn addSubview:_arrowView];
    [btn addSubview:_animationview];
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
    [self.navigationController pushViewController:[[ViewController_1 alloc]init] animated:YES];
    //点击播放按钮时，动画开始
//    [self.animationview startAnimating];
}

- (UIView *)arrowView:(UIButton *)btn{
    if (!_arrowView) {
        // draw
        CGSize size = CGSizeMake(18, 12);
        UIBezierPath *path = [[UIBezierPath alloc] init];
        [path moveToPoint:CGPointMake(size.width / 2.0, 0)];
        [path addLineToPoint:CGPointMake(0, size.height)];
        [path addLineToPoint:CGPointMake(size.width, size.height)];
        path.lineWidth = 1.0;
        
        CAShapeLayer *arrowLayer = [CAShapeLayer layer];
        arrowLayer.path = path.CGPath;
        
        _arrowView = [[UIView alloc] initWithFrame:CGRectMake(-size.height,(btn.bounds.size.height-size.height)/2, size.width, size.height)];
        _arrowView.layer.mask = arrowLayer;
        _arrowView.backgroundColor = btn.backgroundColor;
         _arrowView.transform = CGAffineTransformMakeRotation(270 *M_PI / 180.0);
    }
    return _arrowView;
}
- (UIImageView *)animationview:(UIButton *)btn{
    if (!_animationview) {
        float vHeighr = btn.bounds.size.height / 3;
        _animationview = [[UIImageView alloc] initWithFrame:CGRectMake(5,(btn.bounds.size.height - vHeighr ) / 2, vHeighr, vHeighr)];
        [_animationview setImage:[UIImage imageNamed:@"bofang3"]];
        NSArray *myImages = [NSArray arrayWithObjects: [UIImage imageNamed:@"bofang3"],[UIImage imageNamed:@"bofang1"],[UIImage imageNamed:@"bofang2"],[UIImage imageNamed:@"bofang3"],nil];
        
        _animationview.animationImages = myImages;
        _animationview.animationDuration = 2;
        _animationview.animationRepeatCount = 0; //动画重复次数，0表示无限循环
    }
    return _animationview;
}
@end
