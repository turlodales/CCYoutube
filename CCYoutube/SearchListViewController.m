//
//  SearchListViewController.m
//  CCYoutube
//
//  Created by surya on 10/6/17.
//  Copyright © 2017 surya. All rights reserved.
//

#import "SearchListViewController.h"
#import "VideoDetails.h"
#import "SearchTableViewCell.h"
#import "VideoPlayerViewController.h"

@interface SearchListViewController ()
{
    VideoDetails *vDetails;
    VideoPlayerViewController *vPlayer;
}

@end

@implementation SearchListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _videoSearchArray = [[NSMutableArray alloc]init];
    _searchTableView.delegate = self;
    _searchTableView.dataSource = self;
    
    
    [_searchButton setImage:[IonIcons imageWithIcon:ion_ios_search iconColor:[UIColor greenColor] iconSize:60.0f imageSize:CGSizeMake(10.0,10.0)] forState:UIControlStateNormal];
    
    //Youtube Service Object
    self.youtubeService = [[GTLRYouTubeService alloc] init];
    //self.youtubeService.shouldFetchNextPages = true;
    self.youtubeService.authorizer = _userObj.authentication.fetcherAuthorizer;
    [_searchTableView registerNib:[UINib nibWithNibName:@"SearchTableViewCell" bundle:nil] forCellReuseIdentifier:@"SearchCell"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Datasource & Delegate Methods -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *searchCellIdentifier = @"SearchCell";
    
    SearchTableViewCell *searchCell = (SearchTableViewCell *)[tableView dequeueReusableCellWithIdentifier:searchCellIdentifier forIndexPath:indexPath];
    
    // Customize Table View Cell
    
    searchCell.layer.shadowOffset = CGSizeMake(1, 0);
    searchCell.layer.shadowColor = [[UIColor blackColor] CGColor];
    searchCell.layer.shadowRadius = 5;
    searchCell.layer.shadowOpacity = 0.25;
    
    CGRect shadowFrame = searchCell.layer.bounds;
    CGPathRef shadowPath = [UIBezierPath bezierPathWithRect:shadowFrame].CGPath;
    searchCell.layer.shadowPath = shadowPath;
    
    
    // Get the video details and assign to values
    VideoDetails *videoDetails = [self.videoSearchArray objectAtIndex:indexPath.section];
    
    //Added Image
    NSURL *imageUrl = [NSURL URLWithString:videoDetails.videoThumbnail];
    NSData *imgData = [NSData dataWithContentsOfURL:imageUrl];
    [searchCell.thumbnailImage setTag:2233];
    searchCell.thumbnailImage.backgroundColor = [UIColor clearColor];
    searchCell.thumbnailImage.tintColor = [UIColor clearColor];
    searchCell.thumbnailImage.layer.cornerRadius = 15.0f;
    searchCell.thumbnailImage.clipsToBounds = true;
    
    UIImageView *tnImage = [searchCell viewWithTag:2233];
    [tnImage setImage:[UIImage imageWithData:imgData]];
    
    
    //Add Title
    searchCell.titleText.text = videoDetails.videoTitle;
    CGRect titleFrameRect = searchCell.titleText.frame;
    titleFrameRect.origin.x = 1.0;
    titleFrameRect.origin.y = (searchCell.bounds.size.height) - (1.25*searchCell.bounds.size.height);
    searchCell.titleText.frame = titleFrameRect;
    [searchCell.contentView addSubview:searchCell.titleText];
    
    
    //Add Description
    searchCell.descriptionText.text = videoDetails.videoDescription;
    [searchCell.contentView addSubview:searchCell.descriptionText];
    
    
    //Autoplay on focus (like tumblr)
    
    
    
    return searchCell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.videoSearchArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat aspectRatio = 360.0f/480.f;
    return aspectRatio * 1.5 * [UIScreen mainScreen].bounds.size.width;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = [indexPath section];
    vPlayer = [self.storyboard instantiateViewControllerWithIdentifier:@"PlayerViewController"];
    // Get the video details and assign to values
    VideoDetails *vidDetails = [self.videoSearchArray objectAtIndex:section];
    vPlayer.videoId = vidDetails.videoId;
    NSLog(@"Inside did select");
    [self presentViewController:vPlayer animated:YES completion:nil];
    
}

#pragma mark - User-defined methods -

//Gets the videoIds of first 20 videos from the search term.
-(void)fetchVideoList:(NSString *)searchTerm
{
    GTLRYouTubeQuery_SearchList *searchList = [GTLRYouTubeQuery_SearchList queryWithPart:@"snippet"];
    searchList.q = searchTerm;
    
    searchList.maxResults = 20;
    
    [self.youtubeService executeQuery:searchList delegate:self didFinishSelector:@selector(displayResultWithTicket:finishedWithObject:error:)];
    
    
}

// Query result and output

- (void)displayResultWithTicket:(GTLRServiceTicket *)ticket finishedWithObject:(GTLRYouTube_SearchListResponse *)sList error:(NSError *)error
{
    if (error == nil)
    {
        if (sList.items.count > 0)
        {
            for (GTLRYouTube_SearchResult *list in sList)
            {
                vDetails = [[VideoDetails alloc]init];
                vDetails.videoId = list.identifier.videoId;
                vDetails.videoThumbnail = (NSString *)list.snippet.thumbnails.high.url;
                vDetails.videoTitle = list.snippet.title;
                vDetails.videoDescription = list.snippet.descriptionProperty;
                
                [self.videoSearchArray addObject:vDetails];
            }
        }
        else
        {
            NSLog(@"slist is empty");
        }
       
    }
    else
    {
        [self showAlert:@"Error" message:error.localizedDescription];
        
    }
    [self.searchTableView reloadData];
}


//show Alert message
-(void)showAlert:(NSString *)title message:(NSString*)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                               {
                                   [alert dismissViewControllerAnimated:YES completion:nil];
                               }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)searchAction:(id)sender {
    self.videoSearchArray = [[NSMutableArray alloc] init];
    [self fetchVideoList: self.searchTextField.text];
}
@end
