//
//  KWMarqueeScrollingLabelView.h
//  KWMarqueeScrollingLabelView_Demo
//
//  Created by Kuan-Wei Lin on 8/5/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

//設定跑馬燈的方向
typedef NS_ENUM(NSInteger, MarqueeScrollDirection) {
    MarqueeScrollDirectionRight,
    MarqueeScrollDirectionLeft
};

@interface KWMarqueeScrollingLabelView : UIView

//Settings
@property (nonatomic) MarqueeScrollDirection scrollDirection;
@property (nonatomic) float scrollSpeed;// pixels per second, defaults to 30
@property (nonatomic) NSTimeInterval pauseInterval;// defaults to 1.5
@property (nonatomic) NSInteger labelSpacing;// pixels, defaults to 20

/*!
 The animation options used when scrolling the UILabels.
 @discussion UIViewAnimationOptionAllowUserInteraction is always applied to the animations.
 */
@property (nonatomic) UIViewAnimationOptions animationOptions;

/*!
 Returns YES, if it is actively scrolling, NO if it has paused or if text is within bounds (disables scrolling).
 */
@property (nonatomic, readonly) BOOL scrolling;
@property (nonatomic) CGFloat fadeLength;// defaults to 7

//UILabel properties
@property (nonatomic, copy, nullable) NSString *text;
@property (nonatomic, copy, nullable) NSAttributedString *attributedText;
@property (nonatomic, strong, nonnull) UIColor *textColor;
@property (nonatomic, strong, nonnull) UIFont *font;
@property (nonatomic, strong, nonnull) UIColor *shadowColor;

@property (nonatomic) CGSize shadowOffset;
@property (nonatomic) NSTextAlignment textAlignment;

/*!
 Set the label in the middle of the superview, or align to left of the superview.
 @discussion Set the property to certain number to represent the text length and if the length of the text you set is shorter than the property, the label will align itselft to superview, otherwise the label will align itself to left of the superview.
 */
@property (nonatomic) int labelTextLength;

/**
 * Lays out the scrollview contents, enabling text scrolling if the text will be clipped.
 * @discussion Uses [scrollLabelIfNeeded] internally.
 */
- (void)refreshLabels;

/*!
 Set the text to the label and refresh labels, if needed.
 @discussion Useful when you have a situation where you need to layout the scroll label after it's text is set.
 */
- (void)setText:(NSString * __nullable)text refreshLabels:(BOOL)refresh;

/**
 Set the attributed text and refresh labels, if needed.
 */
- (void)setAttributedText:(NSAttributedString * __nullable)theText refreshLabels:(BOOL)refresh;

/**
 * Initiates auto-scroll, if the label width exceeds the bounds of the scrollview.
 */
- (void)scrollLabelIfNeeded;

/**
 * Observes UIApplication state notifications to auto-restart scrolling and watch for
 * orientation changes to refresh the labels.
 * @discussion Must be called to observe the notifications. Calling multiple times will still only
 * register the notifications once.
 */
- (void)observeApplicationNotifications;

@end
