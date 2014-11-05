//
//  BrowserViewController.m
//  OFFWeb
//
//  Created by Adrian Lozano on 10/23/14.
//  Copyright (c) 2014 TeamCook. All rights reserved.
//

#import "BrowserViewController.h"

@interface BrowserViewController ()

@end

@implementation BrowserViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadWebsite];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadWebsite
{
    NSURL *url = [NSURL URLWithString:@"https://en.wikipedia.org/wiki/Special:Random"];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.browserWebView loadRequest:requestObj];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)facebookButton:(id)sender {
}

- (IBAction)twitterButton:(id)sender {
}

- (IBAction)saveButton:(id)sender {
}
@end
