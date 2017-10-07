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

@interface SearchListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) NSMutableArray *videoSearchArray;
@property (weak, nonatomic) IBOutlet UITableView *searchTableView;
@property (nonatomic, strong) GTLRYouTubeService *youtubeService;
@property (nonatomic, strong) GIDGoogleUser *userObj;

@property (strong, nonatomic) IBOutlet UITextField *searchTextField;

@property (strong, nonatomic) IBOutlet UIButton *searchButton;

- (IBAction)searchAction:(id)sender;

@end
