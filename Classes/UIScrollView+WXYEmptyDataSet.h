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

@property (nonatomic, assign) CGFloat wxy_imageToUnderGroupSpacing;//default 0
@property (nonatomic, assign) CGFloat wxy_titleToUnderGroupSpacing;//default 0
@property (nonatomic, assign) CGFloat wxy_detailToUnderGroupSpacing;//default 0

#pragma mark -

- (void)wxy_setEmptyWithTitle:(NSString *)title;
- (void)wxy_setEmptyWithTitle:(NSString *)title reload:(void (^)(void))reload;

- (void)wxy_setEmptyWithImage:(UIImage *)image;
- (void)wxy_setEmptyWithImage:(UIImage *)image reload:(void (^)(void))reload;

- (void)wxy_setEmptyWithView:(UIView *)view;
- (void)wxy_setEmptyWithView:(UIView *)view reload:(void (^)(void))reload;

- (void)wxy_setEmptyWithTitle:(NSString *)title detail:(NSString *)detail;
- (void)wxy_setEmptyWithTitle:(NSString *)title detail:(NSString *)detail reload:(void (^)(void))reload;

- (void)wxy_setEmptyWithImage:(UIImage *)image title:(NSString *)title;
- (void)wxy_setEmptyWithImage:(UIImage *)image title:(NSString *)title reload:(void (^)(void))reload;

- (void)wxy_setEmptyWithImage:(UIImage *)image title:(NSString *)title detail:(NSString *)detail;
- (void)wxy_setEmptyWithImage:(UIImage *)image title:(NSString *)title detail:(NSString *)detail reload:(void (^)(void))reload;

- (void)wxy_setEmptyWithView:(UIView *)view title:(NSString *)title detail:(NSString *)detail;
- (void)wxy_setEmptyWithView:(UIView *)view title:(NSString *)title detail:(NSString *)detail reload:(void (^)(void))reload;

- (void)wxy_setEmptyWithButton:(UIButton *)button;
- (void)wxy_setEmptyWithTitle:(NSString *)title button:(UIButton *)button;
- (void)wxy_setEmptyWithTitle:(NSString *)title detail:(NSString *)detail button:(UIButton *)button;
- (void)wxy_setEmptyWithImage:(UIImage *)image button:(UIButton *)button;
- (void)wxy_setEmptyWithImage:(UIImage *)image title:(NSString *)title button:(UIButton *)button;
- (void)wxy_setEmptyWithImage:(UIImage *)image title:(NSString *)title detail:(NSString *)detail button:(UIButton *)button;
- (void)wxy_setEmptyWithView:(UIView *)view title:(NSString *)title detail:(NSString *)detail button:(UIButton *)button;

#pragma mark -

- (void)wxy_setEmptyWithAttributedTitle:(NSAttributedString *)title;
- (void)wxy_setEmptyWithAttributedTitle:(NSAttributedString *)title reload:(void (^)(void))reload;

- (void)wxy_setEmptyWithAttributedTitle:(NSAttributedString *)title attributedDetail:(NSAttributedString *)detail;
- (void)wxy_setEmptyWithAttributedTitle:(NSAttributedString *)title attributedDetail:(NSAttributedString *)detail reload:(void (^)(void))reload;

- (void)wxy_setEmptyWithImage:(UIImage *)image attributedTitle:(NSAttributedString *)title;
- (void)wxy_setEmptyWithImage:(UIImage *)image attributedTitle:(NSAttributedString *)title reload:(void (^)(void))reload;

- (void)wxy_setEmptyWithImage:(UIImage *)image attributedTitle:(NSAttributedString *)title attributedDetail:(NSAttributedString *)detail;
- (void)wxy_setEmptyWithImage:(UIImage *)image attributedTitle:(NSAttributedString *)title attributedDetail:(NSAttributedString *)detail reload:(void (^)(void))reload;

- (void)wxy_setEmptyWithView:(UIView *)view attributedTitle:(NSAttributedString *)title attributedDetail:(NSAttributedString *)detail;
- (void)wxy_setEmptyWithView:(UIView *)view attributedTitle:(NSAttributedString *)title attributedDetail:(NSAttributedString *)detail reload:(void (^)(void))reload;

- (void)wxy_setEmptyWithAttributedTitle:(NSAttributedString *)title button:(UIButton *)button;
- (void)wxy_setEmptyWithAttributedTitle:(NSAttributedString *)title attributedDetail:(NSAttributedString *)detail button:(UIButton *)button;
- (void)wxy_setEmptyWithImage:(UIImage *)image attributedTitle:(NSAttributedString *)title button:(UIButton *)button;
- (void)wxy_setEmptyWithImage:(UIImage *)image attributedTitle:(NSAttributedString *)title attributedDetail:(NSAttributedString *)detail button:(UIButton *)button;
- (void)wxy_setEmptyWithView:(UIView *)view attributedTitle:(NSAttributedString *)title attributedDetail:(NSAttributedString *)detail button:(UIButton *)button;

#pragma mark -

- (BOOL)wxy_startReload;

- (void)wxy_clearBackground;

@end
