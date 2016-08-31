//
//  ViewController.m
//  CoreAnimation_Demo
//
//  Created by admin on 16/8/1.
//  Copyright © 2016年 AlezJi. All rights reserved.
//http://www.jianshu.com/p/79e6b1af520b
//核心动画

#import "ViewController.h"

@interface ViewController ()
@property(strong,nonatomic)UIView *redView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.redView =[[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    self.redView.backgroundColor =[UIColor redColor];
    [self.view addSubview:self.redView];

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self CABasicAnimationTest];
//    [self CAKeyframeAnimationTest];
//    [self CATransitionTest];
//    [self CAAnimationGroupTest];

}
#pragma mark -CABasicAnimationTest
-(void)CABasicAnimationTest{

    // 1.创建动画对象
    CABasicAnimation *anim = [CABasicAnimation animation];
    
    // 2.设置动画对象
    // keyPath决定了执行怎样的动画, 调整哪个属性来执行动画
    // position bounds transform
    anim.keyPath = @"position";
    // anim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 1, -1, 0)];
    // anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    // toValue : 最终变成什么值
    // byValue : 增加多少值
    anim.byValue = [NSValue valueWithCGPoint:CGPointMake(200, 300)];
    anim.duration = 2.0;
    
    /**让图层保持动画执行完毕后的状态**/
    // 动画执行完毕后不要删除动画
    anim.removedOnCompletion = NO;
    // 保持最新的状态
    anim.fillMode = kCAFillModeForwards;
    
    // 3.添加动画
    [self.redView.layer addAnimation:anim forKey:nil];
}
#define Angle2Radian(angle) ((angle) / 180.0 * M_PI)
#pragma mark -CAKeyframeAnimationTest
-(void)CAKeyframeAnimationTest{
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"transform.rotation";
    
    anim.values = @[@(Angle2Radian(-5)),  @(Angle2Radian(5)), @(Angle2Radian(-5))];
    anim.duration = 0.25;
    // 动画的重复执行次数
    anim.repeatCount = MAXFLOAT;
    
    // 保持动画执行完毕后的状态
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    
    [self.redView.layer addAnimation:anim forKey:@"shake"];
    // 移除
//    [self.redView.layer removeAnimationForKey:@"shake"];

}
#pragma mark - 动画的代理方法
// 动画开始的时候调用
- (void)animationDidStart:(CAAnimation *)anim
{
}
// 动画结束的时候调用
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
}
#pragma mark -CATransitionTest
-(void)CATransitionTest{
    CATransition *anim = [CATransition animation];
    anim.type = @"pageCurl";
    //    anim.subtype = kCATransitionFromRight; //动画方向
    anim.duration = 0.5;
    
    //    anim.startProgress = 0.0;
    //    anim.endProgress = 0.5;
    
    // type
    /*
    *  @"cube"                     立方体翻滚效果
    *  @"moveIn"                   新视图移到旧视图上面
    *  @"reveal"                   显露效果(将旧视图移开,显示下面的新视图)
    *  @"fade"                     交叉淡化过渡(不支持过渡方向)             (默认为此效果)
    *  @"pageCurl"                 向上翻一页
    *  @"pageUnCurl"               向下翻一页
    *  @"suckEffect"               收缩效果，类似系统最小化窗口时的神奇效果(不支持过渡方向)
    *  @"rippleEffect"             滴水效果,(不支持过渡方向)
    *  @"oglFlip"                  上下左右翻转效果
    *  @"rotate"                   旋转效果
    *  @"push"
    *  @"cameraIrisHollowOpen"     相机镜头打开效果(不支持过渡方向)
    *  @"cameraIrisHollowClose"    相机镜头关上效果(不支持过渡方向)
    */
}

#pragma mark -CAAnimationGroupTest

-(void)CAAnimationGroupTest{
    // 1.创建旋转动画对象
    CABasicAnimation *rotate = [CABasicAnimation animation];
    rotate.keyPath = @"transform.rotation";
    rotate.toValue = @(M_PI);
    
    // 2.创建缩放动画对象
    CABasicAnimation *scale = [CABasicAnimation animation];
    scale.keyPath = @"transform.scale";
    scale.toValue = @(0.0);
    
    // 3.平移动画
    CABasicAnimation *move = [CABasicAnimation animation];
    move.keyPath = @"transform.translation";
    move.toValue = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    
    // 4.将所有的动画添加到动画组中
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[rotate, scale, move];
    group.duration = 2.0;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    
    [self.redView.layer addAnimation:group forKey:nil];
    
}


@end
