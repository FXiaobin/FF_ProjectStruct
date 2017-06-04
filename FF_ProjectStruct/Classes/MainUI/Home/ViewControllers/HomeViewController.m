//
//  HomeViewController.m
//  FF_ProjectStruct
//
//  Created by fanxiaobin on 2017/6/1.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import "HomeViewController.h"
#import "NextViewController.h"

#define BannerView_Height   kSCALE(500.0)

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property  (nonatomic,strong) UITableView *tableView;

@property  (nonatomic,strong) UIView *navTopView;

@property  (nonatomic,strong) SDCycleScrollView *cycleScrollView;

@end

@implementation HomeViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.tableHeaderView = self.cycleScrollView;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    }
    return _tableView;
}

-(SDCycleScrollView *)cycleScrollView{
    if (_cycleScrollView == nil) {
        _cycleScrollView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,BannerView_Height)];
        _cycleScrollView.currentPageDotColor = MAIN_COLOR;
        _cycleScrollView.imageURLStringsGroup = @[@"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=695501802,258418055&fm=23&gp=0.jpg",
                                                  @"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2437762035,2994278153&fm=23&gp=0.jpg",
                                                  @"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3591804592,290010643&fm=23&gp=0.jpg"];
    }
    return _cycleScrollView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.tableView];
    
    self.navTopView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    self.navTopView.backgroundColor = MAIN_COLOR;
    self.navTopView.alpha = 0.0;
    
    [self.view addSubview:self.navTopView];
    
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    
    
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offy = scrollView.contentOffset.y;
    CGFloat height = BannerView_Height;
    
    if (offy > 0) {
        
        CGFloat alpha = (offy+64) / height;
        if (alpha > 1.0) {
            alpha = 1.0;
        }
        NSLog(@"--offy = %.1f, heigh = %.1f , alpha = %.1f",offy, BannerView_Height,alpha);
        self.navTopView.alpha = alpha;
    }else{
        self.navTopView.alpha = 0.0;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NextViewController *vc = [[NextViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
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
