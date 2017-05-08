//
//  UIViewController+NavigationBar.m
//  MDNavigationBar
//
//  Created by 张雁军 on 2017/5/8.
//  Copyright © 2017年 smlkts. All rights reserved.
//

#import "UIViewController+NavigationBar.h"
#import <objc/runtime.h>

@implementation UIViewController (NavigationBar)

#pragma mark -

static void *overlayKey = &overlayKey;

- (UIView *)overlay{
    return objc_getAssociatedObject(self, overlayKey);
}

- (void)setOverlay:(UIView *)overlay{
    objc_setAssociatedObject(self, overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark -

- (void)fd_setNavigationBarColor:(UIColor *)color{
    if (!self.overlay) {
        CGFloat statusBarHeight = CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
        CGFloat navigationBarHeight = CGRectGetHeight(self.navigationController.navigationBar.bounds);
        UIView *overlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.navigationController.navigationBar.bounds), navigationBarHeight + statusBarHeight)];
        overlay.userInteractionEnabled = NO;
        overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        //        overlay.backgroundColor = [color colorWithAlphaComponent:0];
        overlay.alpha = 0;
        overlay.backgroundColor = color;
        self.overlay = overlay;
    }
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = self.overlay.alpha<0.5? [[UIImage alloc] init]: nil;
    [[self.navigationController.navigationBar.subviews firstObject] insertSubview:self.overlay atIndex:0];
}

- (void)fd_setNavigationBarAlpha:(CGFloat)alpha{
    self.navigationController.navigationBar.shadowImage = alpha < 0.5? [[UIImage alloc] init]: nil;
    self.overlay.alpha = alpha;
    //    self.overlay.backgroundColor = [self.overlay.backgroundColor colorWithAlphaComponent:alpha];
}

- (void)fd_recoverNavigationBar{
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = nil;
    [self.overlay removeFromSuperview];
}

- (void)fd_fadeWithOffset:(CGFloat)offset threshold:(CGFloat)threshold headerHeight:(CGFloat)headerHeight{
    if (offset > threshold) {
        CGFloat statusBarheight = CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
        CGFloat navigationBarheight = CGRectGetHeight(self.navigationController.navigationBar.bounds);
        CGFloat scrollHeight = headerHeight - statusBarheight - navigationBarheight;
        CGFloat alpha = MIN(1, (offset - threshold) / scrollHeight);
        [self fd_setNavigationBarAlpha:alpha];
    } else {
        [self fd_setNavigationBarAlpha:0];
    }
}

@end
