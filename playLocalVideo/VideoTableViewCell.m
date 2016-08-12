//
//  VideoTableViewCell.m
//  playLocalVideo
//
//  Created by Kuan-Wei Lin on 4/7/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "VideoTableViewCell.h"

@implementation VideoTableViewCell
@synthesize imageView;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
