//
//  ViewController.m
//  CCYoutube
//
//  Created by surya on 10/6/17.
//  Copyright © 2017 surya. All rights reserved.
//

#import "SignInViewController.h"
#import "SearchListViewController.h"

@interface SignInViewController ()
{
    SearchListViewController *searchViewController;
    CAGradientLayer *gLayer;
}
@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    searchViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchListViewController"];
    
    gLayer = [CAGradientLayer layer];
    gLayer.frame = self.view.bounds;
    gLayer.colors = @[(id)[UIColor grayColor].CGColor, (id)[UIColor grayColor].CGColor,(id)[UIColor whiteColor].CGColor,(id)[UIColor colorWithRed:135 green:206 blue:250 alpha:0].CGColor];
    
    [self.view.layer insertSublayer:gLayer atIndex:0];
    
    _helloLabel = [IonIcons labelWithIcon:ion_ionic size:30.0f color:[UIColor whiteColor]];
    
    // Setting up Google Sign-In
    GIDSignIn *signIn = [GIDSignIn sharedInstance];
    signIn.delegate = self;
    signIn.uiDelegate = self;
    signIn.scopes = [NSArray arrayWithObjects:kGTLRAuthScopeYouTubeReadonly, nil];
    
    //[signIn signInSilently];
    
    //Add google+ button to view
    self.signOnButton = [[GIDSignInButton alloc] init];
    
    //[self.view addSubview:self.signOnButton];

    self.navigationController.navigationBar.hidden = true;
    
    //Youtube Service Object
    self.youtubeService = [[GTLRYouTubeService alloc] init];
    
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    gLayer.frame = self.view.bounds;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Google SignIn Delegate methods -

- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error
{
    if (error != nil) {
        [self showAlert:@"Authentication Error" message:error.localizedDescription];
        self.youtubeService.authorizer = nil;
    }
    else
    {
        self.youtubeService.authorizer = user.authentication.fetcherAuthorizer;
    
        searchViewController.userObj = user;
        [self.navigationController pushViewController:searchViewController animated:YES];
        //[self.navigationController presentViewController:searchViewController animated:YES completion:nil];
        
        
    }
}

#pragma mark - Font change - 

- (UIFont *) ionicFont : (UILabel *)label
{
    UIFont *ionicFont = [IonIcons fontWithSize:30.0f];
    
    return ionicFont;
}

#pragma mark - User-defined methods -
                 
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

@end
