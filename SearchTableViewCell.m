//
//  SearchTableViewCell.m
//  CCYoutube
//
//  Created by surya on 10/6/17.
//  Copyright © 2017 surya. All rights reserved.
//

#import "SearchTableViewCell.h"

@implementation SearchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _overlayView.delegate = self;
        
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - YTPlayer Delgate Methods -

- (void)playerViewDidBecomeReady:(nonnull YTPlayerView *)playerView
{

    [self.overlayView setHidden:false];
    [self.overlayView playVideo];
}




@end
