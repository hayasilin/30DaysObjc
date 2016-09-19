//
//  KWMarqueeScrollingLabelView.m
//  KWMarqueeScrollingLabelView_Demo
//
//  Created by Kuan-Wei Lin on 8/5/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "KWMarqueeScrollingLabelView.h"

#define kLabelCount 2
#define kDefaultFadeLength 7.f
// pixel buffer space between scrolling label
#define kDefaultLabelBufferSpace 40
#define kDefaultPixelsPerSecond 30
#define kDefaultPauseTime 1.5f

// shortcut method for NSArray iterations
static void each_object(NSArray *objects, void (^block)(id object)) {
    for (id obj in objects) {
        block(obj);
    }
}

// shortcut to change each label attribute value
#define EACH_LABEL(ATTR, VALUE) each_object(self.labels, ^(UILabel *label) { label.ATTR = VALUE; });

@interface KWMarqueeScrollingLabelView ()

@property (nonatomic, strong) NSArray *labels;
@property (nonatomic, strong, nullable) UILabel *mainLabel;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation KWMarqueeScrollingLabelView

- (void)dealloc {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self commonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    // create the labels
    NSMutableSet *labelSet = [[NSMutableSet alloc] initWithCapacity:kLabelCount];
    
    for (int index = 0; index < kLabelCount; ++index) {
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.autoresizingMask = self.autoresizingMask;
        
        label.textColor = self.textColor;
        
        // store labels
        [self.scrollView addSubview:label];
        [labelSet addObject:label];
    }
    
    self.labels = [labelSet.allObjects copy];
    
    // default values
    _scrollDirection = MarqueeScrollDirectionLeft;
    _scrollSpeed = kDefaultPixelsPerSecond;
    self.pauseInterval = kDefaultPauseTime;
    self.labelSpacing = kDefaultLabelBufferSpace;
    
    //Kuan-Wei: - 原本的Library設定成NSTextAlignmentLeft，初始化讓字串的位置皆為置中
    self.textAlignment = NSTextAlignmentCenter;
    
    self.animationOptions = UIViewAnimationOptionCurveLinear;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.scrollEnabled = NO;
    self.userInteractionEnabled = NO;
    self.backgroundColor = [UIColor clearColor];
    self.clipsToBounds = YES;
    self.fadeLength = kDefaultFadeLength;
}

- (void)setFrame:(CGRect)frame {
    //原本Library只用以下的方法，但如果有back button存在的話，整個titleView會被back button往右推，因此會出現長度較短的標題字也會跟著titileView一起被往右推，造成標題字無法置中的情況(如果故意設定較短的View.width則無此問題，但反之NavigaitonItem上面都沒有button時，只會看到很短的view裡字串在捲動，造成有多餘的空間沒有被使用的情況)
    //[super setFrame:frame];
    
    //Kuan-Wei: - 計算字串的長度是否大於titleView的長度，如果是則沿用原本Library的方法，如果不是則以NavigationBar當作SuperView重新畫出frame，將可讓短的字串達到置中的效果
    
    //取得Label長度，可以發現其實Label的長度被設定成跟self一樣長
    CGFloat labelWidth = CGRectGetWidth(self.mainLabel.bounds);
    
    //如果Label長度不為0
    if (labelWidth != 0) {
        //取得Label裡面的字串長度
        float labelTextWidth = [self.mainLabel.text boundingRectWithSize:self.mainLabel.frame.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName:self.mainLabel.font } context:nil].size.width;
        
        NSLog(@"The width of mainLabel is %f", labelTextWidth);
        
        if (labelTextWidth <= self.labelTextLength){
            //以下方式可以讓短的標題字(<=200px)置中，self的大小將以整個NavigationBar為基準，不受back button影響
            [super setFrame:CGRectMake(0, 0, self.superview.bounds.size.width, self.superview.bounds.size.height)];
        }else{
            //原本Library的方式，讓mainLabel照著superView的大小變化
            [super setFrame:frame];
            //讓大於200px的較長字串靠左對齊
            self.textAlignment = NSTextAlignmentLeft;
        }
    }
    
    [self didChangeFrame];
}

#pragma mark - Properties
- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        _scrollView.backgroundColor = [UIColor clearColor];
        
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

- (void)setFadeLength:(CGFloat)fadeLength {
    if (_fadeLength != fadeLength) {
        _fadeLength = fadeLength;
        
        [self refreshLabels];
        [self applyGradientMaskForFadeLength:fadeLength enableFade:NO];
    }
}

- (UILabel *)mainLabel {
    return self.labels[0];
}

- (void)setText:(NSString *)theText {
    [self setText:theText refreshLabels:YES];
}

- (void)setText:(NSString *)theText refreshLabels:(BOOL)refresh {
    // ignore identical text changes
    if ([theText isEqualToString:self.text]){
        return;
    }
    
    EACH_LABEL(text, theText)
    
    if (refresh){
        [self refreshLabels];
    }
}

- (NSString *)text {
    return self.mainLabel.text;
}

- (void)setAttributedText:(NSAttributedString *)theText {
    [self setAttributedText:theText refreshLabels:YES];
}

- (void)setAttributedText:(NSAttributedString *)theText refreshLabels:(BOOL)refresh {
    // ignore identical text changes
    if ([theText.string isEqualToString:self.attributedText.string]){
        return;
    }
    
    EACH_LABEL(attributedText, theText)
    
    if (refresh){
        [self refreshLabels];
    }
}

- (NSAttributedString *)attributedText {
    return self.mainLabel.attributedText;
}

- (void)setTextColor:(UIColor *)color {
    EACH_LABEL(textColor, color)
}

- (UIColor *)textColor {
    return self.mainLabel.textColor;
}

- (void)setFont:(UIFont *)font {
    if (self.mainLabel.font == font)
        return;
    
    EACH_LABEL(font, font)
    
    [self refreshLabels];
    [self invalidateIntrinsicContentSize];
}

- (UIFont *)font {
    return self.mainLabel.font;
}

- (void)setScrollSpeed:(float)speed {
    _scrollSpeed = speed;
    
    [self scrollLabelIfNeeded];
}

- (void)setScrollDirection:(MarqueeScrollDirection)direction {
    _scrollDirection = direction;
    
    [self scrollLabelIfNeeded];
}

- (void)setShadowColor:(UIColor *)color {
    EACH_LABEL(shadowColor, color)
}

- (UIColor *)shadowColor {
    return self.mainLabel.shadowColor;
}

- (void)setShadowOffset:(CGSize)offset {
    EACH_LABEL(shadowOffset, offset)
}

- (CGSize)shadowOffset {
    return self.mainLabel.shadowOffset;
}

#pragma mark - Misc
- (void)observeApplicationNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    // restart scrolling when the app has been activated
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(scrollLabelIfNeeded)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(scrollLabelIfNeeded)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
}

- (void)enableShadow {
    _scrolling = YES;
    [self applyGradientMaskForFadeLength:self.fadeLength enableFade:YES];
}

#pragma mark -  Key main function
- (void)scrollLabelIfNeeded {
    if (!self.text.length){
        return;
    }
    
    CGFloat labelWidth = CGRectGetWidth(self.mainLabel.bounds);
    if (labelWidth <= CGRectGetWidth(self.bounds)){
        return;
    }
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(scrollLabelIfNeeded) object:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(enableShadow) object:nil];
    
    [self.scrollView.layer removeAllAnimations];
    
    BOOL doScrollLeft = (self.scrollDirection == MarqueeScrollDirectionLeft);
    self.scrollView.contentOffset = (doScrollLeft ? CGPointZero : CGPointMake(labelWidth + self.labelSpacing, 0));
    
    // Add the left shadow after delay
    [self performSelector:@selector(enableShadow) withObject:nil afterDelay:self.pauseInterval];
    
    // animate the scrolling
    NSTimeInterval duration = labelWidth / self.scrollSpeed;
    
    [UIView animateWithDuration:duration delay:self.pauseInterval options:self.animationOptions | UIViewAnimationOptionAllowUserInteraction animations:^{
        // adjust offset
        self.scrollView.contentOffset = (doScrollLeft ? CGPointMake(labelWidth + self.labelSpacing, 0) : CGPointZero);
    } completion:^(BOOL finished) {
        _scrolling = NO;
        
        // remove the left shadow
        [self applyGradientMaskForFadeLength:self.fadeLength enableFade:NO];
        
        // setup pause delay/loop
        if (finished) {
            [self performSelector:@selector(scrollLabelIfNeeded) withObject:nil];
        }
    }];
}

- (void)refreshLabels {
    __block float offset = 0;
    
    each_object(self.labels, ^(UILabel *label) {
        [label sizeToFit];
        
        CGRect frame = label.frame;
        frame.origin = CGPointMake(offset, 0);
        frame.size.height = CGRectGetHeight(self.bounds);
        label.frame = frame;
        
        // Recenter label vertically within the scroll view
        label.center = CGPointMake(label.center.x, roundf(self.center.y - CGRectGetMinY(self.frame)));
        
        offset += CGRectGetWidth(label.bounds) + self.labelSpacing;
    });
    
    self.scrollView.contentOffset = CGPointZero;
    [self.scrollView.layer removeAllAnimations];
    
    // if the label is bigger than the space allocated, then it should scroll
    if (CGRectGetWidth(self.mainLabel.bounds) > CGRectGetWidth(self.bounds)) {
        CGSize size;
        size.width = CGRectGetWidth(self.mainLabel.bounds) + CGRectGetWidth(self.bounds) + self.labelSpacing;
        size.height = CGRectGetHeight(self.bounds);
        self.scrollView.contentSize = size;
        
        EACH_LABEL(hidden, NO)
        
        [self applyGradientMaskForFadeLength:self.fadeLength enableFade:self.scrolling];
        
        [self scrollLabelIfNeeded];
    } else {
        // Hide the other labels
        EACH_LABEL(hidden, (self.mainLabel != label))
        
        // adjust the scroll view and main label
        self.scrollView.contentSize = self.bounds.size;
        self.mainLabel.frame = self.bounds;
        self.mainLabel.hidden = NO;
        self.mainLabel.textAlignment = self.textAlignment;
        
        // cleanup animation
        [self.scrollView.layer removeAllAnimations];
        
        [self applyGradientMaskForFadeLength:0 enableFade:NO];
    }
}

// bounds or frame has been changed
- (void)didChangeFrame {
    [self refreshLabels];
    [self applyGradientMaskForFadeLength:self.fadeLength enableFade:self.scrolling];
}

#pragma mark - Gradient

// ref: https://github.com/cbpowell/MarqueeLabel
- (void)applyGradientMaskForFadeLength:(CGFloat)fadeLength enableFade:(BOOL)fade {
    CGFloat labelWidth = CGRectGetWidth(self.mainLabel.bounds);
    
    if (labelWidth <= CGRectGetWidth(self.bounds)){
        fadeLength = 0;
    }
    
    if (fadeLength) {
        // Recreate gradient mask with new fade length
        CAGradientLayer *gradientMask = [CAGradientLayer layer];
        
        gradientMask.bounds = self.layer.bounds;
        gradientMask.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        
        gradientMask.shouldRasterize = YES;
        gradientMask.rasterizationScale = [UIScreen mainScreen].scale;
        
        gradientMask.startPoint = CGPointMake(0, CGRectGetMidY(self.frame));
        gradientMask.endPoint = CGPointMake(1, CGRectGetMidY(self.frame));
        
        // setup fade mask colors and location
        id transparent = (id)[UIColor clearColor].CGColor;
        id opaque = (id)[UIColor blackColor].CGColor;
        gradientMask.colors = @[transparent, opaque, opaque, transparent];
        
        // calcluate fade
        CGFloat fadePoint = fadeLength / CGRectGetWidth(self.bounds);
        NSNumber *leftFadePoint = @(fadePoint);
        NSNumber *rightFadePoint = @(1 - fadePoint);
        if (!fade) switch (self.scrollDirection) {
            case MarqueeScrollDirectionLeft:
                leftFadePoint = @0;
                break;
                
            case MarqueeScrollDirectionRight:
                leftFadePoint = @0;
                rightFadePoint = @1;
                break;
        }
        
        // apply calculations to mask
        gradientMask.locations = @[@0, leftFadePoint, rightFadePoint, @1];
        
        // don't animate the mask change
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        self.layer.mask = gradientMask;
        [CATransaction commit];
    } else {
        // Remove gradient mask for 0.0f length fade length
        self.layer.mask = nil;
    }
}

#pragma mark - Notifications

- (void)onUIApplicationDidChangeStatusBarOrientationNotification:(NSNotification *)notification {
    // delay to have it re-calculate on next runloop
    [self performSelector:@selector(refreshLabels) withObject:nil afterDelay:.1f];
    [self performSelector:@selector(scrollLabelIfNeeded) withObject:nil afterDelay:.1f];
}

@end
