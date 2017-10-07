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

@interface SearchListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) NSMutableArray *videoSearchArray;
@property (weak, nonatomic) IBOutlet UITableView *searchTableView;
@property (nonatomic, strong) GTLRYouTubeService *youtubeService;
@property (nonatomic, strong) GIDGoogleUser *userObj;




@end
