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

@dynamic navigationBarBackgroundColor, navigationBarBackgroundImage;

#pragma mark - NavigationBarBackgroundImageView

static void *backgroundImageViewKey = &backgroundImageViewKey;

- (UIImageView *)backgroundImageView{
    return objc_getAssociatedObject(self, backgroundImageViewKey);
}

- (void)setBackgroundImageView:(UIImageView *)backgroundImageView{
    objc_setAssociatedObject(self, backgroundImageViewKey, backgroundImageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - NavigationBarBackgroundColor

static void *colorKey = &colorKey;

- (UIColor *)navigationBarBackgroundColor{
    return objc_getAssociatedObject(self, colorKey);
}

- (void)setNavigationBarBackgroundColor:(UIColor *)navigationBarBackgroundColor{
    if (self.navigationBarBackgroundColor == nil) {
        objc_setAssociatedObject(self, colorKey, navigationBarBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        self.backgroundImageView = [[UIImageView alloc] init];
        self.backgroundImageView.userInteractionEnabled = NO;
        CGFloat statusBarHeight = CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
        CGFloat navigationBarHeight = CGRectGetHeight(self.navigationController.navigationBar.bounds);
        self.backgroundImageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.navigationController.navigationBar.bounds), navigationBarHeight + statusBarHeight);
        self.backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.backgroundImageView.alpha = 0;
        self.backgroundImageView.backgroundColor = navigationBarBackgroundColor;
    }
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = self.backgroundImageView.alpha<0.5? [[UIImage alloc] init]: nil;
    [[self.navigationController.navigationBar.subviews firstObject] insertSubview:self.backgroundImageView atIndex:0];
    [self fd_layoutSubviews];
}

#pragma mark - NavigationBarBackgroundImage

static void *imageKey = &imageKey;

- (UIImage *)navigationBarBackgroundImage{
    return objc_getAssociatedObject(self, imageKey);
}

- (void)setNavigationBarBackgroundImage:(UIImage *)navigationBarBackgroundImage{
    if (self.navigationBarBackgroundImage == nil) {
        objc_setAssociatedObject(self, imageKey, navigationBarBackgroundImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        self.backgroundImageView = [[UIImageView alloc] init];
        self.backgroundImageView.userInteractionEnabled = NO;
        self.backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.backgroundImageView.alpha = 0;
        self.backgroundImageView.image = navigationBarBackgroundImage;
    }
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = self.backgroundImageView.alpha<0.5? [[UIImage alloc] init]: nil;
    [[self.navigationController.navigationBar.subviews firstObject] insertSubview:self.backgroundImageView atIndex:0];
    [self fd_layoutSubviews];
}

#pragma mark -

- (void)fd_layoutSubviews{
    CGFloat statusBarHeight = CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
    CGFloat navigationBarHeight = CGRectGetHeight(self.navigationController.navigationBar.bounds);
    self.backgroundImageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.navigationController.navigationBar.bounds), navigationBarHeight + statusBarHeight);
}

#pragma mark - Set NavigationBar Alpha

- (void)fd_setNavigationBarAlpha:(CGFloat)alpha{
    self.navigationController.navigationBar.shadowImage = alpha < 0.5? [[UIImage alloc] init]: nil;
    self.backgroundImageView.alpha = alpha;
}

#pragma mark - Reset NavigationBar to default

- (void)fd_recoverNavigationBar{
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = nil;
    [self.backgroundImageView removeFromSuperview];
}

#pragma mark - 

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
