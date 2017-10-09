//
//  SearchListViewController.h
//  CCYoutube
//
//  Created by surya on 10/6/17.
//  Copyright © 2017 surya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Google/SignIn.h>
#import <GTLRYouTube.h>
#import <IonIcons.h>
#import "YTPlayerView.h"

@interface SearchListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,YTPlayerViewDelegate>

@property (nonatomic, strong) NSMutableArray *videoSearchArray;
@property (nonatomic, strong) GTLRYouTubeService *youtubeService;
@property (nonatomic, strong) GIDGoogleUser *userObj;
@property (nonatomic, strong) NSIndexPath *lastSelected;

@property (weak, nonatomic) IBOutlet UITableView *searchTableView;

@property (strong, nonatomic) IBOutlet UITextField *searchTextField;

@property (strong, nonatomic) IBOutlet UIButton *searchButton;

- (IBAction)searchAction:(id)sender;

@end
