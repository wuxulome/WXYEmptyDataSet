//
//  UIScrollView+WXYEmptyDataSet.h
//  Pods
//
//  Created by wuxu on 10/21/2015.
//  Copyright (c) 2015 wuxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (WXYEmptyDataSet)

@property (nonatomic, assign) CGFloat  wxy_titleFontSize; //default 18
@property (nonatomic, strong) UIColor *wxy_titleColor;    //default blackColor
@property (nonatomic, strong) UIFont  *wxy_titleFont;     //default systemFont. PS:because this value will use 'wxy_titleFontSize' property to init, so set                    'wxy_titleFontSize' first

@property (nonatomic, assign) CGFloat  wxy_detailFontSize;//default 14
@property (nonatomic, strong) UIColor *wxy_detailColor;   //default blackColor
@property (nonatomic, strong) UIFont  *wxy_detailFont;    //default systemFont. PS:because this value will use 'wxy_detailFontSize' property to init, so set 'wxy_detailFontSize' first

@property (nonatomic, assign) CGFloat wxy_wholeVerticalOffset;//default backView in UIScrollView center. -↑  +↓
@property (nonatomic, assign) UIEdgeInsets wxy_wholeInsets;//default zero. Just 'left' and 'right' is effective

@property (nonatomic, assign) CGFloat wxy_imageToTitleSpacing;//default 0
@property (nonatomic, assign) CGFloat wxy_titleToDetailSpacing;//default 0

#pragma mark -

- (void)wxy_setEmptyWithTitle:(NSString *)title;
- (void)wxy_setEmptyWithTitle:(NSString *)title reload:(void (^)(void))reload;

- (void)wxy_setEmptyWithImage:(UIImage *)image;
- (void)wxy_setEmptyWithImage:(UIImage *)image reload:(void (^)(void))reload;

- (void)wxy_setEmptyWithView:(UIView *)view;
- (void)wxy_setEmptyWithView:(UIView *)view reload:(void (^)(void))reload;

- (void)wxy_setEmptyWithTitle:(NSString *)title detail:(NSString *)detail;
- (void)wxy_setEmptyWithTitle:(NSString *)title detail:(NSString *)detail reload:(void (^)(void))reload;

- (void)wxy_setEmptyWithTitle:(NSString *)title image:(UIImage *)image;
- (void)wxy_setEmptyWithTitle:(NSString *)title image:(UIImage *)image reload:(void (^)(void))reload;

- (void)wxy_setEmptyWithTitle:(NSString *)title view:(UIView *)view;
- (void)wxy_setEmptyWithTitle:(NSString *)title view:(UIView *)view reload:(void (^)(void))reload;

- (void)wxy_setEmptyWithTitle:(NSString *)title detail:(NSString *)detail image:(UIImage *)image;
- (void)wxy_setEmptyWithTitle:(NSString *)title detail:(NSString *)detail image:(UIImage *)image reload:(void (^)(void))reload;

- (void)wxy_setEmptyWithTitle:(NSString *)title detail:(NSString *)detail view:(UIView *)view;
- (void)wxy_setEmptyWithTitle:(NSString *)title detail:(NSString *)detail view:(UIView *)view reload:(void (^)(void))reload;

#pragma mark -

- (void)wxy_setEmptyWithAttributedTitle:(NSAttributedString *)attributedtitle;
- (void)wxy_setEmptyWithAttributedTitle:(NSAttributedString *)attributedtitle reload:(void (^)(void))reload;

- (void)wxy_setEmptyWithAttributedTitle:(NSAttributedString *)attributedtitle attributedDetail:(NSAttributedString *)attributedDetail;
- (void)wxy_setEmptyWithAttributedTitle:(NSAttributedString *)attributedtitle attributedDetail:(NSAttributedString *)attributedDetail reload:(void (^)(void))reload;

- (void)wxy_setEmptyWithAttributedTitle:(NSAttributedString *)attributedtitle image:(UIImage *)image;
- (void)wxy_setEmptyWithAttributedTitle:(NSAttributedString *)attributedtitle image:(UIImage *)image reload:(void (^)(void))reload;

- (void)wxy_setEmptyWithAttributedTitle:(NSAttributedString *)attributedtitle view:(UIView *)view;
- (void)wxy_setEmptyWithAttributedTitle:(NSAttributedString *)attributedtitle view:(UIView *)view reload:(void (^)(void))reload;

- (void)wxy_setEmptyWithAttributedTitle:(NSAttributedString *)attributedtitle attributedDetail:(NSAttributedString *)attributedDetail image:(UIImage *)image;
- (void)wxy_setEmptyWithAttributedTitle:(NSAttributedString *)attributedtitle attributedDetail:(NSAttributedString *)attributedDetail image:(UIImage *)image reload:(void (^)(void))reload;

- (void)wxy_setEmptyWithAttributedTitle:(NSAttributedString *)attributedtitle attributedDetail:(NSAttributedString *)attributedDetail view:(UIView *)view;
- (void)wxy_setEmptyWithAttributedTitle:(NSAttributedString *)attributedtitle attributedDetail:(NSAttributedString *)attributedDetail view:(UIView *)view reload:(void (^)(void))reload;

#pragma mark -

- (BOOL)wxy_startReload;

- (void)wxy_clearBackground;

@end
