//
//  ViewController.m
//  ImageScrollerEffect
//
//  Created by Kuan-Wei Lin on 8/13/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate>

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Steve"]];
    
    //Basic way to add UIImageView on UIScrollView
//    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
//    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    self.scrollView.backgroundColor = [UIColor blackColor];
//    self.scrollView.contentSize = self.imageView.bounds.size;
//
//    [self.scrollView addSubview:self.imageView];
//    [self.view addSubview:self.scrollView];
    
    [self setUpScrollView];
    self.scrollView.delegate = self;
    
    [self setZoomScaleFor:self.scrollView.bounds.size];
    self.scrollView.zoomScale = [self.scrollView minimumZoomScale];
    
    [self recenterImage];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    [self setZoomScaleFor:self.scrollView.bounds.size];
    
    if (self.scrollView.zoomScale < self.scrollView.minimumZoomScale) {
        self.scrollView.zoomScale = self.scrollView.minimumZoomScale;
    }
    
    [self recenterImage];
}

- (void)setUpScrollView{
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.contentSize = self.imageView.bounds.size;
    
    [self.scrollView addSubview:self.imageView];
    [self.view addSubview:self.scrollView];
}

- (void)setZoomScaleFor:(CGSize)scrollViewSize{
    
    CGSize imageSize = self.imageView.bounds.size;
    CGFloat widthScale = scrollViewSize.width / imageSize.width;
    CGFloat heightScale = scrollViewSize.height / imageSize.height;
    CGFloat minimunScale = widthScale > heightScale ? heightScale : widthScale;
    
    self.scrollView.minimumZoomScale = minimunScale;
    self.scrollView.maximumZoomScale = 3.0;
}

- (void)recenterImage{
    CGSize scrollViewSize = self.scrollView.bounds.size;
    CGSize imageViewSize = self.imageView.frame.size;
    CGFloat horizontalSpace = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 2.0 : 0;
    CGFloat verticalSpace = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.width) / 2.0 :0;
    
    self.scrollView.contentInset = UIEdgeInsetsMake(verticalSpace, horizontalSpace, verticalSpace, horizontalSpace);
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    [self recenterImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
