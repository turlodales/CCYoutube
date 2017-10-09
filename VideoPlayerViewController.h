//
//  VidoePlayerViewController.h
//  CCYoutube
//
//  Created by surya on 10/6/17.
//  Copyright © 2017 surya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTPlayerView.h"

@interface VideoPlayerViewController : UIViewController <YTPlayerViewDelegate>
@property (strong, nonatomic) IBOutlet YTPlayerView *mainPlayerView;

@property (nonatomic, strong) NSString *videoId;

- (IBAction)playVideo:(id)sender;

- (IBAction)stopVideo:(id)sender;


@end
