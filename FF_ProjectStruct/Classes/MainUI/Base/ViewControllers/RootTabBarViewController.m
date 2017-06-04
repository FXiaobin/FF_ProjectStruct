//
//  RootTabBarViewController.m
//  FF_ProjectStruct
//
//  Created by fanxiaobin on 2017/6/1.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import "RootTabBarViewController.h"
#import "HomeViewController.h"
#import "DiscoveryViewController.h"
#import "MessageViewController.h"
#import "MineViewController.h"

@interface RootTabBarViewController ()<UITabBarControllerDelegate>

@property (nonatomic) NSInteger indexFlag;


@end

@implementation RootTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.indexFlag = 0;
    self.delegate = self;
    
    NSArray *vcs = @[@"HomeViewController",@"DiscoveryViewController",@"MessageViewController",@"MineViewController"];
    NSArray *titles = @[@"首页",@"发现",@"消息",@"我的"];
    NSArray *images = @[@"home",@"discove",@"message",@"mine"];
    
    NSMutableArray *viewcontrollers = [NSMutableArray arrayWithCapacity:vcs.count];
    for (int i = 0; i < vcs.count; i++) {
        Class cls = NSClassFromString(vcs[i]);
        UIViewController *vc = [[cls alloc] init];
        
        UIImage *image = [[UIImage imageNamed:images[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *selectedImage = [[UIImage imageNamed:[images[i] stringByAppendingString:@"_Highlight"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
        
        UITabBarItem *barItem = [[UITabBarItem alloc] initWithTitle:titles[i] image:image selectedImage:selectedImage];
        barItem.titlePositionAdjustment = UIOffsetMake(0, -3);
       // barItem.imageInsets = UIEdgeInsetsMake(-2, 0, 2, 0);
        
        nc.tabBarItem = barItem;
        
        [viewcontrollers addObject:nc];
    }
    
    
    self.viewControllers = viewcontrollers;
    
    
    
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
    NSInteger index = [self.tabBar.items indexOfObject:item];
    
    if (self.indexFlag != index) {
        [self animationWithIndex:index];
    }
    
}

// 动画
- (void)animationWithIndex:(NSInteger) index {
    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }
    
    UIView *animationView = tabbarbuttonArray[index];
   
    UIImageView *imageView;
    for (UIView *sub in animationView.subviews) {
        if ([sub isKindOfClass:[UIImageView class]]) {
            imageView = (UIImageView *)sub;
        }
    }
    
    //缩放
    //[self scaleAnimationWithImageView:imageView];
    //抖动
    [self shakeImageWithImageView:imageView];
    
    self.indexFlag = index;
    
}


//缩放
- (void)scaleAnimationWithImageView:(UIImageView *)imageView{
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.values = @[@2.0 ,@0.5, @1.5, @0.8, @1.0];
    animation.duration = 0.5;
    animation.calculationMode = kCAAnimationCubic;
    [imageView.layer addAnimation:animation forKey:@"transform.scale"];
}

- (void)shakeImageWithImageView:(UIImageView *)imageView {
    //创建动画对象,绕Z轴旋转
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    //设置属性，周期时长
    [animation setDuration:0.1];
    
    //抖动角度
    animation.fromValue = @(-M_1_PI/2);
    animation.toValue = @(M_1_PI/2);
    //重复次数，1次
    animation.repeatCount = 2;
    //恢复原样
    animation.autoreverses = YES;
    //锚点设置为图片中心，绕中心抖动
    imageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    
    [imageView.layer addAnimation:animation forKey:@"rotation"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
