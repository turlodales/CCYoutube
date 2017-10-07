//
//  VidoePlayerViewController.m
//  CCYoutube
//
//  Created by surya on 10/6/17.
//  Copyright © 2017 surya. All rights reserved.
//

#import "VideoPlayerViewController.h"

@interface VideoPlayerViewController ()

@end

@implementation VideoPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSDictionary *playerVars = @{@"playsinline" : @1,};
    if (_videoId!= nil) {
        [self.mainPlayerView loadWithVideoId:_videoId playerVars:playerVars];
        
       // [self.mainPlayerView cueVideoById:_videoId startSeconds:0.0 suggestedQuality:kYTPlaybackQualityAuto];
    }
    else
    {
        [self.mainPlayerView cueVideoById:@"M7lc1UVf-VE" startSeconds:0.0 suggestedQuality:kYTPlaybackQualityAuto];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)playVideo:(id)sender {
    [self.mainPlayerView playVideo];
}

- (IBAction)stopVideo:(id)sender {
    [self.mainPlayerView stopVideo];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
@end
