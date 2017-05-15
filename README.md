# MDNavigationBar
[简书链接](http://www.jianshu.com/p/659debfe0493)
- 这是一个UIViewController的category，实现当scrollview滚动时其所属UINavigationController的NavigationBar渐隐的效果
- 解决
1.很多第三方库在iOS7以上右滑返回之后就会错乱的问题
2.可以同时存在prompt
3.可以使用image或颜色做导航栏背景

 ![](https://github.com/smlkts/MDNavigationBar/raw/master/01.gif) 
 ![](https://github.com/smlkts/MDNavigationBar/raw/master/01.gif)

 - 用法
```objective-c
 - (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //用图片做导航栏背景
	self.navigationBarBackgroundImage = [UIImage imageNamed:@"750"];
	//or 二选一
	//用颜色做导航栏背景
    self.navigationBarBackgroundColor = [UIColor cyanColor];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //required
    [self fd_recoverNavigationBar];
}

//如果想要自己实现滚动时渐隐效果
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
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
}

//or 
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self fd_fadeWithOffset:scrollView.contentOffset.y threshold:0 headerHeight:self.tableView.tableHeaderView.bounds.size.height];
}

```
