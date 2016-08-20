//
//  ViewController.m
//  NestedScrollView
//
//  Created by Kuan-Wei Lin on 8/20/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image.png"]];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.backgroundColor = [UIColor blackColor];
    self.scrollView.contentSize = self.imageView.bounds.size;
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.scrollView.delegate = self;
    
    //self.scrollView.contentOffset = CGPointMake(1000, 450);
    
    [self.scrollView addSubview:self.imageView];
    [self.view addSubview:self.scrollView];
    
    [self setZoomScale];
    [self setupGestureRecognizer];

}

- (void)viewWillLayoutSubviews{
    [self setZoomScale];
}

- (void)setZoomScale{
    //設定scrollView zooming的最大值以及最小值
    //    self.scrollView.minimumZoomScale = 0.1;
    //    self.scrollView.maximumZoomScale = 4.0;
    //    self.scrollView.zoomScale = 1.0;
    
    CGSize imageViewSize = self.imageView.bounds.size;
    CGSize scrollViewSize = self.scrollView.bounds.size;
    CGFloat widthScale = scrollViewSize.width / imageViewSize.width;
    CGFloat heightScale = scrollViewSize.height / imageViewSize.height;
    //設定縮到最小時，scrollView的最小圖片大小
    self.scrollView.minimumZoomScale = MIN(widthScale, heightScale);
    self.scrollView.zoomScale = 1.0;
    
    //指定將scrollView變成最小
    [self.scrollView setZoomScale:self.scrollView.minimumZoomScale animated:YES];
}

- (void)setupGestureRecognizer{
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    doubleTap.numberOfTapsRequired = 2;
    [self.scrollView addGestureRecognizer:doubleTap];
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)recognizer{
    if (self.scrollView.zoomScale > self.scrollView.minimumZoomScale) {
        [self.scrollView setZoomScale:self.scrollView.minimumZoomScale animated:YES];
    } else {
        [self.scrollView setZoomScale:self.scrollView.maximumZoomScale animated:YES];
    }
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    
    //將縮小的圖片皆置中
    CGSize imageViewSize = self.imageView.frame.size;
    CGSize scrollViewSize = self.scrollView.bounds.size;
    
    CGFloat verticalPadding = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.height) / 2 : 0;
    CGFloat horizontalPadding = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 2 : 0;
    
    self.scrollView.contentInset = UIEdgeInsetsMake(verticalPadding, horizontalPadding, verticalPadding, horizontalPadding);
}


@end
