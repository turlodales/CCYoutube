//
//  ViewController.h
//  CCYoutube
//
//  Created by surya on 10/6/17.
//  Copyright © 2017 surya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Google/SignIn.h>
#import <GTLRYouTube.h>

@interface SignInViewController : UIViewController<GIDSignInDelegate,GIDSignInUIDelegate>

@property (nonatomic, strong) IBOutlet GIDSignInButton *signOnButton;
@property (nonatomic, strong) GTLRYouTubeService *youtubeService;

@end

