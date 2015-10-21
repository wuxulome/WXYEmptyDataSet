//
//  UIScrollView+WXYEmptyDataSet.m
//  Pods
//
//  Created by wuxu on 10/21/2015.
//  Copyright (c) 2015 wuxu. All rights reserved.
//

#import "UIScrollView+WXYEmptyDataSet.h"
#import <objc/runtime.h>

static NSInteger const wxy_mainBgView_tag    = 92011;
static NSInteger const wxy_titleLabel_tag    = 92012;
static NSInteger const wxy_detailLabel_tag   = 92013;
static NSInteger const wxy_indicatorView_tag = 92014;

static char const *const wxy_reloadBlockKey = "wxy_reloadBlock";
static char const *const wxy_gestureRecognizerKey = "wxy_gestureRecognizerKey";

@implementation UIScrollView (WXYEmptyDataSet)
@dynamic wxy_titleFont;
@dynamic wxy_titleColor;
@dynamic wxy_titleFontSize;
@dynamic wxy_detailFont;
@dynamic wxy_detailColor;
@dynamic wxy_detailFontSize;

#pragma mark -

- (void)wxy_setEmptyWithTitle:(NSString *)title
{
    [self wxy_setEmptyWithTitle:title detail:nil image:nil reload:nil];
}

- (void)wxy_setEmptyWithImage:(UIImage *)image
{
    [self wxy_setEmptyWithTitle:nil detail:nil image:image reload:nil];
}

- (void)wxy_setEmptyWithView:(UIView *)view
{
    [self wxy_setEmptyWithTitle:nil detail:nil view:view reload:nil];
}

- (void)wxy_setEmptyWithTitle:(NSString *)title detail:(NSString *)detail
{
    [self wxy_setEmptyWithTitle:title detail:detail image:nil reload:nil];
}

- (void)wxy_setEmptyWithTitle:(NSString *)title image:(UIImage *)image
{
    [self wxy_setEmptyWithTitle:title detail:nil image:image reload:nil];
}

- (void)wxy_setEmptyWithTitle:(NSString *)title view:(UIView *)view
{
    [self wxy_setEmptyWithTitle:title detail:nil view:view reload:nil];
}

- (void)wxy_setEmptyWithTitle:(NSString *)title detail:(NSString *)detail image:(UIImage *)image
{
    [self wxy_setEmptyWithTitle:title detail:detail image:image reload:nil];
}

- (void)wxy_setEmptyWithTitle:(NSString *)title detail:(NSString *)detail view:(UIView *)view
{
    [self wxy_setEmptyWithTitle:title detail:detail view:view reload:nil];
}

#pragma mark -

- (void)wxy_setEmptyWithTitle:(NSString *)title reload:(void (^)(void))reload
{
    [self wxy_setEmptyWithTitle:title detail:nil image:nil reload:reload];
}

- (void)wxy_setEmptyWithImage:(UIImage *)image reload:(void (^)(void))reload
{
    [self wxy_setEmptyWithTitle:nil detail:nil image:image reload:reload];
}

- (void)wxy_setEmptyWithView:(UIView *)view reload:(void (^)(void))reload
{
    [self wxy_setEmptyWithTitle:nil detail:nil view:view reload:reload];
}

- (void)wxy_setEmptyWithTitle:(NSString *)title detail:(NSString *)detail reload:(void (^)(void))reload
{
    [self wxy_setEmptyWithTitle:title detail:detail image:nil reload:reload];
}

- (void)wxy_setEmptyWithTitle:(NSString *)title image:(UIImage *)image reload:(void (^)(void))reload
{
    [self wxy_setEmptyWithTitle:title detail:nil image:image reload:reload];
}

- (void)wxy_setEmptyWithTitle:(NSString *)title view:(UIView *)view reload:(void (^)(void))reload
{
    [self wxy_setEmptyWithTitle:title detail:nil view:view reload:reload];
}

- (void)wxy_setEmptyWithTitle:(NSString *)title detail:(NSString *)detail image:(UIImage *)image reload:(void (^)(void))reload
{
    if (image) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.backgroundColor = [UIColor clearColor];
        
        [self wxy_setEmptyWithTitle:title detail:detail view:imageView reload:reload];
    } else {
        [self wxy_setEmptyWithTitle:title detail:detail view:nil reload:reload];
    }
}

- (void)wxy_setEmptyWithTitle:(NSString *)title detail:(NSString *)detail view:(UIView *)view reload:(void (^)(void))reload
{
    [self wxy_clearBackground];
    
    CGFloat height = 0;
    
    if (view) {
        height += CGRectGetHeight(view.frame);
    }
    
    CGSize titleTextSize;
    if (title.length > 0) {
        titleTextSize = [title sizeWithFont:[UIFont systemFontOfSize:[self wxy_titleFontSize]]
                            constrainedToSize:CGSizeMake(CGRectGetWidth(self.frame), MAXFLOAT)
                                lineBreakMode:NSLineBreakByWordWrapping];
        height += titleTextSize.height;
    }
    
    CGSize detailTextSize;
    if (detail.length > 0) {
        CGSize detailTextSize = [detail sizeWithFont:[UIFont systemFontOfSize:[self wxy_detailFontSize]]
                            constrainedToSize:CGSizeMake(CGRectGetWidth(self.frame), MAXFLOAT)
                                lineBreakMode:NSLineBreakByWordWrapping];
        height += detailTextSize.height;
    }
    
    UIView *mainBgView = [[UIView alloc] initWithFrame:CGRectMake(0, (CGRectGetHeight(self.frame)-height)/2, CGRectGetWidth(self.frame), height)];
    mainBgView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    mainBgView.backgroundColor = [UIColor clearColor];
    mainBgView.tag = wxy_mainBgView_tag;
    [self addSubview:mainBgView];
    
    if (view) {
        view.frame = CGRectMake((CGRectGetWidth(mainBgView.frame) - CGRectGetWidth(view.frame))/2,
                                (CGRectGetHeight(mainBgView.frame) - CGRectGetHeight(view.frame))/2,
                                CGRectGetWidth(view.frame),
                                CGRectGetHeight(view.frame));
        view.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [mainBgView addSubview:view];
    }
    
    if (title.length > 0) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view.frame), CGRectGetWidth(mainBgView.frame), titleTextSize.height)];
        titleLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [self wxy_titleFont];
        titleLabel.textColor = [self wxy_titleColor];
        titleLabel.text = title;
        titleLabel.tag = wxy_titleLabel_tag;
        titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        titleLabel.numberOfLines = 0;
        [mainBgView addSubview:titleLabel];
    }
    
    if (detail.length > 0) {
        UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(mainBgView.frame) - detailTextSize.height, CGRectGetWidth(mainBgView.frame), detailTextSize.height)];
        detailLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        detailLabel.backgroundColor = [UIColor clearColor];
        detailLabel.textAlignment = NSTextAlignmentCenter;
        detailLabel.font = [self wxy_detailFont];
        detailLabel.textColor = [self wxy_detailColor];
        detailLabel.text = detail;
        detailLabel.tag = wxy_detailLabel_tag;
        detailLabel.lineBreakMode = NSLineBreakByWordWrapping;
        detailLabel.numberOfLines = 0;
        [mainBgView addSubview:detailLabel];
    }
    
    if (reload) {
        objc_setAssociatedObject(self, wxy_reloadBlockKey, reload, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(wxy_retry:)];
        tapRecognizer.cancelsTouchesInView = NO;
        [mainBgView addGestureRecognizer:tapRecognizer];
        objc_setAssociatedObject(self, wxy_gestureRecognizerKey, tapRecognizer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

#pragma mark - 点击重试响应

- (void)wxy_retry:(UIGestureRecognizer *)gestureRecognizer
{
    void(^block)() = objc_getAssociatedObject(self, wxy_reloadBlockKey);
    if (block) {
        UIView *mainBgView = [self viewWithTag:wxy_mainBgView_tag];
        [mainBgView removeFromSuperview];
        UIActivityIndicatorView *activityView = (UIActivityIndicatorView *)[self viewWithTag:wxy_indicatorView_tag];
        if (!activityView) {
            activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            activityView.tag = wxy_indicatorView_tag;
        }
        activityView.frame = CGRectMake((CGRectGetWidth(self.frame) - 30) / 2,(CGRectGetHeight(self.frame) - 30) / 2, 30, 30);
        [self addSubview:activityView];
        [activityView startAnimating];
        block();
    }
}

#pragma mark -

- (BOOL)wxy_startReload
{
    void(^block)() = objc_getAssociatedObject(self, wxy_reloadBlockKey);
    if (block) {
        [self wxy_retry:nil];
        return YES;
    }
    return NO;
}

- (void)wxy_clearBackground
{
    UIView *mainBgView = [self viewWithTag:wxy_mainBgView_tag];
    if (mainBgView) {
        [mainBgView removeFromSuperview];
    }
    
    UIActivityIndicatorView *activityView = (UIActivityIndicatorView *) [self viewWithTag:wxy_indicatorView_tag];
    if (activityView) {
        [activityView stopAnimating];
        [activityView removeFromSuperview];
    }
    
    id block = objc_getAssociatedObject(self, wxy_reloadBlockKey);
    if (block) {
        objc_setAssociatedObject(self, wxy_reloadBlockKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    block = nil;
    
    UIGestureRecognizer *recognizer = objc_getAssociatedObject(self, wxy_gestureRecognizerKey);
    if (recognizer) {
        [self removeGestureRecognizer:recognizer];
        objc_setAssociatedObject(self, wxy_gestureRecognizerKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    recognizer = nil;
}

#pragma mark - Property Getter & Setter

//wxy_titleFontSize
- (CGFloat)wxy_titleFontSize
{
    return [objc_getAssociatedObject(self, @selector(wxy_titleFontSize)) floatValue];
}
- (void)setWxy_titleFontSize:(CGFloat)wxy_titleFontSize
{
    objc_setAssociatedObject(self, @selector(wxy_detailFontSize), @(wxy_titleFontSize), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//wxy_titleColor
- (UIColor *)wxy_titleColor
{
    return objc_getAssociatedObject(self, @selector(wxy_titleColor));
}
- (void)setWxy_titleColor:(UIColor *)wxy_titleColor
{
    objc_setAssociatedObject(self, @selector(wxy_titleColor), wxy_titleColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//wxy_titleFont
- (UIFont *)wxy_titleFont
{
    return objc_getAssociatedObject(self, @selector(wxy_titleFont));
}
- (void)setWxy_titleFont:(UIFont *)wxy_titleFont
{
    objc_setAssociatedObject(self, @selector(wxy_titleFont), wxy_titleFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//wxy_detailFontSize
- (CGFloat)wxy_detailFontSize
{
    return [objc_getAssociatedObject(self, @selector(wxy_detailFontSize)) floatValue];
}
- (void)setWxy_detailFontSize:(CGFloat)wxy_detailFontSize
{
    objc_setAssociatedObject(self, @selector(wxy_detailFontSize), @(wxy_detailFontSize), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//wxy_detailColor
- (UIColor *)wxy_detailColor
{
    return objc_getAssociatedObject(self, @selector(wxy_detailColor));
}
- (void)setWxy_detailColor:(UIColor *)wxy_detailColor
{
    objc_setAssociatedObject(self, @selector(wxy_detailColor), wxy_detailColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//wxy_detailFont
- (UIFont *)wxy_detailFont
{
    return objc_getAssociatedObject(self, @selector(wxy_detailFont));
}
- (void)setWxy_detailFont:(UIFont *)wxy_detailFont
{
    objc_setAssociatedObject(self, @selector(wxy_detailFont), wxy_detailFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
