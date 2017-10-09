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
    _mainPlayerView.delegate = self;
    
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(50.0, 10.0, 30.0, 30.0)];
    activity.center = self.view.center;
    activity.hidesWhenStopped = true;
    activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [activity startAnimating];
    
    [self.view addSubview:activity];
    
    NSDictionary *playerVars = @{@"playsinline" : @0};
    if (_videoId!= nil) {
        [self.mainPlayerView loadWithVideoId:_videoId playerVars:playerVars];
        
        
        
    }
    else
    {
        [self.mainPlayerView loadWithVideoId:@"M7lc1UVf-VE" playerVars:playerVars];
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


#pragma mark - YTPlayer Delegate methods - 

- (void)playerViewDidBecomeReady:(nonnull YTPlayerView *)playerView
{
    
    _mainPlayerView.hidden = true;
    [self.mainPlayerView playVideo];
}

- (void)playerView:(nonnull YTPlayerView *)playerView didChangeToState:(YTPlayerState)state
{
    switch (state) {
        case kYTPlayerStateEnded:
            [playerView stopVideo];
            [playerView removeWebView];
            playerView = nil;
            break;
            
        default:
            break;
    }
}

@end
