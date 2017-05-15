//
//  DemoViewController.m
//  MDNavigationBar
//
//  Created by 张雁军 on 2017/5/8.
//  Copyright © 2017年 smlkts. All rights reserved.
//

#import "DemoViewController.h"
#import "UIViewController+NavigationBar.h"

@interface DemoViewController ()

@end

@implementation DemoViewController

static NSString * const reuse = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    self.navigationItem.prompt = @"prompt";
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuse];
    self.tableView.rowHeight = 60;
    UIImageView *header = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 250)];
    header.image = [UIImage imageNamed:@"rio.jpg"];
    header.contentMode = UIViewContentModeScaleAspectFill;
    self.tableView.tableHeaderView = header;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - implementation method

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationBarBackgroundImage = [UIImage imageNamed:@"750"];
    self.navigationBarBackgroundColor = [UIColor cyanColor];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self fd_recoverNavigationBar];
}

#define implementByYourself

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
#ifdef implementByYourself
    //如果想要自己实现
    CGFloat offsetY = scrollView.contentOffset.y;
    // 设置临界值 超过多少才开始渐隐/显示
    CGFloat threshold = 0.f;
    if (offsetY > threshold) {
        // 设置完全透明/不透明需要滑动的距离
        //头部正好滑动到底部与导航栏底部对齐的时候 导航栏完全不透明
        CGFloat statusBarheight = CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
        CGFloat navigationBarheight = CGRectGetHeight(self.navigationController.navigationBar.bounds);
        CGFloat scrollHeight = self.tableView.tableHeaderView.bounds.size.height - statusBarheight - navigationBarheight;
        CGFloat alpha = MIN(1, (offsetY - threshold) / scrollHeight);
        [self fd_setNavigationBarAlpha:alpha];
        
        //顺便把标题隐藏/显示
        if (alpha == 1.f) {
            self.navigationItem.title = @"Title";
        }else{
            self.navigationItem.title = @"";
        }
        
    } else {
        [self fd_setNavigationBarAlpha:0];
        //顺便把标题隐藏/显示
        self.navigationItem.title = @"";
    }
#else
    //如果不自己实现 套用现成的
    [self fd_fadeWithOffset:scrollView.contentOffset.y threshold:0 headerHeight:self.tableView.tableHeaderView.bounds.size.height];
#endif
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor redColor];
    [self.navigationController pushViewController:vc animated:YES];
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:; forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
