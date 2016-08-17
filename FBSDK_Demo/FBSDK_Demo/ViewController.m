//
//  ViewController.m
//  FBSDK_Demo
//
//  Created by Kuan-Wei on 2016/8/17.
//  Copyright © 2016年 TaiwanMobile. All rights reserved.
//

#import "ViewController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

@interface ViewController () <FBSDKLoginButtonDelegate>

@property (nonatomic) FBSDKLoginManager *fbLoginManager;
@property (nonatomic) FBSDKLoginButton *loginButton;
@property (nonatomic) UIButton *myFBLoginButton;
@property (nonatomic) UIButton *myFBLogoutButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loginButton = [[FBSDKLoginButton alloc] init];
    self.loginButton.delegate = self;
    self.loginButton.center = self.view.center;
    [self.view addSubview:self.loginButton];
    
    //將會出現提醒使用者此App將會取得使用者的profile, email等資料
    self.loginButton.readPermissions = @[@"public_profile", @"email", @"user_friends"];
    
    //Like Button
    FBSDKLikeControl *likeButton = [[FBSDKLikeControl alloc] init];
    likeButton.frame = CGRectMake(CGRectGetMidX(self.view.frame) - 90, CGRectGetMidY(self.view.frame) + 130, 180, 40);
    likeButton.objectID = @"https://www.facebook.com/FacebookDevelopers";
    [self.view addSubview:likeButton];
    
    //Share Button
    FBSDKShareButton *shareButton = [[FBSDKShareButton alloc] init];
    shareButton.frame = CGRectMake(CGRectGetMidX(self.view.frame) - 90, CGRectGetMidY(self.view.frame) + 200, 180, 40);
    FBSDKShareLinkContent *shareContent = [[FBSDKShareLinkContent alloc] init];
    shareContent.contentURL = [NSURL URLWithString:@"https://developers.facebook.com"];
    //以下Custom參數只有在非使用FBSDKShareLinkContent時才能使用，否則會被FBSDK自己從網站Parse的內容蓋過去
    shareContent.contentTitle = @"Custom title";
    shareContent.contentDescription = @"Custom description";
    shareContent.imageURL = [NSURL URLWithString:@"http://cms.myvideo.net.tw/images/news/ch13/20160811/201608111645399679_300x169.jpg"];
    shareContent.hashtag = [FBSDKHashtag hashtagWithString:@"#MadeWithHackbook"];
    shareContent.quote = @"Learn quick and simple ways for people to share content from your app or website to Facebook.";
    shareButton.shareContent = shareContent;
    [self.view addSubview:shareButton];
    
    //Send Button
    FBSDKSendButton *sendButton = [[FBSDKSendButton alloc] init];
    sendButton.frame = CGRectMake(CGRectGetMidX(self.view.frame) - 90, CGRectGetMidY(self.view.frame) + 250, 180, 40);
    FBSDKShareLinkContent *sendContent = [[FBSDKShareLinkContent alloc] init];
    sendContent.contentTitle = @"Hello world!";
    sendButton.shareContent = sendContent;
    if (sendButton.isHidden) {
        NSLog(@"Is hidden");
    } else {
        [self.view addSubview:sendButton];
    }
//    [FBSDKMessageDialog showWithContent:sendContent delegate:nil];
    
}

- (void)createMyLoginButton{
    // Add a custom login button to your app
    self.myFBLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.myFBLoginButton.backgroundColor=[UIColor darkGrayColor];
    self.myFBLoginButton.frame = CGRectMake(CGRectGetMidX(self.view.frame) - 90, CGRectGetMidY(self.view.frame) + 60,180,40);
    self.myFBLoginButton.layer.cornerRadius = 5;
    [self.myFBLoginButton setTitle: @"My Login Button" forState: UIControlStateNormal];
    
    // Handle clicks on the button
    [self.myFBLoginButton
     addTarget:self
     action:@selector(myLoginButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    // Add the button to the view
    [self.view addSubview:self.myFBLoginButton];
}

// Once the button is clicked, show the login dialog
-(void)myLoginButtonClicked
{
    self.fbLoginManager = [[FBSDKLoginManager alloc] init];
    
    [self.fbLoginManager
     logInWithReadPermissions: @[@"public_profile"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             NSLog(@"Process error");
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
         } else {
             NSLog(@"Logged in");
             
             [self.myFBLoginButton removeFromSuperview];
             
             self.myFBLogoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
             self.myFBLogoutButton.backgroundColor=[UIColor redColor];
             self.myFBLogoutButton.frame = CGRectMake(CGRectGetMidX(self.view.frame) - 90, CGRectGetMidY(self.view.frame) + 60,180,40);
             [self.myFBLogoutButton setTitle: @"My Logout Button" forState: UIControlStateNormal];
             
             // Handle clicks on the button
             [self.myFBLogoutButton
              addTarget:self
              action:@selector(logoutButtonClicked) forControlEvents:UIControlEventTouchUpInside];
             
             // Add the button to the view
             [self.view addSubview:self.myFBLogoutButton];
         }
     }];
}

- (void)logoutButtonClicked{
    NSLog(@"Logged out");

    [self.fbLoginManager logOut];
    [self.myFBLogoutButton removeFromSuperview];
    
    [self createMyLoginButton];
}

#pragma mark - FBSDKLoginButtonDelegate
- (void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error{
    NSLog(@"didCompleteWithResult");
}

- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton{
    NSLog(@"loginButtonDidLogOut");
}

- (BOOL)loginButtonWillLogin:(FBSDKLoginButton *)loginButton{
    NSLog(@"loginButtonWillLogin");
    return YES;
}

#pragma mark - IBAction
- (IBAction)fbShareButtonPressed:(UIButton *)sender {
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
    content.contentURL = [NSURL URLWithString:@"https://developers.facebook.com"];
    
    //以下Custom參數只有在非使用FBSDKShareLinkContent時才能使用，否則會被FBSDK自己從網站Parse的內容蓋過去
    content.contentTitle = @"Custom title";
    content.contentDescription = @"Custom description";
    content.imageURL = [NSURL URLWithString:@"http://cms.myvideo.net.tw/images/news/ch13/20160811/201608111645399679_300x169.jpg"];
    
    [FBSDKShareDialog showFromViewController:self
                                 withContent:content
                                    delegate:nil];
}

- (IBAction)fbWebViewStyleShareButtonPressed:(UIButton *)sender {
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
    content.contentURL = [NSURL URLWithString:@"http://www.myvideo.net.tw/MyVideo/liveChannelIndex.do"];
    content.contentTitle = @"myVideo直播-TVBS新聞台HD-17:00整點新聞";
    content.contentDescription = @"TVBS新聞台以沒有國界，沒有時差為理念，台灣第一個24小時全天侯的新聞性專業頻道，知性多元的專題節目，一步一腳印發現新台灣，世界翻轉中，當掌聲響起";
    content.imageURL = [NSURL URLWithString:@"http://cms.myvideo.net.tw/images/news/ch13/20160811/201608111645399679_300x169.jpg"];

    FBSDKShareDialog* dialog = [[FBSDKShareDialog alloc] init];
    
    //可以顯示客製化內容的Mode
    dialog.mode = FBSDKShareDialogModeFeedWeb;//打開WebView可以顯示客製化內容
    
    //dialog.mode = FBSDKShareDialogModeAutomatic;//預設，不可顯示客製化內縙
    //dialog.mode = FBSDKShareDialogModeShareSheet;//同上
    //dialog.mode = FBSDKShareDialogModeNative; //可以顯示客製化內容
    //dialog.mode = FBSDKShareDialogModeBrowser; //打開safari
    //dialog.mode = FBSDKShareDialogModeWeb;//打開WebView
    //dialog.mode = FBSDKShareDialogModeFeedBrowser;//打開safari 可以顯示客製化內容
    
    //無法顯示客製化內容的Mode
//    if (![dialog canShow]) {
//        // fallback presentation when there is no FB app
//        dialog.mode = FBSDKShareDialogModeFeedBrowser;
//    }
    
    dialog.shareContent = content;
    dialog.fromViewController = self;
    [dialog show];
}

- (IBAction)fbPhotoShareButtonPressed:(UIButton *)sender {
    UIImage *image = [UIImage imageNamed:@"Suits"];
    
    FBSDKSharePhoto *photo = [[FBSDKSharePhoto alloc] init];
    photo.image = image;
    photo.userGenerated = YES;
    FBSDKSharePhotoContent *content = [[FBSDKSharePhotoContent alloc] init];
    content.photos = @[photo];
    
    [FBSDKShareDialog showFromViewController:self
                                 withContent:content
                                    delegate:nil];
    
}

- (IBAction)fbVideoShareButtonPressed:(UIButton *)sender {
    
    
    //NSURL *videoURL = [info objectForKey:UIImagePickerControllerReferenceURL];
    NSString *path = [[NSBundle mainBundle]pathForResource:@"emoji zone" ofType:@"mp4"];
    NSURL *videoURL = [NSURL URLWithString:path];
    //NSURL *videoURL = [NSURL URLWithString:@"http://down.treney.com/mov/test.mp4"];
    
    FBSDKShareVideo *video = [[FBSDKShareVideo alloc] init];
    video.videoURL = videoURL;
    FBSDKShareVideoContent *content = [[FBSDKShareVideoContent alloc] init];
    content.video = video;
    
    [FBSDKShareDialog showFromViewController:self
                                 withContent:content
                                    delegate:nil];
}


@end
