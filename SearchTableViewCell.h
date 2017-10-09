//
//  SearchTableViewCell.h
//  CCYoutube
//
//  Created by surya on 10/6/17.
//  Copyright © 2017 surya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTPlayerView.h"

@interface SearchTableViewCell : UITableViewCell

@property (weak, nonatomic) YTPlayerView * overlayView;

@property (weak, nonatomic) IBOutlet UILabel *titleText;

@property (strong, nonatomic) IBOutlet UIImageView *thumbnailImage;

@property (weak, nonatomic) IBOutlet UILabel *descriptionText;


@end
