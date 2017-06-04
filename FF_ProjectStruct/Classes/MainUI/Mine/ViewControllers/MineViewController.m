//
//  MineViewController.m
//  FF_ProjectStruct
//
//  Created by fanxiaobin on 2017/6/1.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import "MineViewController.h"
#import "NextViewController.h"

#define TopEdgesHeight   kSCALE(500)

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property  (nonatomic,strong) UITableView *tableView;

@property  (nonatomic,strong) UIImageView *topImageView;

@end

@implementation MineViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //[self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    self.tableView.scrollEnabled = YES;
    [self.navigationController.navigationBar setBackgroundAlpha:0.0];
    [self.tableView setContentOffset:CGPointMake(0, -TopEdgesHeight) animated:YES];
    
}

-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -64,SCREEN_WIDTH, SCREEN_HEIGHT-49) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.contentInset = UIEdgeInsetsMake(TopEdgesHeight, 0, 0, 0);
        _tableView.contentOffset = CGPointMake(0, -TopEdgesHeight);
        [_tableView addSubview:self.topImageView];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    }
    return _tableView;
}

-(UIImageView *)topImageView{
    if (_topImageView == nil) {
        _topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -TopEdgesHeight, SCREEN_WIDTH, TopEdgesHeight)];
        _topImageView.contentMode = UIViewContentModeScaleAspectFill;
        _topImageView.clipsToBounds = YES;
        _topImageView.image = [UIImage imageNamed:@"mine_topBg"];
        
    }
    return _topImageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.tableView];
    
  
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? 1 : 16;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.section == 0 ? kSCALE(260) : kSCALE(123.0);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return section == 0 ? kSCALE(100.0) : 0.01;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offy = scrollView.contentOffset.y;
    CGFloat height = TopEdgesHeight;
    
    if (offy+height < 0) {
        //下拉
        
        self.topImageView.frame = CGRectMake(0, -(TopEdgesHeight+fabs(offy+height)), SCREEN_WIDTH, TopEdgesHeight+fabs(offy+height));
        
        [self.navigationController.navigationBar setBackgroundAlpha:0.0];
        
    }else{

        self.topImageView.frame = CGRectMake(0, -TopEdgesHeight, SCREEN_WIDTH, TopEdgesHeight);
        
        CGFloat a = fabs(offy + height) / height;
        if (a > 1.0) {
            a = 1.0;
        }
        [self.navigationController.navigationBar setBackgroundAlpha:a];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   ///因为点击的时候仍然会调用一下tableView的滚动代理方法 会对导航条颜色设置照成影响
    self.tableView.scrollEnabled = NO;
    [self.navigationController.navigationBar setBackgroundAlpha:1.0];
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
