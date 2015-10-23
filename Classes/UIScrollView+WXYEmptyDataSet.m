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

static char const *const wxy_reloadBlockKey       = "wxy_reloadBlock";
static char const *const wxy_gestureRecognizerKey = "wxy_gestureRecognizerKey";

@implementation UIScrollView (WXYEmptyDataSet)
@dynamic wxy_titleFont;
@dynamic wxy_titleColor;
@dynamic wxy_titleFontSize;
@dynamic wxy_detailFont;
@dynamic wxy_detailColor;
@dynamic wxy_detailFontSize;
@dynamic wxy_wholeVerticalOffset;
@dynamic wxy_wholeInsets;
@dynamic wxy_imageToUnderGroupSpacing;
@dynamic wxy_titleToUnderGroupSpacing;
@dynamic wxy_detailToUnderGroupSpacing;

#pragma mark -

- (void)wxy_setEmptyWithTitle:(NSString *)title
{
    [self wxy_setEmptyWithView:nil title:title detail:nil reload:nil];
}
- (void)wxy_setEmptyWithTitle:(NSString *)title reload:(void (^)(void))reload
{
    [self wxy_setEmptyWithView:nil title:title detail:nil reload:reload];
}

- (void)wxy_setEmptyWithImage:(UIImage *)image
{
    [self wxy_setEmptyWithImage:image title:nil detail:nil reload:nil];
}
- (void)wxy_setEmptyWithImage:(UIImage *)image reload:(void (^)(void))reload
{
    [self wxy_setEmptyWithImage:image title:nil detail:nil reload:reload];
}

- (void)wxy_setEmptyWithView:(UIView *)view
{
    [self wxy_setEmptyWithView:view title:nil detail:nil reload:nil];
}
- (void)wxy_setEmptyWithView:(UIView *)view reload:(void (^)(void))reload
{
    [self wxy_setEmptyWithView:view title:nil detail:nil reload:reload];
}

- (void)wxy_setEmptyWithTitle:(NSString *)title detail:(NSString *)detail
{
    [self wxy_setEmptyWithView:nil title:title detail:detail reload:nil];
}
- (void)wxy_setEmptyWithTitle:(NSString *)title detail:(NSString *)detail reload:(void (^)(void))reload
{
    [self wxy_setEmptyWithView:nil title:title detail:detail reload:reload];
}

- (void)wxy_setEmptyWithImage:(UIImage *)image title:(NSString *)title
{
    [self wxy_setEmptyWithImage:image title:title detail:nil reload:nil];
}
- (void)wxy_setEmptyWithImage:(UIImage *)image title:(NSString *)title reload:(void (^)(void))reload
{
    [self wxy_setEmptyWithImage:image title:title detail:nil reload:reload];
}

- (void)wxy_setEmptyWithImage:(UIImage *)image title:(NSString *)title detail:(NSString *)detail
{
    [self wxy_setEmptyWithImage:image title:title detail:detail reload:nil];
}
- (void)wxy_setEmptyWithImage:(UIImage *)image title:(NSString *)title detail:(NSString *)detail reload:(void (^)(void))reload
{
    if (image) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.backgroundColor = [UIColor clearColor];
        
        [self wxy_setEmptyWithView:imageView title:title detail:detail reload:reload];
    } else {
        [self wxy_setEmptyWithView:nil title:title detail:detail reload:reload];
    }
}

- (void)wxy_setEmptyWithView:(UIView *)view title:(NSString *)title detail:(NSString *)detail
{
    [self wxy_setEmptyWithView:view title:title detail:detail reload:nil];
}
- (void)wxy_setEmptyWithView:(UIView *)view title:(NSString *)title detail:(NSString *)detail reload:(void (^)(void))reload
{
    [self wxy_clearBackground];
    
    CGFloat height = 0;
    
    if (view) {
        height += CGRectGetHeight(view.frame);
        
        if (title.length > 0 || detail.length > 0) {
            height += [self wxy_imageToUnderGroupSpacing];
        }
    }
    
    CGSize titleTextSize;
    if (title.length > 0) {
        titleTextSize = [title sizeWithFont:[UIFont systemFontOfSize:[self wxy_titleFontSize]]
                          constrainedToSize:CGSizeMake(CGRectGetWidth(self.frame), MAXFLOAT)
                              lineBreakMode:NSLineBreakByWordWrapping];
        height += titleTextSize.height;
        
        if (detail.length > 0) {
            height += [self wxy_titleToUnderGroupSpacing];
        }
    }
    
    CGSize detailTextSize;
    if (detail.length > 0) {
        detailTextSize = [detail sizeWithFont:[UIFont systemFontOfSize:[self wxy_detailFontSize]]
                                   constrainedToSize:CGSizeMake(CGRectGetWidth(self.frame), MAXFLOAT)
                                       lineBreakMode:NSLineBreakByWordWrapping];
        height += detailTextSize.height;
    }
    
    UIView *mainBgView = [[UIView alloc] initWithFrame:CGRectMake([self wxy_wholeInsets].left,
                                                                  (CGRectGetHeight(self.frame) - height)/2 + [self wxy_wholeVerticalOffset],
                                                                  CGRectGetWidth(self.frame) - [self wxy_wholeInsets].left - [self wxy_wholeInsets].right,
                                                                  height)];
    mainBgView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    mainBgView.backgroundColor = [UIColor clearColor];
    mainBgView.tag = wxy_mainBgView_tag;
    [self addSubview:mainBgView];
    
    CGFloat y = 0;
    
    if (view) {
        view.frame = CGRectMake((CGRectGetWidth(mainBgView.frame) - CGRectGetWidth(view.frame))/2, y, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame));
        view.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [mainBgView addSubview:view];
        
        y += CGRectGetMaxY(view.frame);
        y += [self wxy_imageToUnderGroupSpacing];
    }
    
    if (title.length > 0) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, y, CGRectGetWidth(mainBgView.frame), titleTextSize.height)];
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
        
        y += CGRectGetMaxY(titleLabel.frame);
        y += [self wxy_titleToUnderGroupSpacing];
    }
    
    if (detail.length > 0) {
        UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, y, CGRectGetWidth(mainBgView.frame), detailTextSize.height)];
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

- (void)wxy_setEmptyWithButton:(UIButton *)button
{
    [self wxy_setEmptyWithView:nil title:nil detail:nil button:button];
}
- (void)wxy_setEmptyWithTitle:(NSString *)title button:(UIButton *)button
{
    [self wxy_setEmptyWithView:nil title:title detail:nil button:button];
}
- (void)wxy_setEmptyWithTitle:(NSString *)title detail:(NSString *)detail button:(UIButton *)button
{
    [self wxy_setEmptyWithView:nil title:title detail:detail button:button];
}
- (void)wxy_setEmptyWithImage:(UIImage *)image button:(UIButton *)button
{
    [self wxy_setEmptyWithImage:image title:nil detail:nil button:button];
}
- (void)wxy_setEmptyWithImage:(UIImage *)image title:(NSString *)title button:(UIButton *)button
{
    [self wxy_setEmptyWithImage:image title:title detail:nil button:button];
}
- (void)wxy_setEmptyWithImage:(UIImage *)image title:(NSString *)title detail:(NSString *)detail button:(UIButton *)button
{
    if (image) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.backgroundColor = [UIColor clearColor];
        
        [self wxy_setEmptyWithView:imageView title:title detail:detail button:button];
    } else {
        [self wxy_setEmptyWithView:nil title:title detail:detail button:button];
    }
}
- (void)wxy_setEmptyWithView:(UIView *)view title:(NSString *)title detail:(NSString *)detail button:(UIButton *)button
{
    [self wxy_clearBackground];
    
    CGFloat height = 0;
    
    if (view) {
        height += CGRectGetHeight(view.frame);
        
        if (title.length > 0 || detail.length > 0 || button) {
            height += [self wxy_imageToUnderGroupSpacing];
        }
    }
    
    CGSize titleTextSize;
    if (title.length > 0) {
        titleTextSize = [title sizeWithFont:[UIFont systemFontOfSize:[self wxy_titleFontSize]]
                          constrainedToSize:CGSizeMake(CGRectGetWidth(self.frame), MAXFLOAT)
                              lineBreakMode:NSLineBreakByWordWrapping];
        height += titleTextSize.height;
        
        if (detail.length > 0 || button) {
            height += [self wxy_titleToUnderGroupSpacing];
        }
    }
    
    CGSize detailTextSize;
    if (detail.length > 0) {
        detailTextSize = [detail sizeWithFont:[UIFont systemFontOfSize:[self wxy_detailFontSize]]
                            constrainedToSize:CGSizeMake(CGRectGetWidth(self.frame), MAXFLOAT)
                                lineBreakMode:NSLineBreakByWordWrapping];
        height += detailTextSize.height;
        
        if (button) {
            height += [self wxy_detailToUnderGroupSpacing];
        }
    }
    
    if (button) {
        height += CGRectGetHeight(button.frame);
    }
    
    UIView *mainBgView = [[UIView alloc] initWithFrame:CGRectMake([self wxy_wholeInsets].left,
                                                                  (CGRectGetHeight(self.frame) - height)/2 + [self wxy_wholeVerticalOffset],
                                                                  CGRectGetWidth(self.frame) - [self wxy_wholeInsets].left - [self wxy_wholeInsets].right,
                                                                  height)];
    mainBgView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    mainBgView.backgroundColor = [UIColor clearColor];
    mainBgView.tag = wxy_mainBgView_tag;
    [self addSubview:mainBgView];
    
    CGFloat y = 0;
    
    if (view) {
        view.frame = CGRectMake((CGRectGetWidth(mainBgView.frame) - CGRectGetWidth(view.frame))/2, y, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame));
        view.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [mainBgView addSubview:view];
        
        y += CGRectGetMaxY(view.frame);
        y += [self wxy_imageToUnderGroupSpacing];
    }
    
    if (title.length > 0) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, y, CGRectGetWidth(mainBgView.frame), titleTextSize.height)];
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
        
        y += CGRectGetMaxY(titleLabel.frame);
        y += [self wxy_titleToUnderGroupSpacing];
    }
    
    if (detail.length > 0) {
        UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, y, CGRectGetWidth(mainBgView.frame), detailTextSize.height)];
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
        
        y += CGRectGetMaxY(detailLabel.frame);
        y += [self wxy_detailToUnderGroupSpacing];
    }
    
    if (button) {
        button.frame = CGRectMake((CGRectGetWidth(mainBgView.frame) - CGRectGetWidth(button.frame))/2, y, CGRectGetWidth(button.frame), CGRectGetHeight(button.frame));
        [mainBgView addSubview:button];
    }
}

#pragma mark -

- (void)wxy_setEmptyWithAttributedTitle:(NSAttributedString *)title
{
    [self wxy_setEmptyWithView:nil attributedTitle:title attributedDetail:nil reload:nil];
}
- (void)wxy_setEmptyWithAttributedTitle:(NSAttributedString *)title reload:(void (^)(void))reload
{
    [self wxy_setEmptyWithView:nil attributedTitle:title attributedDetail:nil reload:reload];
}

- (void)wxy_setEmptyWithAttributedTitle:(NSAttributedString *)title attributedDetail:(NSAttributedString *)detail
{
    [self wxy_setEmptyWithView:nil attributedTitle:title attributedDetail:detail reload:nil];
}
- (void)wxy_setEmptyWithAttributedTitle:(NSAttributedString *)title attributedDetail:(NSAttributedString *)detail reload:(void (^)(void))reload
{
    [self wxy_setEmptyWithView:nil attributedTitle:title attributedDetail:detail reload:reload];
}

- (void)wxy_setEmptyWithImage:(UIImage *)image attributedTitle:(NSAttributedString *)title
{
    [self wxy_setEmptyWithImage:image attributedTitle:title attributedDetail:nil reload:nil];
}
- (void)wxy_setEmptyWithImage:(UIImage *)image attributedTitle:(NSAttributedString *)title reload:(void (^)(void))reload
{
    [self wxy_setEmptyWithImage:image attributedTitle:title attributedDetail:nil reload:reload];
}

- (void)wxy_setEmptyWithImage:(UIImage *)image attributedTitle:(NSAttributedString *)title attributedDetail:(NSAttributedString *)detail
{
    [self wxy_setEmptyWithImage:image attributedTitle:title attributedDetail:detail reload:nil];
}
- (void)wxy_setEmptyWithImage:(UIImage *)image attributedTitle:(NSAttributedString *)title attributedDetail:(NSAttributedString *)detail reload:(void (^)(void))reload
{
    if (image) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.backgroundColor = [UIColor clearColor];
        
        [self wxy_setEmptyWithView:imageView attributedTitle:title attributedDetail:detail reload:reload];
    } else {
        [self wxy_setEmptyWithView:nil attributedTitle:title attributedDetail:detail reload:reload];
    }
}

- (void)wxy_setEmptyWithView:(UIView *)view attributedTitle:(NSAttributedString *)title attributedDetail:(NSAttributedString *)detail
{
    [self wxy_setEmptyWithView:view attributedTitle:title attributedDetail:detail reload:nil];
}
- (void)wxy_setEmptyWithView:(UIView *)view attributedTitle:(NSAttributedString *)title attributedDetail:(NSAttributedString *)detail reload:(void (^)(void))reload
{
    [self wxy_clearBackground];
    
    CGFloat height = 0;
    
    if (view) {
        height += CGRectGetHeight(view.frame);
        
        if (title.length > 0 || detail.length > 0) {
            height += [self wxy_imageToUnderGroupSpacing];
        }
    }
    
    CGRect titleTextRect;
    if (title.length > 0) {
        titleTextRect = [title boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.frame), MAXFLOAT)
                                                      options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                      context:nil];
        height += titleTextRect.size.height;
        
        if (detail.length > 0) {
            height += [self wxy_titleToUnderGroupSpacing];
        }
    }
    
    CGRect detailTextRect;
    if (detail.length > 0) {
        detailTextRect = [detail boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.frame), MAXFLOAT)
                                                        options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                        context:nil];
        height += detailTextRect.size.height;
    }
    
    UIView *mainBgView = [[UIView alloc] initWithFrame:CGRectMake([self wxy_wholeInsets].left,
                                                                  (CGRectGetHeight(self.frame) - height)/2 + [self wxy_wholeVerticalOffset],
                                                                  CGRectGetWidth(self.frame) - [self wxy_wholeInsets].left - [self wxy_wholeInsets].right,
                                                                  height)];
    mainBgView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    mainBgView.backgroundColor = [UIColor clearColor];
    mainBgView.tag = wxy_mainBgView_tag;
    [self addSubview:mainBgView];
    
    CGFloat y = 0;
    
    if (view) {
        view.frame = CGRectMake((CGRectGetWidth(mainBgView.frame) - CGRectGetWidth(view.frame))/2, y, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame));
        view.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [mainBgView addSubview:view];
        
        y += CGRectGetMaxY(view.frame);
        y += [self wxy_imageToUnderGroupSpacing];
    }
    
    if (title.length > 0) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, y, CGRectGetWidth(mainBgView.frame), titleTextRect.size.height)];
        titleLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.attributedText = title;
        titleLabel.tag = wxy_titleLabel_tag;
        titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        titleLabel.numberOfLines = 0;
        [mainBgView addSubview:titleLabel];
        
        y += CGRectGetMaxY(titleLabel.frame);
        y += [self wxy_titleToUnderGroupSpacing];
    }
    
    if (detail.length > 0) {
        UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, y, CGRectGetWidth(mainBgView.frame), detailTextRect.size.height)];
        detailLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        detailLabel.backgroundColor = [UIColor clearColor];
        detailLabel.textAlignment = NSTextAlignmentCenter;
        detailLabel.attributedText = detail;
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

- (void)wxy_setEmptyWithAttributedTitle:(NSAttributedString *)title button:(UIButton *)button
{
    [self wxy_setEmptyWithView:nil attributedTitle:nil attributedDetail:nil button:button];
}
- (void)wxy_setEmptyWithAttributedTitle:(NSAttributedString *)title attributedDetail:(NSAttributedString *)detail button:(UIButton *)button
{
    [self wxy_setEmptyWithView:nil attributedTitle:title attributedDetail:nil button:button];
}
- (void)wxy_setEmptyWithImage:(UIImage *)image attributedTitle:(NSAttributedString *)title button:(UIButton *)button
{
    [self wxy_setEmptyWithView:nil attributedTitle:title attributedDetail:nil button:button];
}
- (void)wxy_setEmptyWithImage:(UIImage *)image attributedTitle:(NSAttributedString *)title attributedDetail:(NSAttributedString *)detail button:(UIButton *)button
{
    if (image) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.backgroundColor = [UIColor clearColor];
        
        [self wxy_setEmptyWithView:imageView attributedTitle:title attributedDetail:detail button:button];
    } else {
        [self wxy_setEmptyWithView:nil attributedTitle:title attributedDetail:detail button:button];
    }
}
- (void)wxy_setEmptyWithView:(UIView *)view attributedTitle:(NSAttributedString *)title attributedDetail:(NSAttributedString *)detail button:(UIButton *)button
{
    [self wxy_clearBackground];
    
    CGFloat height = 0;
    
    if (view) {
        height += CGRectGetHeight(view.frame);
        
        if (title.length > 0 || detail.length > 0) {
            height += [self wxy_imageToUnderGroupSpacing];
        }
    }
    
    CGRect titleTextRect;
    if (title.length > 0) {
        titleTextRect = [title boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.frame), MAXFLOAT)
                                            options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                            context:nil];
        height += titleTextRect.size.height;
        
        if (detail.length > 0) {
            height += [self wxy_titleToUnderGroupSpacing];
        }
    }
    
    CGRect detailTextRect;
    if (detail.length > 0) {
        detailTextRect = [detail boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.frame), MAXFLOAT)
                                              options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                              context:nil];
        height += detailTextRect.size.height;
    }
    
    UIView *mainBgView = [[UIView alloc] initWithFrame:CGRectMake([self wxy_wholeInsets].left,
                                                                  (CGRectGetHeight(self.frame) - height)/2 + [self wxy_wholeVerticalOffset],
                                                                  CGRectGetWidth(self.frame) - [self wxy_wholeInsets].left - [self wxy_wholeInsets].right,
                                                                  height)];
    mainBgView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    mainBgView.backgroundColor = [UIColor clearColor];
    mainBgView.tag = wxy_mainBgView_tag;
    [self addSubview:mainBgView];
    
    CGFloat y = 0;
    
    if (view) {
        view.frame = CGRectMake((CGRectGetWidth(mainBgView.frame) - CGRectGetWidth(view.frame))/2, y, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame));
        view.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [mainBgView addSubview:view];
        
        y += CGRectGetMaxY(view.frame);
        y += [self wxy_imageToUnderGroupSpacing];
    }
    
    if (title.length > 0) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, y, CGRectGetWidth(mainBgView.frame), titleTextRect.size.height)];
        titleLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.attributedText = title;
        titleLabel.tag = wxy_titleLabel_tag;
        titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        titleLabel.numberOfLines = 0;
        [mainBgView addSubview:titleLabel];
        
        y += CGRectGetMaxY(titleLabel.frame);
        y += [self wxy_titleToUnderGroupSpacing];
    }
    
    if (detail.length > 0) {
        UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, y, CGRectGetWidth(mainBgView.frame), detailTextRect.size.height)];
        detailLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        detailLabel.backgroundColor = [UIColor clearColor];
        detailLabel.textAlignment = NSTextAlignmentCenter;
        detailLabel.attributedText = detail;
        detailLabel.tag = wxy_detailLabel_tag;
        detailLabel.lineBreakMode = NSLineBreakByWordWrapping;
        detailLabel.numberOfLines = 0;
        [mainBgView addSubview:detailLabel];
        
        y += CGRectGetMaxY(detailLabel.frame);
        y += [self wxy_detailToUnderGroupSpacing];
    }
    
    if (button) {
        button.frame = CGRectMake((CGRectGetWidth(mainBgView.frame) - CGRectGetWidth(button.frame))/2, y, CGRectGetWidth(button.frame), CGRectGetHeight(button.frame));
        [mainBgView addSubview:button];
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

- (CGFloat)wxy_titleFontSize
{
    NSNumber *number = objc_getAssociatedObject(self, @selector(wxy_titleFontSize));
    if (number) {
        return [number floatValue];
    } else {
        return 18.0f;
    }
}
- (void)setWxy_titleFontSize:(CGFloat)wxy_titleFontSize
{
    objc_setAssociatedObject(self, @selector(wxy_detailFontSize), @(wxy_titleFontSize), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)wxy_titleColor
{
    UIColor *color = objc_getAssociatedObject(self, @selector(wxy_titleColor));
    
    if (color) {
        return objc_getAssociatedObject(self, @selector(wxy_titleColor));
    } else {
        return [UIColor blackColor];
    }
}
- (void)setWxy_titleColor:(UIColor *)wxy_titleColor
{
    objc_setAssociatedObject(self, @selector(wxy_titleColor), wxy_titleColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIFont *)wxy_titleFont
{
    UIFont *font = objc_getAssociatedObject(self, @selector(wxy_titleFont));
    
    if (font) {
        return objc_getAssociatedObject(self, @selector(wxy_titleFont));
    } else {
        return [UIFont systemFontOfSize:[self wxy_titleFontSize]];
    }
}
- (void)setWxy_titleFont:(UIFont *)wxy_titleFont
{
    objc_setAssociatedObject(self, @selector(wxy_titleFont), wxy_titleFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)wxy_detailFontSize
{
    NSNumber *number = objc_getAssociatedObject(self, @selector(wxy_detailFontSize));
    if (number) {
        return [number floatValue];
    } else {
        return 14.0f;
    }
}
- (void)setWxy_detailFontSize:(CGFloat)wxy_detailFontSize
{
    objc_setAssociatedObject(self, @selector(wxy_detailFontSize), @(wxy_detailFontSize), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)wxy_detailColor
{
    UIColor *color = objc_getAssociatedObject(self, @selector(wxy_detailColor));
    
    if (color) {
        return objc_getAssociatedObject(self, @selector(wxy_detailColor));
    } else {
        return [UIColor blackColor];
    }
}
- (void)setWxy_detailColor:(UIColor *)wxy_detailColor
{
    objc_setAssociatedObject(self, @selector(wxy_detailColor), wxy_detailColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIFont *)wxy_detailFont
{
    UIFont *font = objc_getAssociatedObject(self, @selector(wxy_detailFont));
    
    if (font) {
        return objc_getAssociatedObject(self, @selector(wxy_detailFont));
    } else {
        return [UIFont systemFontOfSize:[self wxy_detailFontSize]];
    }
}
- (void)setWxy_detailFont:(UIFont *)wxy_detailFont
{
    objc_setAssociatedObject(self, @selector(wxy_detailFont), wxy_detailFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)wxy_wholeVerticalOffset
{
    NSNumber *number = objc_getAssociatedObject(self, @selector(wxy_wholeVerticalOffset)) ;
    if (number) {
        return [number floatValue];
    } else {
        return 0.0f;
    }
}
- (void)setWxy_wholeVerticalOffset:(CGFloat)wxy_wholeVerticalOffset
{
    objc_setAssociatedObject(self, @selector(wxy_wholeVerticalOffset), @(wxy_wholeVerticalOffset), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)wxy_wholeInsets
{
    NSValue *valueObj = objc_getAssociatedObject(self, @selector(wxy_wholeInsets));
    return [valueObj UIEdgeInsetsValue];
}
- (void)setWxy_wholeInsets:(UIEdgeInsets)wxy_wholeInsets
{
    NSValue *valueObj = [NSValue valueWithUIEdgeInsets:wxy_wholeInsets];
    objc_setAssociatedObject(self, @selector(wxy_wholeInsets), valueObj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)wxy_imageToUnderGroupSpacing
{
    NSNumber *number = objc_getAssociatedObject(self, @selector(wxy_imageToUnderGroupSpacing)) ;
    if (number) {
        return [number floatValue];
    } else {
        return 0.0f;
    }
}
- (void)setWxy_imageToUnderGroupSpacing:(CGFloat)wxy_imageToUnderGroupSpacing
{
    objc_setAssociatedObject(self, @selector(wxy_imageToUnderGroupSpacing), @(wxy_imageToUnderGroupSpacing), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)wxy_titleToUnderGroupSpacing
{
    NSNumber *number = objc_getAssociatedObject(self, @selector(wxy_titleToUnderGroupSpacing)) ;
    if (number) {
        return [number floatValue];
    } else {
        return 0.0f;
    }
}
- (void)setWxy_titleToUnderGroupSpacing:(CGFloat)wxy_titleToUnderGroupSpacing
{
    objc_setAssociatedObject(self, @selector(wxy_titleToUnderGroupSpacing), @(wxy_titleToUnderGroupSpacing), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)wxy_detailToUnderGroupSpacing
{
    NSNumber *number = objc_getAssociatedObject(self, @selector(wxy_detailToUnderGroupSpacing)) ;
    if (number) {
        return [number floatValue];
    } else {
        return 0.0f;
    }
}
- (void)setWxy_detailToUnderGroupSpacing:(CGFloat)wxy_detailToUnderGroupSpacing
{
    objc_setAssociatedObject(self, @selector(wxy_detailToUnderGroupSpacing), @(wxy_detailToUnderGroupSpacing), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
