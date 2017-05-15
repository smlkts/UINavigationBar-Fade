//
//  UIViewController+NavigationBar.h
//  MDNavigationBar
//
//  Created by 张雁军 on 2017/5/8.
//  Copyright © 2017年 smlkts. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (NavigationBar)
@property (nonatomic, strong) UIImage *navigationBarBackgroundImage;///<初始化设置当前导航栏的图片 同时将背景设置为透明
@property (nonatomic, strong) UIColor *navigationBarBackgroundColor;///<初始化设置当前导航栏需要渐隐的背景颜色 同时将背景设置为透明
- (void)fd_setNavigationBarAlpha:(CGFloat)alpha;///<设置背景的透明度
- (void)fd_recoverNavigationBar;///<还原导航栏

/**
 *  scroll滑动的时候渐隐
 *
 *  @param offset 指的是scrollview当前的contentOffset.y
 *  @param threshold 设置滑动距离超过多少才开始渐隐/显示的临界值
 *  @param headerHeight 一般来说都会有个头部视图 头部底部正好滑动到与导航栏底部对齐的时候 导航栏完全不透明 这里只需要传头部的高度 实现里会减掉状态栏和导航栏的高度
 *
 */
- (void)fd_fadeWithOffset:(CGFloat)offset threshold:(CGFloat)threshold headerHeight:(CGFloat)headerHeight;
@end
