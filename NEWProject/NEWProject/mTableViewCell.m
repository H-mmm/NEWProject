//
//  mTableViewCell.m
//  NEWProject
//
//  Created by Saada_cnjp on 2017/3/18.
//  Copyright © 2017年 Oraganization XXX. All rights reserved.
//

#import "mTableViewCell.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define RATE WIDTH / 375
@interface mTableViewCell()
@property (nonatomic,strong) UIView *arrowView;
@property (nonatomic,strong) UIImageView *animationview;
@property (nonatomic,assign) NSInteger playing;
@end

@implementation mTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
//    NSLog(@"%f",_cellHeight);
    //留一个开关区分奇数次偶数次点击
//    if (selected == YES) {
//        NSLog(@"选中");
////        if (_playing == 0) {
////            _playing = 1;
////            [self.animationview stopAnimating];
////        } else {
////            _playing = 0;
////            [self.animationview startAnimating];
////        }
//    } else {
//         NSLog(@"没选中");
//        _playing = 1;
////        [_animationview stopAnimating];
//    }
//    NSLog(@"setSelected此时CELLHEight %f",_cellHeight);
    [self initView];
    }
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        NSLog(@"initWithStyle此时CELLHEight %f",_cellHeight);
        _playing = 1;
        //关掉自身动画的监听
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self selector:@selector(stopAllAnimation:) name:@"stopAllAnimation" object:nil];

    }
    return self;
}

- (void)initView{
    if (_cellHeight !=  0.0) {
        UIImageView *headImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"user"]];
        headImageView.frame = CGRectMake(10, 10, _cellHeight - 20, _cellHeight - 20 );
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(_cellHeight+5,10,10*_i+30,_cellHeight - 20)];
        [btn addTarget:self action:@selector(bofangdonghua) forControlEvents:UIControlEventTouchDown];
        [btn.layer setCornerRadius:7.0];
        [btn setBackgroundColor:[UIColor orangeColor]];
        _arrowView = [self arrowView:btn];
        _animationview = [self animationview:btn];
        UILabel *seconds = [[UILabel alloc]initWithFrame:CGRectMake(_cellHeight+40+ 10*_i, 10, 100, _cellHeight-20)];
        seconds.text = _str;
        seconds.textAlignment = NSTextAlignmentCenter;
        [btn addSubview:_arrowView];
        [btn addSubview:_animationview];
        btn.userInteractionEnabled = YES;
        [self.contentView addSubview:headImageView];
        [self.contentView addSubview:btn];
        [self.contentView addSubview:seconds];
//        self.contentView.transform = CGAffineTransformMakeRotation(180 *M_PI / 180.0);
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    } else {
        NSLog(@"为什么会等于0");
    }

}

- (void)bofangdonghua{
    if (_playing == 0) {
        _playing = 1;
        [self.animationview stopAnimating];
        //此处发送停止第几个录音的播放的广播
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        NSString *name = [NSString stringWithFormat:@"停止第%ld个录音",(long)_i];
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:name, @"A",nil];
        [nc postNotificationName:@"stopPlaying" object:self userInfo:dict];
    } else {
        _playing = 0;
        [self.animationview startAnimating];
        //此处发送开始播放第几个录音的广播
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        NSString *name = [NSString stringWithFormat:@"开始第%ld个录音",(long)_i];
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:name, @"A",nil];
        [nc postNotificationName:@"startPlaying" object:self userInfo:dict];
        //此处告诉所有的cell停止动画
        NSString *num = [NSString stringWithFormat:@"%ld",(long)_i];
        NSDictionary *dict1 = [NSDictionary dictionaryWithObjectsAndKeys:num, @"A",nil];
        [nc postNotificationName:@"stopAllAnimation" object:self userInfo:dict1];
    }
}
- (void) stopAllAnimation:(NSNotification *)notify{
    NSDictionary *dict = [notify userInfo];
    NSString *name = [dict objectForKey:@"A"];
    NSInteger num = [name integerValue];
    if (num != _i) {
        [_animationview stopAnimating];
        _playing = 1;
    }else{
        NSLog(@"不作为");
    }
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

//重写点击传递，让父子都有响应
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    NSLog(@"cell子类拿到响应");
////    [self bofangdonghua];
//    [super touchesBegan:touches withEvent:event];
//}

- (void) dealloc{
    NSLog(@"%ld 被注销了",(long)_i);
    if (_playing == 0) {
        
    } else {

    }
}

@end
