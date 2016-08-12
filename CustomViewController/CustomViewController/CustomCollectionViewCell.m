//
//  CustomCollectionViewCell.m
//  CustomViewController
//
//  Created by Kuan-Wei Lin on 8/12/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "CustomCollectionViewCell.h"

@implementation CustomCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    //NSLog(@"先initWithFrame");
    self = [super initWithFrame:frame];
    
    if (self) {
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"CustomCollectionViewCell" owner:self options:nil];
        self = [arrayOfViews objectAtIndex:0];
        
        //設定UICollectionViewCell裡面元件（UILabel, UIImageView等）的陰影
        [self.layer setShadowOffset:CGSizeMake(1, 1)];
        [self.layer setShadowColor:[[UIColor grayColor] CGColor]];
        [self.layer setShadowRadius:1.0];
        [self.layer setShadowOpacity:0.5];
        [self.layer setMasksToBounds:NO];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    //NSLog(@"後awakeFromNib");
}

@end
