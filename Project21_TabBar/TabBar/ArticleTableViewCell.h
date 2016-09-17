//
//  ArticleTableViewCell.h
//  TabBar
//
//  Created by Kuan-Wei Lin on 9/17/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;


@end
