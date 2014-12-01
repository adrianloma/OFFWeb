//
//  VideoViewController.m
//  Giornale
//
//  Created by Adrian Lozano on 11/30/14.
//  Copyright (c) 2014 ITESM. All rights reserved.
//

#import "VideoViewController.h"

@interface VideoViewController ()

@end

@implementation VideoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadVideo];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(cambiaOrientacion:)
                                                 name:@"UIDeviceOrientationDidChangeNotification"
                                               object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)cambiaOrientacion:(NSNotification *)notification {
    
    
    UIDeviceOrientation orientation;
    
    //identifica la orientación en la que está el dispositivo
    orientation = [[UIDevice currentDevice] orientation];
    
    switch (orientation) {
        case UIDeviceOrientationFaceUp:
        case UIDeviceOrientationFaceDown:
        case UIDeviceOrientationPortrait:
        case UIDeviceOrientationPortraitUpsideDown:
        case UIDeviceOrientationLandscapeLeft:
        case UIDeviceOrientationLandscapeRight:
        default:
            [self loadVideo];
            break;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)loadVideo {
    //UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(10, 30, 300, 300)];
    
    NSString *embedHTML = [NSString stringWithFormat:@"\
                           <html>\
                           <body style='margin:0px;padding:0px;'>\
                           <script type = 'text/javascript' src='http://www.youtube.com/iframe_api'> </script>\
                           <script type='text/javascript'>\
                           fucntion onYoutubeAPIReady()\
                           {\
                           ytplayer = new YT.Player('playerId', {events:{onReady:onPlayerReady}})\
                           }\
                           function onPlayerReady(a)\
                           {\
                           a.target.playVideo(); \
                           }\
                           </script>\
                           <iframe id='playerId' type='text/html' width=\"%0.0f\" height=\"%0.0f\" src='http://www.youtube.com/%@?enablejsapi=1&rel0&playsinline=1&autoplay=1' frameborder='0' allowfullscreen></iframe>'\
                           </body>\
                           </html>", _webView.frame.size.width, _webView.frame.size.height,@"embed/Ye7BGnlTZmQ"];
    
    
    
    [_webView setAllowsInlineMediaPlayback:YES];
    [_webView setMediaPlaybackRequiresUserAction:YES];
    [_webView loadHTMLString:embedHTML baseURL:nil];
    _webView.scalesPageToFit = NO;
    [self.view addSubview:_webView];
    
    
}

- (IBAction)backButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
